infile = '../_site/cv/index.html'
outfile = '../_site/cv/tmp.html'

with open(infile, 'r') as f, open(outfile, 'w') as g:
	for line in f:
		if '?.' in line:
			line = line.replace('?.', '?')
		if 'dx.doi.org' in line:
			line = line.replace('>http://dx.doi.org/', '>')
		g.write(line)
