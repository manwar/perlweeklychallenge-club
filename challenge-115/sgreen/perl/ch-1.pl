#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';

use List::MoreUtils 'firstidx';

sub _remove_word {
    # Return an arrayref of the @$list without the first occurance of $word
    my ( $word, $list ) = @_;
    my $index = firstidx { $word eq $_ } @$list;
    return [ map { $list->[$_] } grep { $_ != $index } 0 .. $#$list ];
}

sub _reduce_list {
    my ( $used, $list ) = @_;

    if (@$list) {
        # We have words to use. Choose the words that begin with the last
        #  letter of the last word
        my @can_use = grep { substr( $_, 0, 1 ) eq substr( $used->[-1], -1 ) } @$list;

        # Recursive call this function with each of these words
        foreach my $word (@can_use) {
            # Return '1' if we have a result
            my $result = _reduce_list( [ @$used, $word ], _remove_word( $word, $list ) );
            return 1 if $result;
        }

        # There is no solution that exist
        return 0;
    }

    # We have use all the words. We need to check we can complete the
    #  circle by checking if the first letter of the first word is the
    #  same as the last letter of the last word
    return substr( $used->[0], 0, 1 ) eq substr( $used->[-1], -1 ) ? 1 : 0;
}

sub main {
    my @words      = @_;
    my $first_word = shift @words;

    say _reduce_list( [$first_word], \@words );
}

main(@ARGV);
