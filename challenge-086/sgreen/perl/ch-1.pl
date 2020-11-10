#!/usr/bin/env perl

use strict;
use warnings;
use feature qw(say);

sub main {
    my @numbers = @_;

    # Check all values are numbers and we have at least three
    die "You must specify at least three values\n" unless scalar(@numbers) >= 3;
    foreach my $v (@numbers) {
        die "Value '$v' is not an integer\n" unless $v =~ /^-?[0-9]+$/;
    }

    # The last number is the target
    my $target = pop @numbers;

    foreach my $first_pos ( 0 .. $#numbers ) {
        my $first_num = $numbers[$first_pos];
        foreach my $second_pos ( 0 .. $#numbers ) {
            my $second_num = $numbers[$second_pos];
            if (   $first_pos != $second_pos
                && $first_num - $second_num == $target )
            {
                say "Output: 1 as $first_num - $second_num = $target";
                return;
            }
        }
    }

    # There is no possible solution
    say "Output: 0";
}

main(@ARGV);
