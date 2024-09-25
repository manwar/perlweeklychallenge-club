#!/usr/bin/env perl
#
=head1 Task 1: Strong Password

Submitted by: Mohammad Sajid Anwar

You are given a string, $str.

Write a program to return the minimum number of steps required to make the
given string very strong password. If it is already strong then return 0.

Criteria:

    - It must have at least 6 characters.
    - It must contains at least one lowercase letter, at least one upper case
      letter and at least one digit.
    - It shouldn't contain 3 repeating characters in a row.

Following can be considered as one step:

    - Insert one character
    - Delete one character
    - Replace one character with another

=head2 Example 1

    Input: $str = "a"
    Output: 5

=head2 Example 2

    Input: $str = "aB2"
    Output: 3

=head2 Example 3

    Input: $str = "PaaSW0rd"
    Output: 0

=head2 Example 4

    Input: $str = "Paaasw0rd"
    Output: 1

=head2 Example 5

    Input: $str = "aaaaa"
    Output: 2

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    ['a',         5, 'Example 1'],
    ['aB2',       3, 'Example 2'],
    ['PaaSW0rd',  0, 'Example 3'],
    ['Paaasw0rd', 1, 'Example 4'],
    ['aaaaa',     2, 'Example 5'],
];

sub strong_password {
    my $p = shift;

    my $cnt = 0;

    if ($p !~ /[a-z]/) {
        $p =~ s/(.)\1{2}/$1$1x/ or $p .= 'x';
        ++$cnt;
    }
    if ($p !~ /[A-Z]/) {
        $p =~ s/(.)\1{2}/$1$1X/ or $p .= 'X';
        ++$cnt;
    }
    if ($p !~ /[0-9]/) {
        $p =~ s/(.)\1{2}/$1${1}0/ or $p .= '0';
        ++$cnt;
    }

    while ($p =~ /(.)\1{2}/) {
        $p =~ s/(.)\1{2}/$1 . $1 eq 'x' ? 'y' : 'x' . $1/e;
        ++$cnt;
    }

    if (length($p) < 6) {
        my $c = substr($p, -1, 1) eq 'x' ? 'y' : 'x';
        my $n = 6 - length($p);
        $p .= $c x $n;
        $cnt += $n;
    }

    return $cnt;
}

for (@$cases) {
    is(strong_password($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
