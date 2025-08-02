#!/usr/bin/perl
use strict;
use warnings;

I tried to find a solution without using the obvious 'sort'.
The solution below is not efficient, but easy to understand and it
does the job well

sub magic_number {

    # define two arrays
    my ($arr_1_ref, $arr_2_ref) = @_;

    # by dereferencing
    my @arr_1 = @$arr_1_ref;
    my @arr_2 = @$arr_2_ref;

    # check if arrays are of the same size
    die "Arrays must be of the same size" unless @arr_1 == @arr_2;

    # more validation tests should be done...I'll leave it to you :-)

    my $magic_number;

    my %differences;

    OUTER: for my $i (0 .. $#arr_1) {

               for my $y (0 .. $#arr_2) {

                   # calculate the difference between elements
                       of the two arrays

                   my $diff = $arr_2[$y] - $arr_1[$i];

                   # if there is a magic number, then its frequency
                        must equal the size of @arr_1 (= length @arr_2)

                   if (++$differences{$diff} == scalar(@arr_1)) {
                       $magic_number = $diff;
                       last OUTER;
                   }
               }
    }

    if (defined $magic_number) {
        print "The magic number is: $magic_number\n";
    } else {
        print "No magic number found\n";
    }
}


# TESTS

my (@x, @y);

# Example 1
@x = (3, 7, 5);
@y = (9, 5, 7);
magic_number(\@x, \@y); # Output: The magic number is: 2
magic_number(\@y, \@x); # Output: The magic number is: -2

# Example 2
@x = (1, 2, 1);
@y = (5, 4, 4);
magic_number(\@x, \@y); # Output: The magic number is: 3
magic_number(\@y, \@x); # Output: The magic number is: -3

# Example 3
@x = (2);
@y = (5);
magic_number(\@x, \@y); # Output: The magic number is: 3
magic_number(\@y, \@x); # Output: The magic number is: -3

# Example 4
@x = (2, 3, 4);
@y = (5, 7, 9);
magic_number(\@x, \@y); # Output: No magic number found
magic_number(\@y, \@x); # Output: No magic number found
