#!/usr/bin/env perl
#
=head1 Task 1: Count Common

You are given two array of strings, @words1 and @words2.

Write a script to return the count of words that appears in both arrays exactly
once.

=head2 Example 1

    Input: @words1 = ("Perl", "is", "my", "friend")
           @words2 = ("Perl", "and", "Raku", "are", "friend")
    Output: 2

The words "Perl" and "friend" appear once in each array.

=head2 Example 2

    Input: @words1 = ("Perl", "and", "Python", "are", "very", "similar")
           @words2 = ("Python", "is", "top", "in", "guest", "languages")
    Output: 1

=head2 Example 3

    Input: @words1 = ("Perl", "is", "imperative", "Lisp", "is", "functional")
           @words2 = ("Crystal", "is", "similar", "to", "Ruby")
    Output: 0

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    [[["Perl", "is", "my", "friend"],
      ["Perl", "and", "Raku", "are", "friend"]
     ], 2],
    [[["Perl", "and", "Python", "are", "very", "similar"],
      ["Python", "is", "top", "in", "guest", "languages"]
     ], 1],
    [[["Perl", "is", "imperative", "Lisp", "is", "functional"],
      ["Crystal", "is", "similar", "to", "Ruby"]
     ], 0],
];

sub count_common
{
    my $w1 = $_[0]->[0];
    my $w2 = $_[0]->[1];

    my %h;
    for (@$w1) {
        if (exists $h{$_}) {
           $h{$_} = -1; 
        } else {
           $h{$_}++;
        }
    }
    for (@$w2) {
        $h{$_}++ if exists $h{$_} and $h{$_} == 1;
    }

    return scalar grep {$_ == 2} values %h;
}

for (@$cases) {
    is(count_common($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
