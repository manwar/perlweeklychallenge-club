#!/usr/bin/env perl
#
=head1 Task 2: Spellbound Sorting

Submitted by: Peter Campbell Smith

You are given an array of integers.  Write a script to return them in
alphabetical order, in any language of your choosing. Default language is
English.

=head2 Example 1

    Input: (6, 7, 8, 9 ,10)
    Output: (8, 9, 7, 6, 10)

    eight, nine, seven, six, ten

=head2 Example 2

    Input: (-3, 0, 1000, 99)
    Output: (-3, 99, 1000, 0)

    minus three, ninety-nine, one thousand, zero

=head2 Example 3

    Input: (1, 2, 3, 4, 5)

    Output: (5, 2, 4, 3, 1) for French language
    cinq, deux, quatre, trois, un

    Output: (5, 4, 1, 3, 2) for English language
    five, four, one, three, two

=head2 Example 4

    Input: (0, -1, -2, -3, -4)
    Output: (-4, -1, -3, -2, 0)

    minus four, minus one, minus three, minus two, zero

=head2 Example 5

    Input: (100, 101, 102)
    Output: (100, 101, 102)

    one hundred, one hundred and one, one hundred and two

=cut

use strict;
use warnings;
use v5.42.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my $cases = [
    [[  6,   7,    8,  9, 10], [  8,   9,    7,  6, 10], 'Example 1'],
    [[ -3,   0, 1000, 99],     [ -3,  99, 1000,  0],     'Example 2'],
    [[  1,   2,    3,  4,  5], [  5,   4,    1,  3,  2], 'Example 3'],
    [[  0,  -1,   -2, -3, -4], [ -4,  -1,   -3, -2,  0], 'Example 4'],
    [[100, 101,  102],         [100, 101,  102],         'Example 5'],
];

sub spellbound_sorting
{
    sub int2word
    {
        my $num = shift;

        my @units = qw(zero one two three four five six seven eight nine);
        my @teens = qw(ten eleven twelve thirteen fourteen fifteen sixteen seventeen eighteen nineteen);
        my @tens  = qw(zero ten twenty thirty forty fifty sixty seventy eighty ninety);
        my @scales = qw(zero thousand million billion trillion);

        if ($num < 0) {
            return 'minus ' . int2word(-$num);
        } elsif ($num < 10) {
            return $units[$num];
        } elsif ($num < 20) {
            return $teens[$num - 10];
        } elsif ($num < 100) {
            return $tens[int($num / 10)] . ($num % 10 ? '-' . $units[$num % 10] : '');
        } elsif ($num < 1000) {
            return $units[int($num / 100)] . ' hundred' . ($num % 100 ? ' and ' . int2word($num % 100) : '');
        } else {
            my $scale_index = int(log($num) / log(1000));
            my $scale_value = 1000 ** $scale_index;
            return int2word(int($num / $scale_value)) . ' ' . $scales[$scale_index] . ($num % $scale_value ? ' ' . int2word($num % $scale_value) : '');
        }
    }

    my $ints = shift;

    my @words = map { int2word($_) } @$ints;

    return [ $ints->@[ sort { $words[$a] cmp $words[$b] } 0 .. $#$ints ] ];
}

for (@$cases) {
    is(spellbound_sorting($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
