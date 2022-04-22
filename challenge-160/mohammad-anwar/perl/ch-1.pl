#!/usr/bin/env perl

=head1

Week 160:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-160

Task #1: Four Is Magic

    You are given a positive number, $n < 10.

    Write a script to generate english text sequence starting with the English cardinal representation of the given number, the word ‘is’ and then the English cardinal representation of the count of characters that made up the first word, followed by a comma. Continue until you reach four.

=cut

use strict;
use warnings;
use Test::More;

is four_magic(5), 'Five is four, four is magic.', 'Example 1';
is four_magic(7), 'Seven is five, five is four, four is magic.', 'Example 2';
is four_magic(6), 'Six is three, three is five, five is four, four is magic.', 'Example 3';

done_testing;

#
#
# METHOD

sub four_magic {
    my ($n) = @_;

    die "ERROR: Missing number.\n"      unless defined $n;
    die "ERROR: Invalid number [$n].\n" unless ($n >=0 and $n < 10);

    my %name_of = (0, 'zero',  1, 'one',
                   2, 'two',   3, 'three',
                   4, 'four',  5, 'five',
                   6, 'six',   7, 'seven',
                   8, 'eight', 9, 'nine');

    my @str = ();
    while (1) {
        my $name = $name_of{$n};
        my $len  = length($name);
        push @str, "$name is $name_of{$len}";
        last if ($len == 4);
        $n = length($name);
    }

    push @str, 'four is magic.';

    return ucfirst(join(', ', @str));
}
