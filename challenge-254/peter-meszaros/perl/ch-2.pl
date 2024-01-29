#!/usr/bin/env perl
#
# You are given a string, $s.
# 
# Write a script to reverse all the vowels (a, e, i, o, u) in the given string.
# Example 1
# 
# Input: $s = "Raku"
# Output: "Ruka"
# 
# Example 2
# 
# Input: $s = "Perl"
# Output: "Perl"
# 
# Example 3
# 
# Input: $s = "Julia"
# Output: "Jaliu"
# 
# Example 4
# 
# Input: $s = "Uiua"
# Output: "Auiu"


use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use List::Util qw/sum/;

my $cases = [
    ['Raku'],
    ['Perl'],
    ['Julia'],
    ['Uiua'],
];

sub reverse_wovels
{
    my $str = shift;

    my $qr = qr/[aeiou]/i;
    my @str = split('', $str);
    $str[0] = lc($str[0]);
    my @w = reverse grep { lc(/$qr/) } @str;
    for (@str) {
        $_ = shift @w if /$qr/;
    }
    $str[0] = uc($str[0]);
    return join('', @str);
}

is(reverse_wovels($cases->[0]->@*), 'Ruka',  'Example 1');
is(reverse_wovels($cases->[1]->@*), 'Perl',  'Example 2');
is(reverse_wovels($cases->[2]->@*), 'Jaliu', 'Example 3');
is(reverse_wovels($cases->[3]->@*), 'Auiu',  'Example 4');
done_testing();

exit 0;

         
