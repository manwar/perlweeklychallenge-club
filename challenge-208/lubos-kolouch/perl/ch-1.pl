#!/usr/bin/perl

use strict;
use warnings;
use Test::More;

sub find_common_strings {
    my ($list1_ref, $list2_ref) = @_;

    my @list1 = @$list1_ref;
    my @list2 = @$list2_ref;

    my %common;
    my $min_index_sum = scalar(@list1) + scalar(@list2);

    for (my $i = 0; $i < scalar(@list1); $i++) {
        for (my $j = 0; $j < scalar(@list2); $j++) {
            if ($list1[$i] eq $list2[$j]) {
                my $index_sum = $i + $j;
                if ($index_sum <= $min_index_sum) {
                    $min_index_sum = $index_sum;
                    $common{$list1[$i]} = $index_sum;
                }
            }
        }
    }

    if (scalar(keys %common) == 0) {
        return ();
    } else {
        my @result;
        foreach my $key (keys %common) {
            if ($common{$key} == $min_index_sum) {
                push(@result, $key);
            }
        }
        return @result;
    }
}

# Example 1
my @list1_1 = ("Perl", "Raku", "Love");
my @list2_1 = ("Raku", "Perl", "Hate");
my @common_1 = sort find_common_strings(\@list1_1, \@list2_1);
is_deeply(\@common_1, ["Raku"], "Example 1");

# Example 2
my @list1_2 = ("A", "B", "C");
my @list2_2 = ("D", "E", "F");
my @common_2 = find_common_strings(\@list1_2, \@list2_2);
is_deeply(\@common_2, [], "Example 2");

# Example 3
my @list1_3 = ("A", "B", "C");
my @list2_3 = ("C", "A", "B");
my @common_3 = find_common_strings(\@list1_3, \@list2_3);
is_deeply(\@common_3, ["A"], "Example 3");

done_testing();

