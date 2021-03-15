#!/usr/bin/perl
use warnings;
use strict;

sub pattern_match {
    my ($string, $pattern) = @_;
    return 1 if "" eq $string . $pattern;

    my ($string_first,  $string_rest)  = $string  =~ /(.)(.*)/;
    my ($pattern_first, $pattern_rest) = $pattern =~ /(.)(.*)/;

    my $action = {
        '?' => sub {
            return 0 unless length $pattern;
            return pattern_match($string_rest, $pattern_rest)
        },
        '*' => sub {
            for my $pos (1 .. length $string) {
                return 1
                    if pattern_match(substr($string, $pos), $pattern_rest);
            }
            return 0
        },
    }->{ $pattern_first // "" } || sub {
        return 0 if ($pattern_first // "") ne ($string_first // "");

        return pattern_match($string_rest, $pattern_rest)
    };
    return $action->()
}

use Test::More tests => 8;

is pattern_match('abcde', 'a*e'),   1, 'Example 1';
is pattern_match('abcde', 'a*d'),   0, 'Example 2';
is pattern_match('abcde', '?b*d'),  0, 'Example 3';
is pattern_match('abcde', 'a*c?e'), 1, 'Example 4';

is pattern_match('abcde', 'a*'),    1, 'Trailing star';
is pattern_match('abcde', '*de'),   1, 'Leading star';
is pattern_match('abcde', 'a*c*e'), 1, 'Two stars';
is pattern_match('(a!)b{c}$1d', '(?!)b{?}$1*'), 1, 'Random garbage';
