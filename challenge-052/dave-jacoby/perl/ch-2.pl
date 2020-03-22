#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ fc postderef say signatures state switch };
no warnings qw{ 
    experimental::postderef 
    experimental::signatures 
    experimental::smartmatch 
    };

use utf8;
binmode STDOUT, ":encoding(UTF-8)";

use Carp;
use JSON;
use List::Util qw{ sum0 shuffle };

my $json = JSON->new->pretty->canonical;

# Suppose there are following coins arranged on a table
# in a line in random order.

#   £1, 50p, 1p, 10p, 5p, 20p, £2, 2p

# Suppose you are playing against the computer. Player
# can only pick one coin at a time from either ends.
# Find out the lucky winner, who has the larger amounts in total?

###########################################
# So, a game. A contest between the computer and the user
# about pulling coins of certain values from the left or
# right of a randomly-ordered set of coins.

#   * random order -> List::Util::shuffle
#   * from the right or left -> shift or pop
#   * pick one coin at a time -> while loop and STDIN.

# Which leaves how to determine what the best move is.
# I think the correct term is "decision trees", where the 
# computer iterates through all possible moves, then the 
# possible moves of the  opponent, then self, and over again, 
# until it determines all possible  outcomes, then judges 
# the best possible outcome and makes the choice.

# I saw a youtube video on how to code Tic-Tac-Toe in JS,
# which mentioned that this methodology is broken for 
# Chess, because the number of possible games is greater 
# than the number of atoms in the observable universe.
# Or someting like that.

# but given eight coins, we can only go so deep. 

my @coins = shuffle ( "£1", "50p", "1p", "10p", "5p", "20p", "£2", "2p" );
my @h_list;
my @c_list;
my @history;

while ( scalar @coins ) {
    display( \@coins, \@c_list, \@h_list, 1, \@history );

    my $coins = join ' ', @coins;
    say <<"END";
    Choose "L" or "R" to pick a coin from the list
    Or "Q" to quit

END
    print q{Choose(L/R/Q):};
    my $choice = uc <STDIN>;
    chomp $choice;

    if ( $choice eq 'Q' ) { say 'Good Game!' && exit; }
    if ( $choice eq 'L' || $choice eq 'R' ) {
        choice( 'HUMAN', $choice );
        my ( $comp, $score ) =
          decision_tree( \@coins, \@c_list, \@h_list, 1, \@history );
        choice( 'COMPUTER', $comp );
    }
}

display( \@coins, \@c_list, \@h_list, 1, \@history );
my $c_score = sum0 map { value($_) } @c_list;
my $h_score = sum0 map { value($_) } @h_list;

if ( $h_score > $c_score ) {
    say uc 'you won';
}
elsif ( $h_score == $c_score ) {
    say uc 'a tie!';
}
else { say uc 'too bad' }

# handles the array mangling behind a choice, either by human or computer
sub choice ( $player, $choice ) {
    my $coin;
    if ( $choice eq 'L' ) { $coin = shift @coins; }
    else {
        $coin = pop @coins;
    }

    if ( $player eq 'HUMAN' ) {
        push @h_list, $coin;
        push @history, join '', $choice, 'H';
    }
    else {
        push @c_list, $coin;
        push @history, join '', $choice, 'C';
    }
}

sub display ( $coins, $c_list, $h_list, $pos, $history ) {
    say '-' x 30;
    say 'COINS:    ' . join ', ', $coins->@*;
    say '          ' . sum0 map { value($_) } $coins->@*;
    say 'COMPUTER  ' . join ', ', $c_list->@*;
    say '          ' . sum0 map { value($_) } $c_list->@*;
    say 'HUMAN     ' . join ', ', $h_list->@*;
    say '          ' . sum0 map { value($_) } $h_list->@*;
    say 'POSITION  ' . $pos;
    say 'HISTORY   ' . join ', ', $history->@*;
    say '';
}

sub decision_tree ( $coins, $c_list, $h_list, $pos, $history, $depth = 0 ) {

    # croak 'Too Few Coins' if scalar @$coins < 2;
    # display( $coins, $c_list, $h_list, $pos, $history );

    if ( scalar @$coins == 0 ) {

        # display( $coins, $c_list, $h_list, $pos, $history );
        my $c_sum = sum0 map { value($_) } $c_list->@*;
        my $h_sum = sum0 map { value($_) } $h_list->@*;
        return ( 'L', $c_sum + 100 ) if $c_sum > $h_sum;
        return ( 'L', $c_sum );

    }

    my $left;
    my $right;
    {
        my $lhist;
        @$lhist = @$history;
        push @$lhist, join '', 'L', $pos ? 'C' : 'H';
        my $lcoins;
        my $clist;
        my $hlist;
        @$lcoins = @$coins;
        @$clist  = @$c_list;
        @$hlist  = @$h_list;
        my $coin = shift @$lcoins;
        if   ($pos) { push @$clist, $coin }
        else        { push @$hlist, $coin }
        ( undef, $left ) =
          decision_tree( $lcoins, $clist, $hlist, int !$pos, $lhist,
            $depth + 1 );
    }
    {
        my $lhist;
        @$lhist = @$history;
        push @$lhist, join '', 'R', $pos ? 'C' : 'H';
        my $lcoins;
        my $clist;
        my $hlist;
        @$lcoins = @$coins;
        @$clist  = @$c_list;
        @$hlist  = @$h_list;
        my $coin = pop @$lcoins;
        if   ($pos) { push @$clist, $coin }
        else        { push @$hlist, $coin }
        ( undef, $right ) =
          decision_tree( $lcoins, $clist, $hlist, int !$pos, $lhist,
            $depth + 1 );
    }

    # say join qq{\t}, $depth, 'LEFT', $left, 'RIGHT', $right;

    if ( $left > $right ) {
        return ( 'L', $left + 10 );
    }
    elsif ( $left < $right ) {
        return ( 'R', $right + 10 );
    }
    else {
        return ( 'R', $right );
    }
}

# IIRC, British coinage has gone decimal, so this is roughly the value of
# each of the coins, placed into a fuction so I can't accidentally change
# values
sub value( $coin ) {
    state $hash = {
        "£1" => 100,
        "£2" => 200,
        "10p" => 10,
        "1p"  => 1,
        "20p" => 20,
        "2p"  => 2,
        "50p" => 50,
        "5p"  => 5,
    };
    return $hash->{$coin} ? $hash->{$coin} : 0;
}
