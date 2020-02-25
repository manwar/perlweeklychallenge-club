#!/usr/bin/perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-044/
# Task #2
# Make it $200
# You have only $1 left at the start of the week.
# You have been given an opportunity to make it $200.
# The rule is simple with every move you can either double what you have or add another $1.
# Write a script to help you get $200 with the smallest number of moves.

use strict;
use warnings;

# an upper bound of moves to check
use constant MOVES_LIMIT => 10;

my @solution;

# A binary number is used to get a particular combination
#  for each of the moves to check
#
# The combination defines a serie of operations (add 1 or multiply by 2)
# Each one of them updates the value for the next operation.

foreach my $n ( 0 .. (2 ** MOVES_LIMIT)-1 ) {
    my @ops = map { $_ ? '+ 1' : '* 2'} split //, sprintf("%b", $n);

    my $value = 1;
    $value = eval($value . $_) for (@ops);

    if ($value == 200) {
        @solution = @ops;
        last;
    }
}

# beautified solution printing
my $value = 1;
print $value . $/;
foreach (@solution) {
    $value = eval($value . $_);
    print $_.' = '. $value . $/;
}

__END__
./ch-2.pl
1
+ 1 = 2
+ 1 = 3
* 2 = 6
* 2 = 12
* 2 = 24
+ 1 = 25
* 2 = 50
* 2 = 100
* 2 = 200
