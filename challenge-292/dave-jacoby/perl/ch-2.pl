#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say state postderef signatures };

use List::Util qw{ first max min uniq };

my @examples = (

    { board => "WRRBBW",   hand => "RB" },
    { board => "WWRRBBWW", hand => "WRBRW" },
    { board => "G",        hand => "" },
    { board => "",         hand => "GGGGG" },
    { board => "GG",       hand => "GGGGG" },
    { board => "G",        hand => "GGGGG" },
);

for my $example (@examples) {
    my ( $board, $hand ) = map { $example->{$_} } qw{board hand};
    $example->{hand} = join '', sort split //, $example->{hand};
    $example->{used} = '';
    my @output = zuma($example);
    my $output = join ' ', @output;
    say <<"END";
    Input:  \$board = "$board", \$hand = "$hand"
    Output: $output
END
}

sub zuma ($example) {
    my @output;
    my %done;
    my ( $board, $hand, $used ) =
        map { $example->{$_} || '' } qw{board hand used};
    my $lboard = length $board || 0;
    my $lhand  = length $hand  || 0;
    my $lused  = length $used  || 0;

    # you've run out of balls on the board and have thus won
    if ( length $board == 0 ) { return $lused; }

    # You've run out of balls and cannot win
    if ( length $hand == 0 ) { return -1; }

    my @chars = uniq sort split //, $hand;
    for my $h (@chars) {
        my $chand = $hand;
        my $i =
            first { substr( $chand, $_, 1 ) eq $h } 0 .. -1 + length $chand;
        substr( $chand, $i, 1 ) = '';
        for my $j ( 0 .. length $board ) {
            my $cboard = $board;
            substr( $cboard, $j, 0 ) = $h;
            while ( $cboard =~ m{([A-Z])\1\1}mx ) {
                $cboard =~ s/([A-Z])\1\1+//gmx;
            }
            next if $done{$chand}{$cboard}++;
            my $obj = {};
            $obj->{board} = $cboard;
            $obj->{hand}  = $chand;
            $obj->{used}  = $used . $h;
            my $o = zuma($obj);
            push @output, $o if $o >= 0;
        }
    }
    @output = uniq sort { $a <=> $b } grep { defined } @output;
    if ( scalar @output ) { return min @output; }
    return -1;
}
