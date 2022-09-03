#!/usr/bin/env raku

=begin pod

Week 180:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-180

Task #1: First Unique Character

    You are given a string, $s.

    Write a script to find out the first unique character in the
    given string and print its index (0-based).

=end pod

use Test;

is first-unique-character('Perl Weekly Challenge'), 0, 'Example 1';
is first-unique-character('Long Live Perl'),        1, 'Example 2';

done-testing;

#
#
# METHOD

sub first-unique-character(Str $str --> Int) {
    my Str @c = ();
    my     %c = ();
    for $str.comb {
        my $c = $_;
        next if $c eq ' ';
        $c = $c.lc;
        if %c{$c}:exists {
            %c{$c}++;
        }
        else {
            @c.push: $c;
            %c{$c} = 1;
        }
    }

    my Int $i = 0;
    for @c -> $c {
        if %c{$c} == 1 {
            return $i;
        }
        $i++;
    }
}
