#!/usr/bin/env perl
#
=head1 Task 1: Duplicate Removals

Submitted by: Mohammad Sajid Anwar

You are given a string, $str, consisting of lowercase English letters.

Write a script to return the final string after all duplicate removals have
been made. Repeat duplicate removals on the given string until we no longer
can.

    A duplicate removal consists of choosing two adjacent and equal letters and
    removing them.

=head2 Example 1

    Input: $str = 'abbaca'
    Output: 'ca'

    Step 1: Remove 'bb' => 'aaca'
    Step 2: Remove 'aa' => 'ca'

=head2 Example 2

    Input: $str = 'azxxzy'
    Output: 'ay'

    Step 1: Remove 'xx' => 'azzy'
    Step 2: Remove 'zz' => 'ay'

=head2 Example 3

    Input: $str = 'aaaaaaaa'
    Output: ''

    Step 1: Remove 'aa' => 'aaaaaa'
    Step 2: Remove 'aa' => 'aaaa'
    Step 3: Remove 'aa' => 'aa'
    Step 4: Remove 'aa' => ''

=head2 Example 4

    Input: $str = 'aabccba'
    Output: 'a'

    Step 1: Remove 'aa' => 'bccba'
    Step 2: Remove 'cc' => 'bba'
    Step 3: Remove 'bb' => 'a'

=head2 Example 5

    Input: $str = 'abcddcba'
    Output: ''

    Step 1: Remove 'dd' => 'abccba'
    Step 2: Remove 'cc' => 'abba'
    Step 3: Remove 'bb' => 'aa'
    Step 4: Remove 'aa' => ''

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    ['abbaca',   'ca', 'Example 1'],
    ['azxxzy',   'ay', 'Example 2'],
    ['aaaaaaaa', '',   'Example 3'],
    ['aabccba',  'a',  'Example 4'],
    ['abcddcba', '',   'Example 5'],
];

sub duplicate_removals
{
    my $str = shift;

    while ($str =~ s/(.)\1//g) {
    }
    return $str;
}

for (@$cases) {
    is(duplicate_removals($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
