#!/usr/bin/perl
use warnings;
use strict;

{   package MyDistance;
    use Moo;

    use enum qw( SAME DIFFERENT );
    use namespace::clean;

    has [qw[ s1 s2 ]] => is => 'ro';

    has [qw[ width height ]] => is => 'lazy', init_arg => undef;
    has table => is => 'ro', init_arg => undef, default => sub { [] };

    sub result {
        my ($self) = @_;
        $self->dist(0, 0)
    }

    around BUILDARGS => sub {
        my ($orig, $class, %args) = @_;
        $args{$_} = "<$args{$_}>" for qw( s1 s2 );
        $class->$orig(%args)
    };

    sub BUILD {
        my ($self) = @_;
        $self->fill_directions;
        $self->fill_distances;
    }

    sub fill_directions {
        my ($self) = @_;
        for my $j (reverse 0 .. $self->height - 1) {
            for my $i (reverse 0 .. $self->width - 1) {
                $self->dir($i, $j, (
                    substr($self->s1, $i, 1) eq substr($self->s2, $j, 1)
                ) ? SAME : DIFFERENT);
            }
        }
    }

    sub fill_distances {
        my ($self) = @_;
        my $start = 1;
        for my $j (reverse 0 .. $self->height - 1) {
            for my $i (reverse 0 .. $self->width - 1) {
                if ($start) {
                    undef $start;
                    $self->dist($i, $j,
                                DIFFERENT eq $self->dir($i, $j) ? 1 : 0);
                    next;
                }
                my @acc = sort { $a->[0] <=> $b->[0] }
                               $self->accessible($i, $j);
                $self->dist($i, $j, $acc[0][0] + $acc[0][3]);
            }
        }
    }

    sub accessible {
        my ($self, $x, $y) = @_;
        my @acc;
        for my $ij ([1, 1], [0, 1], [1, 0]) {
            my ($i, $j) = @$ij;
            my $add = (SAME eq $self->dir($x, $y) && $i == $j) ? 0 : 1;
            $i += $x;
            $j += $y;
            next if $i > $self->width - 1 or $j > $self->height - 1;

            push @acc, [$self->dist($i, $j), $i, $j, $add];
        }
        return @acc
    }

    sub cell {
        my ($self, $type, $x, $y, $val) = @_;
        if (5 == @_) {
            $self->table->[$x][$y][$type] = $val;
        } else {
            return $self->table->[$x][$y][$type]
        }
    }

    sub dir  { shift->cell(0, @_) }
    sub dist { shift->cell(1, @_) }

    sub _build_width  { length $_[0]->s1 }
    sub _build_height { length $_[0]->s2 }
}

sub edit_distance {
    my ($s1, $s2) = @_;
    my $distance = 'MyDistance'->new(s1 => $s1, s2 => $s2);
    return $distance->result
}

use Test::More tests => 3;

is edit_distance('kitten', 'sitting'), 3, 'Example 1';
is edit_distance('sunday', 'monday'), 2, 'Example 2';
is edit_distance('abcd', 'badc'), 3;
