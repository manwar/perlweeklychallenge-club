# Solution by Jaime Corchado, (@tortsnare)[https://twitter.com/tortsnare].
# 
# Challenge #1
# 
# Write a script to generate Van Eck’s sequence.

my @ecks = (0);
print "0\n"; # start the sequence.

for (my $n = 0; ; $n++) {
    $a1 = 0;
    $an = shift @ecks;

    my $m = 1; # the distance between matching entries.
    for my $am (@ecks) {
	if ($an == $am) {
	    $a1 = $m;
	    last; # only update with most recent entry.
	}
    } continue { $m++; }

    unshift @ecks, $an;
    unshift @ecks, $a1; # series is stored in reverse.

    print "@ecks[0]\n"; # filter series with `perl ch-1.pl | head -n $LENGTH`
}
