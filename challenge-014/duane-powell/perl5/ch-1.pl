#!/usr/bin/env perl
use strict;
use warnings;

#https://perlweeklychallenge.org/blog/perl-weekly-challenge-014/
#Write a script to generate Van Eck’s sequence starts with 0. For more information, 
#please check out wikipedia page. https://en.wikipedia.org/wiki/Van_Eck%27s_sequence
#This challenge was proposed by team member Andrezgz.

my $max;
my $valid_input = 0;
while (not $valid_input) {
	print qq[Van_Eck iterations? ];
	chomp ($max = <STDIN>);
	next unless ($max =~ /^[0-9]*$/);  
	$valid_input = 1;
}

my @Van_Eck_seq = (0);
my $i = 0;
for (my $n=0; $n <= $max; $n++) {
	$Van_Eck_seq[++$i] = 0; #set next in seq to 0 unless we find a previous m = n
	#were looking for the largest m, so search backwards from m=n-1 to 0
	for (my $m=$n-1; $m >=0; $m--) {
		if ($Van_Eck_seq[$n] == $Van_Eck_seq[$m]) {
			$Van_Eck_seq[$i] = $n-$m;
			last;
		}
	}
}

print "$_, " foreach @Van_Eck_seq;

__END__

In recreational mathematics van Eck's sequence is an Van_Eck_seqeger sequence defined recursively as follows. 
Let a0 = 0. Then, for n ≥ 0, if there exists an m < n such that am = an, take the largest such m and set an+1 = n − m; otherwise an+1 = 0. 
Thus the first occurrence of an Van_Eck_seqeger in the sequence is followed by a 0, and the second and subsequent occurrences are followed
by the size of the gap between the two most recent occurrences.

./ch1.pl 
Van_Eck iterations? 17
0, 0, 1, 0, 2, 0, 2, 2, 1, 6, 0, 5, 0, 2, 6, 5, 4, 0, 5,


