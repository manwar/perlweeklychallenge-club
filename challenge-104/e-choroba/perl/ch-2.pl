#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

# Run "dot -Tpng ch-2.dot" to generate a graph of all the possible
# transitions between states. Ending in 0 means a victory; 0 is
# reachable from 1, 2, and 3, hence their green colour. 4 on the other
# hand can only reach the green nodes, so you can't win if you get
# there. And so on.

{   package Game::Nim;
    use Types::Standard qw( Int Enum Bool );
    use Moo;

    has turn => (is      => 'rw',
                 isa     => Enum[qw[ me you ]],
                 default => sub { qw( me you )[int rand 2] });

    has remainder => (is      => 'rwp',
                      isa     => Int,
                      default => sub { 12 });

    has done => (is      => 'rwp',
                 isa     => Bool,
                 default => 0);

    sub _my_turn {
        my ($self) = @_;
        my $r = $self->remainder;
        my $pick = 0;
        $pick = ($r % 4) || 1 + int rand 3;
        say 'Picking ', $pick;
        $self->_set_remainder($self->remainder - $pick);
    }

    sub _your_turn {
        my ($self) = @_;
        my $pick = '0E0';
        until (0 < $pick && $pick < 4 && $pick <= $self->remainder) {
            say 'Invalid choice.' unless '0E0' eq $pick;
            print 'How many do you want to pick? ';
            chomp( $pick = <> );
            $pick =~ s/[^0-9]//g;
        }
        $self->_set_remainder($self->remainder - $pick);
    }

    sub play {
        my ($self) = @_;
        return if $self->done;

        say "Remaining: ", $self->remainder;

        if ($self->turn eq 'me') {
            $self->_my_turn;

        } else {
            $self->_your_turn;
        }

        if (0 == $self->remainder) {
            say 'Winner: ', $self->turn;
            say 'Congratulations!' if 'you' eq $self->turn;
            $self->_set_done(1);
        }

        $self->turn({ me => 'you', you => 'me' }->{ $self->turn });
    }
}

my $game = 'Game::Nim'->new;
$game->play until $game->done;
