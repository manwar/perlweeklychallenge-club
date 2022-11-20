#!/usr/bin/perl
use strict;
use warnings;

=head1

Week 192:
    https://theweeklychallenge.org/blog/perl-weekly-challenge-191

    Task 2: Cute List You are given an integer, 0 < $n <= 15. Write a script to find the number of orderings of
    numbers that form a cute list. With an input @list = (1, 2, 3, .. $n) for positive integer $n, an ordering of
    @list is cute if for every entry, indexed with a base of 1, either

=cut

use Test2::V0;
use Data::Dumper;

is getCuteListCount(2), 2, 'Example 1';

sub getCuteListCount {
    my ($number) = @_;

    my $cute_list_count = 0;
    my @numbers_array = (1..$number);

    for (my $i = 0; $i < $number; $i++) {
        my @numbers_sub_array = (getArraySlice(\@numbers_array, $i + 1, $number), getArraySlice((\@numbers_array, 0, $i)));

        for (my $j = 0; $j < $number - 1; $j++) {
            my @possible_cute_list = ($numbers_array[$i], getArraySlice(\@numbers_sub_array, $j, $number - 1), getArraySlice(\@numbers_sub_array, 0, $j));
            $cute_list_count += 1 if isCuteList(@possible_cute_list);
        }
    }

    return $cute_list_count;
}

sub getArraySlice {
    my ($array, $start, $end) = @_;

    my $array_size = scalar @{$array};
    my @sliced_array = ();

    for (my $i = $start; $i < $end; $i++) {
        if ($i < $array_size) {
            push @sliced_array, $array->[$i];
        }
        else {
            last;
        }
    }

    return @sliced_array;
}
sub isCuteList {
    my @numbers_array = @_;

    for (my $i = 0; $i < scalar(@numbers_array); $i++) {
        return (0) unless ($numbers_array[$i] % ($i + 1) == 0 or ($i + 1) % $numbers_array[$i] == 0);
    }

    return(1);
}

done_testing();
