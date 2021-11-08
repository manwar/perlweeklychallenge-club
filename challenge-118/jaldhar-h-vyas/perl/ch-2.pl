#!/usr/bin/perl

package Position;
use Moo;
use namespace::clean;

has row => (
    is => 'rw',
);

has col => (
    is => 'rw',
);

around BUILDARGS => sub {
    my ($orig, $class, @args) = @_;
    return { row => $args[0], col => $args[1] };
};

sub str {
    my ($self) = @_;
    return chr(ord('a') + $self->col) . (8 - $self->row);
}

1;

package main;
use 5.020;
use warnings;

sub permute (&@) {
    my $code = shift;
    my @idx = 0..$#_;
    while ( $code->(@_[@idx]) ) {
        my $p = $#idx;
        --$p while $idx[$p-1] > $idx[$p];
        my $q = $p or return;
        push @idx, reverse splice @idx, $p;
        ++$q while $idx[$p-1] > $idx[$q];
        @idx[$p-1,$q]=@idx[$q,$p-1];
    }
}

sub compare {
    my ($a, $b) = @_;
    return $a->row == $b->row && $a->col == $b->col;
}

sub estimatedCost {
    my ($position, $goal) = @_;

    state @distance = (
        0, 3, 2, 3, 2, 3, 4, 5,
        3, 2, 1, 2, 3, 4, 3, 4,
        2, 1, 4, 3, 2, 3, 4, 5,
        3, 2, 3, 2, 3, 4, 3, 4,
        2, 3, 2, 3, 4, 3, 4, 5,
        3, 4, 3, 4, 3, 4, 5, 4,
        4, 3, 4, 3, 4, 5, 4, 5,
        5, 4, 5, 4, 5, 4, 5, 6
    );

    return $distance[abs($position->row - $goal->row) * 8 +
        abs($position->col - $goal->col)];
}

sub tryMove {
    my ($position, $delta) = @_;

    my $dest = Position->new($position->row + $delta->row, $position->col + $delta->col);
    return ($dest->row >= 0 && $dest->row < 8 && $dest->col >= 0 && $dest->col < 8)
        ? $dest
        : undef;
}

sub possibleMoves {
    my ($position, $target) = @_;

    state @deltas = (
        Position->new(-2, -1),
        Position->new(-2, 1),
        Position->new(-1, 2),
        Position->new(1, 2),
        Position->new(2, 1),
        Position->new(2, -1),
        Position->new(-1, -2),
        Position->new(1, -2)
    );

    my @moves;
    for my $delta (@deltas) {
        my $move = tryMove($position, $delta);
        if (defined $move) {
            push @moves, $move;
        }
    }

    @moves = sort { estimatedCost($a, $target) < estimatedCost($b, $target); } @moves;

    return @moves;
}

sub search {
    my ($target, $path, $estimate) = @_;
    my $current = $path->[-1];
    my $cost = (scalar @{$path}) + estimatedCost($current, $target);

    if ($cost > $estimate) {
        return $cost;
    }

    if (compare($current, $target)) {
        return '-inf';
    }

    my $min = 'inf';

    for my $move (possibleMoves($current, $target)) {
        if (!grep { $_ if compare($_, $move); } @{$path}) {
            push @{$path}, $move;
            my $t = search($target, $path, $estimate);

            if ($t == '-inf') {
                return '-inf';
            }

            if ($t < $min) {
                $min = $t;
            }

            pop @{$path};
        }
    }

    return $min;
}

sub makePath {
    my ($knight, $targets) = @_;
    my @path = ( $knight );

    for my $target (@{$targets}) {
        my @stage = ( $knight );
        my $estimate = estimatedCost($knight, $target);

        while(1) {
            my $t = search($target, \@stage, $estimate);

            if ($t == '-inf') {
                last;
            }

            # Can't solve; this shouldn't happen.
            if ($t == 'inf') {
                last;
            }

            $estimate = $t;
        }

        push @path, splice(@stage, 1);
        @stage = ();
        $knight = $target;
    }

    return @path;
}

my @treasures = (
    Position->new(2, 4),
    Position->new(4, 2),
    Position->new(5, 1),
    Position->new(6, 0),
    Position->new(6, 1),
    Position->new(7, 1),
);

my $shortest = 'inf';
my @shortestPath;
my @permutations;
permute { push @permutations, \@_; } @treasures;

for my $perm (@permutations) {
    my $knight = Position->new(0, 0);

    my @path = makePath($knight, $perm);

    if (scalar @path < $shortest) {
        $shortest = scalar @path;
        @shortestPath = @path;
    }
}

say join q{ }, map { $_-> str } @shortestPath;
