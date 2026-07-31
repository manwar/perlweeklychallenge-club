#!/usr/bin/env perl
#
=head1 Task 1: Similar List

Submitted by: Mohammad Sajid Anwar

You are given three list of strings.  Write a script to find out if the first
two list are similar with the help the third list. The third list contains the
similar words map.

=head2 Example 1

    Input: $list1 = ("great", "acting")
           $list2 = ("fine", "drama")
           $list3 = (["great", "fine"], ["acting", "drama"])
    Output: true

=head2 Example 2

    Input: $list1 = ("apple", "pie")
           $list2 = ("banana", "pie")
           $list3 = (["apple", "peach"], ["peach", "banana"])
    Output: false

=head2 Example 3

    Input: $list1 = ("perl4", "python")
           $list2 = ("raku", "python")
           $list3 = (["perl4", "perl5", "raku"])
    Output: true

=head2 Example 4

    Input: $list1 = ("enjoy", "challenge")
           $list2 = ("love", "weekly", "challenge")
           $list3 = (["enjoy", "love"])
    Output: false

=head2 Example 5

    Input: $list1 = ("fast", "car")
           $list2 = ("quick", "vehicle")
           $list3 = (["quick", "fast"], ["vehicle", "car"])
    Output: true

=cut

use strict;
use warnings;
use v5.44.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };
use List::Util qw/any/;

my @cases = (
    {list1 => ["great", "acting"],
     list2 => ["fine", "drama"],
     list3 => [["great", "fine"], ["acting", "drama"]],
     out => true,
     name => 'Example 1',
    },
    {list1 => ["apple", "pie"],
     list2 => ["banana", "pie"],
     list3 => [["apple", "peach"], ["peach", "banana"]],
     out => false,
     name => 'Example 2',
    },
    {list1 => ["perl4", "python"],
     list2 => ["raku", "python"],
     list3 => [["perl4", "perl5", "raku"]],
     out => true,
     name => 'Example 3',
    },
    {list1 => ["enjoy", "challenge"],
     list2 => ["love", "weekly", "challenge"],
     list3 => [["enjoy", "love"]],
     out => false,
     name => 'Example 4',
    },
    {list1 => ["fast", "car"],
     list2 => ["quick", "vehicle"],
     list3 => [["quick", "fast"], ["vehicle", "car"]],
     out => true,
     name => 'Example 5',
    },
);

sub similar_list
{
    my $list1 = shift;
    my $list2 = shift;
    my $list3 = shift;

    return false if @$list1 != @$list2;

    for (my $i = 0; $i < @$list1; $i++) {
        next if $list1->[$i] eq $list2->[$i];

        my $found = false;
        for my $similars (@$list3) {
            if (any {$_ eq $list1->[$i]} @$similars and
                any {$_ eq $list2->[$i]} @$similars) {
                $found = true;
                last;
            }
        }
        return $found;
    }
    return true;
}

for my $case (@cases) {
    my $got = similar_list($case->{list1}, $case->{list2}, $case->{list3});
    is($got, $case->{out}, $case->{name});
}
done_testing();

exit 0;
