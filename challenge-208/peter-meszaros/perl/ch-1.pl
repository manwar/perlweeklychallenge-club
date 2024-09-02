#!/usr/bin/env perl
#
=head1 Task 1: Minimum Index Sum

Submitted by: Mohammad S Anwar

You are given two arrays of strings.

Write a script to find out all common strings in the given two arrays with
minimum index sum. If no common strings found returns an empty list.

=head2 Example 1

    Input: @list1 = ("Perl", "Raku", "Love")
           @list2 = ("Raku", "Perl", "Hate")

    Output: ("Perl", "Raku")

    There are two common strings "Perl" and "Raku".
    Index sum of "Perl": 0 + 1 = 1
    Index sum of "Raku": 1 + 0 = 1

=head2 Example 2

    Input: @list1 = ("A", "B", "C")
           @list2 = ("D", "E", "F")

    Output: ()

    No common string found, so no result.

=head2 Example 3

    Input: @list1 = ("A", "B", "C")
           @list2 = ("C", "A", "B")

    Output: ("A")

    There are three common strings "A", "B" and "C".
    Index sum of "A": 0 + 1 = 1
    Index sum of "B": 1 + 2 = 3
    Index sum of "C": 2 + 0 = 2

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use List::MoreUtils qw/duplicates/;
use List::Util qw/min/;

my $cases = [
    [[["Perl", "Raku", "Love"],
      ["Raku", "Perl", "Hate"]],
     ["Perl", "Raku"], 'Example 1'],
    [[["A", "B", "C"],
      ["D", "E", "F"]],
     undef,            'Example 2'],
    [[["A", "B", "C"],
      ["C", "A", "B"]],
     ["A"],            'Example 3'],
];

sub _index_of_first
{
    my $l = shift;
    my $v = shift;

    for my $i (0 .. $#$l) {
        return $i if $v eq $l->[$i];
    }
    return undef;
}

sub minimum_index_sum
{
    my $l1 = $_[0]->[0];
    my $l2 = $_[0]->[1];

    my %d = map {$_ => undef} duplicates(@$l1, @$l2);
    return undef unless %d;

    my $min = 0;
    for my $d (keys %d) {
        $d{$d} = _index_of_first($l1, $d) + _index_of_first($l2, $d);
    }

    my $min_idx = min values %d;
    return [sort grep { $d{$_} == $min_idx } keys %d];
}

for (@$cases) {
    is(minimum_index_sum($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
