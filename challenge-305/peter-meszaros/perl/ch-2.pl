#!/usr/bin/env perl
#
=head1 Task 2: Alien Dictionary

Submitted by: Mohammad Sajid Anwar

You are given a list of words and alien dictionary character order.

Write a script to sort lexicographically the given list of words based on the
alien dictionary characters.

=head2 Example 1

    Input: @words = ("perl", "python", "raku")
           @alien = qw/h l a b y d e f g i r k m n o p q j s t u v w x c z/
    Output: ("raku", "python", "perl")

=head2 Example 2

    Input: @words = ("the", "weekly", "challenge")
           @alien = qw/c o r l d a b t e f g h i j k m n p q s w u v x y z/
    Output: ("challenge", "the", "weekly")

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    [[["perl", "python", "raku"],
      [qw/h l a b y d e f g i r k m n o p q j s t u v w x c z/]],
     ["raku", "python", "perl"], 'Example 1'],
    [[["the",  "weekly", "challenge"],
      [qw/c o r l d a b t e f g h i j k m n p q s w u v x y z/]],
     ["challenge", "the", "weekly"], 'Example 2'],
];

sub alien_dictionary
{
    my $l = $_[0]->[0];
    my $d = $_[0]->[1];

    my %d = map { $d->[$_] => $_ } 0 .. $#$d;

    my $ret = [sort {
        my $i = 0;
        while ($i < length($a) && $i < length($b)) {
            my $ai = $d{substr($a, $i, 1)};
            my $bi = $d{substr($b, $i, 1)};
            return $ai <=> $bi if $ai != $bi;
            $i++;
        }
        return length($a) <=> length($b);
    } @$l];

    return $ret;
}

for (@$cases) {
    is(alien_dictionary($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
