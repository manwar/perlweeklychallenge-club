#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub valid_number($str) {
    return $str =~ /^(?:([-+](?=.)) ?              # Leading sign.
                       (?:0? | [1-9][0-9]*)        # Zero or non-zero integer.
                       (?:(?<=[0-9])\.             # Final dot after something.
                         | \.[0-9]+) ?             # Dot followed by digits.
                       (?:(?<=[^+-])[eE]           # Exponent.
                           (?:[-+](?=[1-9]))?      # Signed non-0.
                           (0 | [1-9][0-9]*)) ?    # Zero on non-zero int.
                    )$/x ? 1 : 0
}

use Test::More tests => 7 + 10;

is valid_number('1'), 1, 'Example 1';
is valid_number('a'), 0, 'Example 2';
is valid_number('.'), 0, 'Example 3';
is valid_number('1.2e4.2'), 0, 'Example 4';
is valid_number('-1.'), 1, 'Example 5';
is valid_number('+1E-8'), 1, 'Example 6';
is valid_number('.44'), 1, 'Example 7';

is valid_number('0'), 1, 'Zero';
is valid_number('e1'), 0, 'e1';
is valid_number('0.00'), 1, 'Zeros';
is valid_number('-'), 0, 'sign without digits';
is valid_number('-.'), 0, 'sign without digits';
is valid_number('2.e-0'), 0, 'exponent -0';
is valid_number('.e2'), 0, '.e';
is valid_number('01'), 0, 'Leading 0';
is valid_number('.1e03'), 0, 'Exponent leading 0';
is valid_number('.1e+03'), 0, 'Exponent leading 0 signed';

use Scalar::Util qw{ looks_like_number };
for (1 .. 1_000_000) {
    my $s = join "", map qw( 0 1 2 e E . + -)[rand 8], 0 .. rand 9;
    print "random $s ", valid_number($s), "\n"
        if !!valid_number($s) != looks_like_number($s)
        # These are valid number for Perl, but not for us:
        && looks_like_number($s)
        && $s !~ /^[-+]?0[0-9]                # Leading 0.
                  | [eE](?:[-+]0 | 0[0-9])    # e-0, e01 (but e0 is ok)
                 /x;
}
