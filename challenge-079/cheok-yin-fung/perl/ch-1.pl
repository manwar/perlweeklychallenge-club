#!/usr/bin/perl
# Perl Weekly Challenge #079 Task 1
use strict;
use warnings;
use List::Util qw/sum/;
use feature qw/say/;

my $N;
if ($ARGV[0]) {$N = $ARGV[0];} else {$N = 50;}

my $ans = 0;  #initialize
for (1..$N) {
    $ans += sum split //, (sprintf "%0b", $_);
}
say $ans % 1000000007;
