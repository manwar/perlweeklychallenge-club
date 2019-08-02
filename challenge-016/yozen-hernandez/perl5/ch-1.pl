#!/usr/bin/env perl

use v5.24;
use strict;
use warnings;
use feature qw(signatures);
no warnings "experimental::signatures";
use Benchmark::Forking qw(cmpthese);

# Pythagoras Pie Puzzle, proposed by Jo Christian Oterhals.

# At a party a pie is to be shared by 100 guest. The first guest gets 1% of the
# pie, the second guest gets 2% of the remaining pie, the third gets 3% of the
# remaining pie, the fourth gets 4% and so on.

# Write a script that figures out which guest gets the largest piece of pie.

sub list_pie_remaining {

    # Other guests get a percent of the remaining 99/100:
    # 99/100*(2/100) for the second, leaving (99/100)*(98/100)
    # for the third guest, and so on...
    # So lets just generate a list with the amount of pie left
    # for each guest
    my @remaining_pie = (1);

    # my @pie_shares = (1/100);
    my %largest_piece = ( guest => -1, size => 0 );

    for my $i ( 1 .. 99 ) {
        push @remaining_pie, ( ( 100 - $i ) / 100 ) * $remaining_pie[-1];

        ( ( $remaining_pie[-2] - $remaining_pie[-1] ) > $largest_piece{size} )
            ? @largest_piece{ "guest", "size" }
            = ( $i, $remaining_pie[-2] - $remaining_pie[-1] )
            : next;

        # push @pie_pieces, $remaining_pie[-2]-$remaining_pie[-1];
    }

    return \%largest_piece;
}

sub track_last_piece {
    my $remaining_pie = 1;
    my $last_piece    = 0;

    for my $i ( 1 .. 100 ) {
        my $new_piece
            = $remaining_pie - ( ( 100 - $i ) / 100 ) * $remaining_pie;

        if ( $new_piece < $last_piece ) {
            return { guest => ( $i - 1 ), size => $last_piece };
        }

        $last_piece = $new_piece;
        $remaining_pie -= $new_piece;
    }

    return undef;
}

use Test::More tests => 2;
is(list_pie_remaining()->{guest}, 10, "10th guest gets the largest piece of the pie (using list)");
is(track_last_piece()->{guest}, 10, "10th guest gets the largest piece of the pie (last only)");

cmpthese(
    -10,
    {   'list_pie_remaining'  => \&list_pie_remaining,
        'track_last_piece' => \&track_last_piece
    }
);

#                        Rate list_pie_remaining   track_last_share
# list_pie_remaining  43203/s                 --               -88%
# track_last_piece   368816/s               754%                 --