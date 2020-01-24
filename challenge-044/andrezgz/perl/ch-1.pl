#!/usr/bin/perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-044/
# Task #1
# Only 100, please.
# You are given a string "123456789".
# Write a script that would insert "+" or "-" in between digits
# so that when you evaluate, the result should be 100.

use strict;
use warnings;

my @digits = split //, '123456789';
my $initial = shift @digits;

my @values = ( '' , ' + ' , ' - ' );

# A number in base 3 is used to get a particular combination
#  for each of the 8 positions between the 9 digits
# The combination is left padded with zeros to get exactly 8 digits for lower numbers
#
# The 8 digits from a combination define an equation
#  translating each one to its value: +, - or '' (empty)
#  and concatenating it with the corresponding digit from the given number

foreach my $n (0 .. (3**8)-1) {
    my $equation = $initial;
    my @combination = split //, sprintf "%08d", to_base3($n);
    $equation .= $values[ $combination[$_] ] . $digits[$_] for (0 .. @digits - 1);
    print "$equation\n" if (eval $equation == 100);
}


sub to_base3 {
    my ($n) = @_;
    return 0 if ($n == 0);

    my $result;
    while ($n > 0) {
        $result .= $n % 3;
        $n = int($n / 3);
    }
    # force scalar context to assure returning a reversed string
    return scalar reverse $result;
}

__END__

./ch-1.pl
123 + 45 - 67 + 8 - 9
123 + 4 - 5 + 67 - 89
123 - 45 - 67 + 89
123 - 4 - 5 - 6 - 7 + 8 - 9
12 + 3 + 4 + 5 - 6 - 7 + 89
12 + 3 - 4 + 5 + 67 + 8 + 9
12 - 3 - 4 + 5 - 6 + 7 + 89
1 + 23 - 4 + 56 + 7 + 8 + 9
1 + 23 - 4 + 5 + 6 + 78 - 9
1 + 2 + 34 - 5 + 67 - 8 + 9
1 + 2 + 3 - 4 + 5 + 6 + 78 + 9

