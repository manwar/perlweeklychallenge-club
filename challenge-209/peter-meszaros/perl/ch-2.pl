#!/usr/bin/env perl
#
=head1 Task 2: Merge Account

Submitted by: Mohammad S Anwar

You are given an array of accounts i.e. name with list of email addresses.

Write a script to merge the accounts where possible. The accounts can only be
merged if they have at least one email address in common.

=head2 Example 1:

    Input: @accounts = [ ["A", "a1@a.com", "a2@a.com"],
                         ["B", "b1@b.com"],
                         ["A", "a3@a.com", "a1@a.com"] ]
                       ]

    Output: [ ["A", "a1@a.com", "a2@a.com", "a3@a.com"],
              ["B", "b1@b.com"] ]

=head2 Example 2:

    Input: @accounts = [ ["A", "a1@a.com", "a2@a.com"],
                         ["B", "b1@b.com"],
                         ["A", "a3@a.com"],
                         ["B", "b2@b.com", "b1@b.com"] ]

    Output: [ ["A", "a1@a.com", "a2@a.com"],
              ["A", "a3@a.com"],
              ["B", "b1@b.com", "b2@b.com"] ]

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use List::MoreUtils qw/duplicates uniq/;

my $cases = [
    [[['A', 'a1@a.com', 'a2@a.com'],
      ['B', 'b1@b.com'],
      ['A', 'a3@a.com', 'a1@a.com']],
     [['A', 'a1@a.com', 'a2@a.com', 'a3@a.com'],
      ['B', 'b1@b.com']], 'Example 1'],

    [[['A', 'a1@a.com', 'a2@a.com'],
      ['B', 'b1@b.com'],
      ['A', 'a3@a.com'],
      ['B', 'b2@b.com', 'b1@b.com']],
     [['A', 'a1@a.com', 'a2@a.com'],
      ['A', 'a3@a.com'],
      ['B', 'b1@b.com', 'b2@b.com']], 'Example 2'],
];

sub merge_account
{
    my $loa = shift; # list of accounts

    my @res = $loa->[0];

    for my $i (1 .. $#$loa) {
        my ($id1, @l1) = $loa->[$i]->@*;
        my $join = 1;
        for my $j (0 .. $#res) {
            my ($id2, @l2) = $res[$j]->@*;
            if ($id1 eq $id2 && duplicates(@l1, @l2)) {
                push $res[$j]->@*, @l1;
                $res[$j] = [uniq sort $res[$j]->@*];
                $join = 0;
                last;
            }
        }
        push @res, $loa->[$i] if $join;
    }
    return [sort {$a->[0] cmp $b->[0]} @res];
}

for (@$cases) {
    is(merge_account($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
