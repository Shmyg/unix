# Sed script for converting bank statement where a transaction is split into
# several rows. Joins every transaction to be shown on a single line
# Created by Shmyg

/^[[:digit:]]\{2\}\.[[:digit:]]\{2\}\.[[:digit:]]\{2,4\}.*[[:digit:]]\{14\}.*/{
	x
	s/\n/ /g
	s/\([[:digit:]]\{1,\}\)\.\([[:digit:]]\{2\}\) грн\./\1\,\2 грн\./g
	s/\([[:digit:]]\{2\}\)\.\([[:digit:]]\{2\}\)[[:space:]]\{1,\}\([[:digit:]]\{2,4\}\)/\1\2\3/2
	s/^\([[:digit:]]\{2\}\.[[:digit:]]\{2\}\.[[:digit:]]\{2,4\}\) \([[:digit:]]\{14\}\) \([[:digit:]]\{6\}\) \([[:digit:]]\{8,10\}\) \(.*\) \([[:digit:]]\{1,\}\.[[:digit:]]\{2\}\) \(.*\)/\1;\2;\3;\4;\5;\6;\7/
	p
	x
	h
	d
}
/^[[:digit:]]\{2\}\..*[[:digit:]]\{14\}.*/!{
	H
	d
}
