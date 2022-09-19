#!/usr/bin/perl

=head1

Week 180:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-180

Task #1: First Unique Character

    You are given a string, $s.

    Write a script to find out the first unique character in the
    given string and print its index (0-based).

=cut

use v5.36;
use Test2::V0;

is first_unique_character('Perl Weekly Challenge'), 0, 'Example 1';
is first_unique_character('Long Live Perl'),        1, 'Example 2';

done_testing;

#
#
# METHOD

sub first_unique_character($str) {
    my @c = ();
    my %c = ();
    foreach my $c (split //, $str) {
        next if $c eq ' ';
        $c = lc $c;
        if (exists $c{$c}) {
            $c{$c}++;
        }
        else {
            push @c, $c;
            $c{$c} = 1;
        }
    }

    my $i = 0;
    foreach my $c (@c) {
        if ($c{$c} == 1) {
            return $i;
        }
        $i++;
    }
}
