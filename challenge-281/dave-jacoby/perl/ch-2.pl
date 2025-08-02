#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ fc say postderef signatures state };

my @examples = ( # added a couple test entries

    [ 'g2', 'a8' ],
    [ 'g2', 'h2' ],
    [ 'a1', 'h8' ],
    [ 'd5', 'e4' ],
);

for my $input (@examples) {
    my $output = knights_move($input);
    my ( $start, $end ) = $input->@*;
    say <<"END";
    Input:  \$start = "$start", \$end = "$end"
    Output: $output
END
}

sub knights_move($input) {
    my ( $start, $end ) = $input->@*;
    my $board = {}; # used for display
    my $done  = {}; # used to track the win
    my @end   = split //, $end;
    $board->{ $end[0] }{ $end[1] } = -2;
    $done->{$end} = 'E';


    # these get us from 'a1' to [7,0] and back
    my @lets = 'a' .. 'h';
    my %lets = map { $lets[$_] => $_ } 0 .. -1 + scalar @lets;
    my %stel = reverse %lets;

    my @nums = reverse 1 .. 8;
    my %nums = map { $nums[$_] => $_ } 0 .. -1 + scalar @nums;
    my %smun = reverse %nums;

    my @moves = ( [ $start, 0 ] );
    my @jumps = (
        [ -1, -2 ], [ -1, 2 ], [ -2, -1 ], [ -2, 1 ],
        [ 1,  -2 ], [ 1,  2 ], [ 2,  -1 ], [ 2,  1 ],
    );

    for my $move (@moves) {
        my ( $space, $depth ) = $move->@*;
        my ( $l, $n ) = split //, $space;
        if ( defined $done->{$space} ) {
            if ( $done->{$space} eq 'E' ) {
                # display_board($board);
                return $depth;
            }
            next;
        }

        $board->{$l}{$n} = $depth;
        $done->{$space} = $depth;

        for my $jump (@jumps) {
            my ( $i, $j ) = $jump->@*;
            my $ll = $lets{$l} + $i;
            my $nn = $nums{$n} + $j;

            if ( $ll >= 0 && $ll <= 7 ) {
                if ( $nn >= 0 && $nn <= 7 ) {
                    my $new = join '', $stel{$ll}, $smun{$nn};
                    push @moves, [ $new, $depth + 1 ];
                }
            }
        }
    }

    # There's always a way, but I don't like not providing an unaccounted 
    # case
    return 'fail';
}

sub display_board ($board) {
    my @lets = 'a' .. 'h';
    my @nums = reverse 1 .. 8;
    for my $num (@nums) {
        print qq{$num  };
        for my $let (@lets) {
            my $char = '_';
            if ( defined $board->{$let}{$num} ) {
                $char =
                    $board->{$let}{$num} == -2
                    ? 'E'
                    : $board->{$let}{$num};
            }
            print qq{ [$char] };
        }
        say '';
    }
    say join '    ', ' ', @lets;
}
