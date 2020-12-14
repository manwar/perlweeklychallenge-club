#!/usr/bin/perl
# The Weekly Challenge 090
# Task 2: Ethiopian Multiplication
use strict;
use warnings;

my ($a,$b) = (14, 16);   # default value
($a, $b) = ($ARGV[0], $ARGV[1]) if $ARGV[1];
my @em_a = ($a);
my @em_b = ($b);

my $i = 0;
while ($em_a[-1] != 1) {
    printf "%7d", $em_a[$i];
    printf "%7d", $em_b[$i];
    print "   *" if $em_a[$i] % 2 == 1;
    $em_a[$i+1] = int ($em_a[$i]/2);
    $em_b[$i+1] = $em_b[$i]*2;
    $i++;
    print "\n";
}

printf "%7d%7d   *\n\n", $em_a[$i], $em_b[$i];

my $sum = 0;
print "SUMMATION from:\n";
for (0..$i) {
    if ($em_a[$_] % 2 == 1) {
        $sum += $em_b[$_];
        printf "%7d\n", $em_b[$_];
    }
}

print "_______\n";
printf "%7d\n", $sum;

