---
layout: post
title:  "Git submodules"
date: 2015-06-12 00:00:00
---
Recently I set up the [PHOIBLE development repos](https://github.com/phoible) to be a bit more flexible and extensible for future needs. This required setting up [submodules](http://git-scm.com/book/en/v2/Git-Tools-Submodules) in git.<more /> Here are some notes on how that works:

1. **Both repos must already exist.** If either the parent or the child module doesn’t exist yet, create it first. Here the two repos are called “dev” and “data”, and we’ll be nesting “data” inside of “dev”.

2. **Create the submodule.** In the local clone of “dev”: `git submodule add git@github.com:phoible/data.git`.  This creates the submodule in _detached head state_, meaning it is not actually “on” a branch, and changes made to files in `dev/data` won’t be tracked.
    - *Note:* if we had wanted to control the specific path of the submodule, we could add it to the end of the command, like: `git submodule add git@github.com:phoible/data.git nest/in/folder/called/datums`.

3. **Change some settings.** In the parent repo:
    - `git config status.submodulesummary 1` makes it so that `git status` will include changes to submodules.
    - `git config diff.submodule log` makes it so that `git diff` will show a list of submodule commit messages instead of just the previous and current commit hashes.

    Either one of these can take the `--global` flag.

4. **Get the submodule onto a branch.** This is as simple as `cd data; git checkout master`. Now the submodule is set up to track local changes, not just sit there as a snapshot of the upstream version of `data`.

5. **Decide what to do when local submodule changes conflict with remote changes.** Normally, submodules are the kind of thing that you might change while working on your project, but other people might change upstream too. In setups like that, you can run `cd data; git fetch; git pull origin/master` to pull in upstream changes to the `data` submodule. Alternatively, you can run `git submodule update --remote` _from the parent repo_ to pull in upstream changes (defaults to pulling `master`, but you can change that in the .gitmodules config file).

    If you’ve made local changes to `data`, you need to tell git what to do when you try to pull in upstream changes. Do this by adding a flag to the `git submodule update --remote` command: either `--merge` (to merge remote changes on top of your local ones) or `--rebase` (to rewind your changes, apply remote changes, then replay your changes afterward). If you have local changes and _don’t_ specify either `--merge` or `--rebase`, your changes will live on in whatever branch of the submodule you made them in, but the submodule will revert to _detached head state_ before applying the remote changes.

    In the case of PHOIBLE, it is expected that all changes to `data` will occur via `dev`, so pulling in upstream changes to `data` should never need to happen. But it would if `data` became a submodule for other repos as well.

6. **Push.** A normal `git push` command in the parent repo will _not_ push submodule changes. A safer version is `git push --recurse-submodules=check` which prevents pushing the parent repo if the submodule(s) are not pushed first. Another option is `git push --recurse-submodules=on-demand` which will try to push the submodules automatically (if necessary) before pushing the parent repo.

Here’s a worked example. First, make some changes to a script in the parent module (not shown), and re-run the script (whose effect is to re-generate files files within the submodule). What does `git status` show us?

```
On branch master
Changes not staged for commit:
  modified:   aggregate.R
  modified:   data (modified content)
```

The important thing to remember is that the changes in the submodule need to be committed _twice_: once within the submodule, and once within the parent. One way to think about this is that the parent repo doesn’t track _changes_ to files in the submodule, but instead tracks _commits in the submodule tree_. The words `modified content` in the status message above mean that things have changed in the submodule, but they aren’t committed to the submodule tree and therefore _cannot be committed in the parent tree yet either_.

For these reasons, I find it easier to commit the changes in the submodule repo first, so that I can use the `-a` flag when committing the changes in the parent repo and it will pick up the submodule commits too:

```sh
cd data
git commit -am 'regenerated the data files after bugfix'
cd ..
```

At this point, `git status` would say something a little different:

```
Changes not staged for commit:
  modified:   aggregate.R
  modified:   data (new commits)

Submodules changed but not updated:
* data bd58f1d...0c9c816 (1):
  > regenerated the data files after bugfix
```

The `new commits` means the submodule changes are now available to be committed within the parent repo:

```sh
git commit -am 'bugfix and associated regenerated data'
```

_Now_ what does `git status` tell us?

```
On branch master
Your branch is ahead of 'origin/master' by 1 commit.
```

That `1 commit` is the parent repo commit, which includes changes to files within the parent repo _and_ changes (i.e., commits) within the submodule. Now we can push, using a special submodule flag: `git push origin master --recurse-submodules=on-demand`

```
Pushing submodule 'data'
To git@github.com:phoible/data.git
bd58f1d..0c9c816  master -> master

To git@github.com:phoible/dev.git
92b3cd5..a11f3f0  master -> master
```

Note that git pushes to the submodule repo first (phoible/data) before pushing the the parent repo (phoible/dev). This would also have worked:

```sh
cd data
git push origin master
cd ..
git push origin master --recurse-submodules=check
```

The last line simply checks to see if we had already pushed the submodule changes, and fails to push if we have not yet done so. This is safer than a plain `git push` when dealing with submodules.
