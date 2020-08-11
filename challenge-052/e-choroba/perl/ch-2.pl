#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

=encoding utf8

=head1 Lucky Winner

The winner is the player that gains the £2, because the sum of all the
remaining coins is only £1.88.

=cut

{   package My::Game;
    use Moo;

    has [qw[ player1 player2 ]] => (
        is => 'rw', default => 0, init_arg => undef);
    has coins => (is => 'ro', required => 1);
    has remaining => (is => 'rw', lazy => 1, builder => 'coins');

    sub auto {
        my ($self) = @_;
        if (1 == @{ $self->remaining }
            || $self->remaining->[0] == 200
        ) {
            $self->turn('l');
        } elsif ($self->remaining->[-1] == 200
                 || $self->remaining->[1] == 200
             ) {
            $self->turn('r');
        } else {
            $self->turn('l');
        };
    }

    sub turn {
        my ($self, $where) = @_;
        $where = lc substr $where, 0, 1;
        my $pos = { l => 0, r => -1 }->{$where};
        $self->player1($self->player1 + splice @{ $self->remaining }, $pos, 1);
        $self->switch;
    }

    sub switch {
        my ($self) = @_;
        my $p = $self->player1;
        $self->player1($self->player2);
        $self->player2($p);
    }

    sub finished {
        ! @{ $_[0]->remaining }
    }

    sub status {
        my ($self) = @_;
        $self->player1, ', ', $self->player2, ": @{ $self->remaining }";
    }

    sub result {
        my ($self) = @_;
        die "Not yet finished" unless $self->finished;
        return ('draw', 'Player 1 wins', 'Player 2 wins')[
            $self->player1 <=> $self->player2 ]
    }

}

use List::Util qw{ shuffle };
my @coins = shuffle(100, 50, 1, 10, 5, 20, 200, 2);

say "@coins";
say "Input 'left' or 'right' (or just 'l' or 'r').";

my $starting_player = 1 + int rand 2;
say "Starting player: $starting_player";

my $game = 'My::Game'->new(coins => \@coins);
$game->auto if 2 == $starting_player;

until ($game->finished) {
    say $game->status;
    my $where;
    do {
        chomp( $where = <> );
    } until $where =~ /^(l(eft)?|r(ight)?)$/i;

    $game->turn($where);

    $game->auto unless $game->finished;
}

$game->switch if 2 == $starting_player;
say $game->status, $game->result;
