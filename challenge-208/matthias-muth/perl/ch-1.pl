#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 208 Task 1: Minimum Index Sum
#
#       Perl solution by Matthias Muth.
#

use strict;
use warnings;

use List::Util qw( min );

sub min_index_sum {
    my @list1 = @{$_[0]};
    my @list2 = @{$_[1]};
    my %index1 = map { ( $list1[$_] => $_ ) } 0..$#list1;
    my %strings_by_index_sum;
    for ( 0..$#list2 ) {
        if ( exists $index1{ $list2[$_] } ) {
            my $index_sum = $index1{ $list2[$_] } + $_;
            push @{$strings_by_index_sum{$index_sum}}, $list2[$_];
        }
    }
    return
        %strings_by_index_sum
        ? sort @{$strings_by_index_sum{ min( keys %strings_by_index_sum ) } }
        : ();
}

use Test::More;

do {
    is_deeply
        [ min_index_sum( $_->{INPUT_1}, $_->{INPUT_2} ) ], $_->{EXPECTED},
        "min_index_sum( [ @{$_->{INPUT_1}} ], [ @{$_->{INPUT_2}} ] ) == ( @{$_->{EXPECTED}} )";
} for (
    { INPUT_1  => [ "Perl", "Raku", "Love" ],
      INPUT_2  => [ "Raku", "Perl", "Hate" ],
      EXPECTED => [ "Perl", "Raku" ] },
    { INPUT_1  => [ "A", "B", "C" ],
      INPUT_2  => [ "D", "E", "F" ],
      EXPECTED => [] },
    { INPUT_1  => [ "A", "B", "C" ],
      INPUT_2  => [ "C", "A", "B" ],
      EXPECTED => [ "A" ] },
);

done_testing;
