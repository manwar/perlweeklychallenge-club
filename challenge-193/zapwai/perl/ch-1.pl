#!/usr/bin/env perl
my $n = $ARGV[0] || 3;
die ("Not positive enough") if $n < 1;
my $N = 2**$n - 1;
my $ops = "%0".$n."b, ";
print "Input: \$n = $n\n";
print "Output: ";
printf $ops, $_ for 0..$N-1;
printf "%0".$n."b", $N;
print "\n";
