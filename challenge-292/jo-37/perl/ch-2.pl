#!/usr/bin/perl -s

use v5.24;
use Test2::V0;
use List::Util 'sum';
use Data::Dump 'pp';
use experimental 'signatures';

our ($tests, $examples, $verbose);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV == 2;
usage: $0 [-examples] [-tests] [BOARD HAND]

-examples
    run the examples from the challenge
 
-tests
    run some tests

BOARD
    the board

HAND
    the hand

EOS


### Input and Output

say play_zuma(@ARGV);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2024/11/08/ch-292.html#task-2

our $lvl;

sub dbg {
    say '  ' x ($lvl - 1), @_ if $verbose;
}

sub zuma ($board, $hand, $moves, $min) {
    local $lvl = $lvl + 1;
    dbg("board: $board");
    dbg("hand:  ", map $_ x $hand->{$_}, keys %$hand);
    dbg("moves: $moves");
    dbg("min:   $min");
    my %board_content;
    $board_content{$_}++ for split //, $board;
    my $hand_count = sum values %$hand;
    my $color_count = scalar keys %board_content;
    dbg("cut: need at least ", $moves + $color_count, " moves to clear, ",
        "cannot improve $min"), return 'inf' if $moves + $color_count >= $min;
    dbg("need at least $color_count moves to clear, ",
        "have only $hand_count in hand"), return 'inf'
        if $hand_count < $color_count;
    my %singles;
    @singles{grep $board_content{$_} < 3, keys %board_content} = ();
    delete @singles{keys %$hand};
    dbg("cannot remove ", keys %singles), return 'inf' if %singles;
    my $prev = '';
    my $b;
    for my $i (0 .. length($board) - 1) {
        $b = substr $board, $i, 1;
        next if $b eq $prev;
        next unless $hand->{$b};
        my %hand = %$hand;
        $hand{$b}--;
        my $new_board = $board;
        dbg("insert $b at $i in $new_board");
        substr($new_board, $i, 0) = $b;
        my $else = 1;
        while ((my $match = $new_board =~ /((.)\2{2,})/g) || $else) {
            $else = 0;
            my $reduced_board = $new_board;
            if ($match) {
                dbg("remove $2 at $-[1]-$+[1] from $new_board");
                substr($reduced_board, $-[1], $+[1] - $-[1]) = '';
                dbg("board empty"), return $moves + 1 unless $reduced_board;
            } else {
                dbg("nothing removed from $new_board");
            }
            my $res = zuma($reduced_board, \%hand, $moves + 1, $min);
            dbg("got $res");
            dbg("new minimum $res"), $min = $res if $res < $min;
        }
    } continue {
        $prev = $b;
    }

    $min;
}

sub play_zuma ($board, $hand) {
    my %hand;
    $hand{$_}++ for split //, $hand;
    $lvl = 0;
    my $zuma = zuma($board, \%hand, 0, 'inf');
    $lvl = 1;
    dbg("minimum moves: $zuma");

    $zuma < 'inf' ? $zuma : -1;
}

### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is play_zuma("WRRBBW", "RB"), -1, 'example 1';
        is play_zuma("WWRRBBWW", "WRBRW"), 3, 'example 2';
        is play_zuma("G", "GGGGG"), 2, 'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;

        is play_zuma("AAABBA", "AB"), 2, 'pick second group';
    }

    done_testing;
    exit;
}
