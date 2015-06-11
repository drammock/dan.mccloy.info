---
layout: post
title:  "Git cheat sheet"
date: 2013-11-02 22:22:22
---

For my first blog post, I’m sharing the Git commands I use most often when setting up a new project.  This is mostly here for my own benefit in forgetful moments, but others might find it useful too.

# Initial setup
{% highlight bash %}
git clone git@github.com:username/NameOfRepo.git
{% endhighlight %}
If NameOfRepo.git was a fork, set the upstream:
{% highlight bash %}
git remote add upstream git@github.com:UpstreamUsername/NameOfRepo.git
{% endhighlight %}

# pull down all remote branches
{% highlight bash %}
git fetch upstream  # the upstream
git fetch origin  # my fork of the upstream
{% endhighlight %}

# changing remote url 
{% highlight bash %}
git remote set-url origin https://github.com/username/NewRepoName.git
{% endhighlight %}
(So far I’ve only ever used this to switch from https to ssh, or to correct a mistake in a prior `git remote add ...` step.)

# testing other peoples’ pull requests before merging
{% highlight bash %}
git fetch SomeoneElsesUsername/branchname  
{% endhighlight %}
(exclude /branchname to get all of their branches)

{% highlight bash %}
git checkout -b somename SomeoneElsesUsername/branchname 
{% endhighlight %}
now run nosetests, etc.

# rebasing
{% highlight bash %}
git fetch upstream
git checkout theBranchYouWantToRebase
git rebase upstream/master
{% endhighlight %}
You can rebase against any branch you want, but upstream/master is most common.  If there are conflicts, repeat the following two lines as necessary:

{% highlight bash %}
git mergetool
git rebase --continue
{% endhighlight %}

After all conflicts have been resolved:
{% highlight bash %}
git push --force origin theBranchThatYouJustRebased
{% endhighlight %}

# deleting remote branches
{% highlight bash %}
git branch -rd origin/nameOfBranchToDelete
git push origin --delete nameOfBranchToDelete
{% endhighlight %}
(The first line usually works; sometimes when it didn’t I’ve had luck with the second.)

# untracking a file
{% highlight bash %}
# remove a file from local, and from remote on next push:
git rm nameOfFileToDelete
# keep local file but stop tracking it; delete it from remote on next push
git rm --cached nameOfFileToStopTrackingAndDeleteRemoteCopyButKeepLocal
# keep local file and remote file, but ignore any local changes to it
git update-index --assume-unchanged nameOfFileToStopTrackingWithoutDeleting
{% endhighlight %}
