#!/usr/bin/env perl
#
=head1 Task 2: Changing Keys
Submitted by: Mohammad Sajid Anwar
You are given an alphabetic string, $str, as typed by user.
Write a script to find the number of times user had to change the key to type
the given string. Changing key is defined as using a key different from the
last used key. The shift and caps lock keys won't be counted.
=head2 Example 1
    Input: $str = 'pPeERrLl'
    Ouput: 3
    p -> P : 0 key change
    P -> e : 1 key change
    e -> E : 0 key change
    E -> R : 1 key change
    R -> r : 0 key change
    r -> L : 1 key change
    L -> l : 0 key change
=head2 Example 2
    Input: $str = 'rRr'
    Ouput: 0
=head2 Example 3
    Input: $str = 'GoO'
    Ouput: 1
=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    ['pPeERrLl', 3, 'Example 1'],
    ['rRr',      0, 'Example 2'],
    ['GoO',      1, 'Example 3'],
];

sub changing_keys
{
    my $str = shift;

    my @str = split '', lc($str);
    my $cnt = 0;

    for my $i (1 .. $#str) {
        ++$cnt if $str[$i] ne $str[$i-1];
    }

    return $cnt;
}

for (@$cases) {
    is(changing_keys($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
