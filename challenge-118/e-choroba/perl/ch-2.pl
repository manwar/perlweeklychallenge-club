#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

use ARGV::OrDATA;

use constant SHOW_ANIMATION => 0;

{   package Knight::Problem::Builder;
    use Moo;

    has fh => (is => 'ro', required => 1);


    sub build {
        my ($self) = @_;
        my ($board, $x, $y) = $self->_read_input;
        return 'Knight::Problem'->new(board => $board, X => $x, Y => $y)
    }


    sub _validate_column_names {
        my ($self) = @_;
        my $fh = $self->fh;
        chomp( my $r = <$fh> );
        $r eq join ' ', ' ', 'a' .. 'h' or die "Invalid column names $r.\n";
    }


    sub _read_input {
        my ($self) = @_;
        my $fh = $self->fh;
        my ($x, $y);
        my @board = map [], 1 .. 8;
        $self->_validate_column_names;
        for my $line (0 .. 7) {
            my @squares = split ' ', <$fh>;

            die "Invalid row number $line.\n"
                unless 8 - $line eq shift @squares;
            die "Invalid row number $line.\n"
                unless 8 - $line eq pop @squares;

            push @{ $board[$_] }, $squares[$_] for 0 .. 7;
            for my $column (0 .. 7) {
                if ('N' eq $squares[$column]) {
                    die "Duplicate knight ($x, $y), ($column, $line)\n"
                        if defined $$x;

                    ($x, $y) = ($column, $line);
                }
            }
        }
        $self->_validate_column_names;
        return \@board, $x, $y
    }
}


{   package Knight::Problem;
    use Moo;

    has board => (is => 'ro', required => 1);
    has [qw[ X Y ]] => (is => 'ro', required => 1);
    has count => (is => 'ro', lazy => 1, builder => '_build_count');
    has coord2v => (is => 'ro', lazy => 1, builder => '_build_coord2v');

    sub _build_coord2v {
        my ($self, $x, $y) = @_;
        my %c;
        my $i = 0;
        for my $y (0 .. 7) {
            for my $x (0 .. 7) {
                next if $self->board->[$x][$y] ne 'x';

                $c{c}{$i} = [$x, $y];
                $c{v}{$x}{$y} = $i++;
            }
        }
        return \%c
    }

    sub _build_count {
        my ($self) = @_;
        my $c = grep 'x' eq $_, map @$_, @{ $self->board };
        return $c
    }
}


{   package Knight::State;
    use Moo;

    has X => (is => 'ro', required => 1);
    has Y => (is => 'ro', required => 1);
    has visited => (is => 'ro', required => 1);
    has parent => (is => 'rw');


    sub serialise {
        my ($self) = @_;
        return join ' ', $self->X, $self->Y, $self->visited
    }


    sub DEMOLISH {
        my ($self) = @_;
        $self->parent(undef);
    }
}


{   package Knight::Solver::AStar;
    use Moo;

    use Storable qw{ dclone };
    use Time::HiRes qw{ sleep };
    use namespace::clean;

    has problem => (is => 'ro', required => 1);
    has steps => (is => 'rw', default => 0);
    has _fringe => (is => 'ro', default => sub { [] });
    has _in_fringe => (is => 'ro', default => sub { {} });
    has _score => (is => 'ro', default => sub { {} });
    has _precomputed_distance => (is      => 'ro',
                                  lazy    => 1,
                                  builder => '_build_precomputed_distance');


    sub solve {
        my ($self) = @_;
        $self->_update_fringe(0,
            'Knight::State'->new(
                X       => $self->problem->X,
                Y       => $self->problem->Y,
                visited => '0' x $self->problem->count));

        until ($self->_is_fringe_empty) {
            my $node = $self->_pop_fringe;
            return $self->path($node) if $self->_is_goal($node);

            my $score = $self->_score->{ $node->serialise };
            for my $succ ($self->_succ($node)) {
                my $succ_ser = $succ->serialise;
                my $succ_score = 1 + $score;
                if (
                    $succ_score < ($self->_score->{$succ_ser} // $succ_score + 1)
                ) {
                    $succ->parent($node);
                    $self->_update_fringe($succ_score, $succ);
                }
            }
        }
        die 'No solution!';
    }


    sub path {
        my ($self, $node) = @_;
        my $p = $node;
        my @path;
        do {
            unshift @path, [$p->X, $p->Y];
        } while $p = $p->parent;
        return @path
    }


    sub show_path {
        my ($self, @path) = @_;
        print @path - 1, ': ';
        print join ', ', map chr($_->[0] + ord 'a') . (8 - $_->[1]), @path;
        print "\n";
    }


    sub play {
        my ($self, @path) = @_;
        my $board = $self->problem->board;
        for my $step (@path) {
            my ($x, $y) = @$step;
            for my $j (0 .. 7) {
                for my $i (0 .. 7) {
                    my $cell = $board->[$i][$j];
                    print $x == $i && $y == $j ? 'K' : $cell;
                    $board->[$x][$y] = 'o' if $board->[$x][$y] eq 'x';
                }
                print "\n";
            }
            print "\n";
            sleep 0.4;
        }
    }


    sub _is_fringe_empty {
        my ($self) = @_;
        return ! keys %{ $self->_in_fringe }
    }


    sub _distance {
        my ($self, $x, $y, $i, $j) = @_;
        my ($X, $Y) = map abs, $x - $i, $y - $j;
        ($X, $Y) = ($Y, $X) if $X > $Y;
        return $self->_precomputed_distance->{$X}{$Y};
    }


    sub _heuristic {
        my ($self, $x, $y, $visited) = @_;
        my $max_distance = 0;
        for my $v (0 .. length($visited) - 1) {
            next if substr $visited, $v, 1;

            my ($i, $j) = @{ $self->problem->coord2v->{c}{$v} };
            my $distance = $self->_distance($x, $y, $i, $j);
            $max_distance = $distance if $distance > $max_distance;
        }
        return $max_distance
    }

    sub _update_fringe {
        my ($self, $score, $new) = @_;
        my $ser = $new->serialise;
        $self->_score->{$ser} = $score;
        $score += $self->_heuristic($new->X, $new->Y, $new->visited);
        push @{ $self->_fringe->[$score] }, $new;
        $self->_in_fringe->{ $new->serialise } = $score;
        $self->_step;
    }


    sub _pop_fringe {
        my ($self) = @_;
        for my $i (0 .. $#{ $self->_fringe }) {
            if (@{ $self->_fringe->[$i] // [] }) {
                my $e = shift @{ $self->_fringe->[$i] };
                delete $self->_in_fringe->{ $e->serialise };
                return $e
            }
        }
        die 'Fringe empty'
    }


    sub _is_goal {
        my ($self, $node) = @_;
        return $node->visited !~ /0/
    }


    sub _update_visited {
        my ($self, $x, $y, $visited) = @_;
        return $visited if $self->problem->board->[$x][$y] ne 'x';

        my $v = $self->problem->coord2v->{v}{$x}{$y};
        substr $visited, $v, 1, '1';
        return $visited
    }


    my @MOVES = ([-1, -2], [1, -2], [2, -1], [2, 1],
                 [1, 2], [-1, 2], [-2, 1], [-2, -1]);

    sub _succ {
        my ($self, $node) = @_;
        my @s;
        for my $m (@MOVES) {
            my ($newx, $newy) = ($node->X + $m->[0], $node->Y + $m->[1]);
            next if $newx < 0 || $newx > 7 || $newy < 0 || $newy > 7;

            my $v = $self->_update_visited($newx, $newy, $node->visited);
            push @s, ref($node)->new(X       => $newx,
                                     Y       => $newy,
                                     visited => $v,
                                     parent  => $node);
        }
        return @s
    }


    sub _step {
        my ($self) = @_;
        $self->steps(1 + $self->steps);
    }


    sub _build_precomputed_distance {
        my ($self) = @_;
        my %grid;
        my $size = 8;
        $grid{$size}{$size} = 0;
        my ($xmin, $xmax, $ymin, $ymax) = ($size) x 4;
        for my $step (0 .. 7) {
            for my $i ($xmin .. $xmax) {
                for my $j ($ymin .. $ymax) {
                    next unless ($grid{$i}{$j} // 0) == $step;

                    for my $m (@MOVES) {
                        my $x = $i + $m->[0];
                        my $y = $j + $m->[1];
                        if ($x >= 0 && $y >= 0 && ! defined $grid{$x}{$y}) {
                            $grid{$x}{$y} = $step + 1;
                            $xmax = $x if $x > $xmax;
                            $ymax = $y if $y > $ymax;
                            $xmin = $x if $x < $xmin;
                            $ymin = $y if $y < $ymin;
                        }
                    }
                }
            }
        }
        my %distances;
        for my $j (0 .. 7) {
            for my $i (0 .. $j) {
                $distances{$i}{$j} = $grid{$i + $size}{$j + $size};
            }
        }
        return \%distances
    }
}


my $problem = 'Knight::Problem::Builder'->new(fh => *ARGV)->build;
my $solver  = 'Knight::Solver::AStar'->new(problem => $problem);

my @path = $solver->solve;
$solver->play(@path) if SHOW_ANIMATION;
say 'Steps: ', $solver->steps;
$solver->show_path(@path);

__DATA__
  a b c d e f g h
8 N * * * * * * * 8
7 * * * * * * * * 7
6 * * * * x * * * 6
5 * * * * * * * * 5
4 * * x * * * * * 4
3 * x * * * * * * 3
2 x x * * * * * * 2
1 * x * * * * * * 1
  a b c d e f g h

Steps: 1623
11: a8, c7, e6, c5, b3, c1, a2, c3, b1, a3, c4, b2
