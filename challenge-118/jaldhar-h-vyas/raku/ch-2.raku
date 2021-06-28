#!/usr/bin/raku

class Position {
    has Int $.row is rw;
    has Int $.col is rw;

    method new( $row, $col ) {
        self.bless(:$row, :$col);
    }

    method Str {
        ('a'.ord + $!col).chr ~ (8 - $!row).Str;
    }
}

multi sub infix:<==>(Position $a, Position $b) returns Bool {
    return $a.row == $b.row && $a.col == $b.col;
}

sub estimatedCost(Position $position, Position $goal) {
    state @distance = [
        0, 3, 2, 3, 2, 3, 4, 5,
        3, 2, 1, 2, 3, 4, 3, 4,
        2, 1, 4, 3, 2, 3, 4, 5,
        3, 2, 3, 2, 3, 4, 3, 4,
        2, 3, 2, 3, 4, 3, 4, 5,
        3, 4, 3, 4, 3, 4, 5, 4,
        4, 3, 4, 3, 4, 5, 4, 5,
        5, 4, 5, 4, 5, 4, 5, 6
    ];

    return @distance[abs($position.row - $goal.row) * 8 +
        abs($position.col - $goal.col)];
}

sub tryMove(Position $position, Position $delta) {
    my $dest = $position.clone;
    $dest.row += $delta.row;
    $dest.col += $delta.col;
    return ($dest.row >= 0 && $dest.row < 8 && $dest.col >= 0 && $dest.col < 8)
        ?? $dest
        !! Nil;
}

sub possibleMoves(Position $position, Position $target) {
    state @deltas = [
        Position.new(-2, -1),
        Position.new(-2, 1),
        Position.new(-1, 2),
        Position.new(1, 2),
        Position.new(2, 1),
        Position.new(2, -1),
        Position.new(-1, -2),
        Position.new(1, -2)
    ];

    my @moves;
    for @deltas -> $delta {
        my $move = tryMove($position, $delta);
        if $move {
            @moves.push($move);
        }
    }

    @moves = @moves.sort({
        estimatedCost($^a, $target) < estimatedCost($^b, $target);
    });

    return @moves;
}

sub search(Position $target, Position @path, Int $estimate) {
    my $current = @path[*-1];
    my $cost = @path.elems + estimatedCost($current, $target);

    if $cost > $estimate {
        return $cost;
    }

    if $current == $target {
        return -∞;
    }

    my $min = ∞;

    for possibleMoves($current, $target) -> $move {
        if $move ⊄ @path {
            @path.push($move);
            my $t = search($target, @path, $estimate);

            if $t == -∞ {
                return -∞;
            }

            if $t < $min {
                $min = $t;
            }

            @path.pop;
        }
    }

    return $min;
}

sub makePath(Position $knight is rw, Position @targets) {
    my @path = [ $knight ];

    for @targets -> $target {
        my Position @stage = [ $knight ];
        my $estimate = estimatedCost($knight, $target);

        loop {
            my $t = search($target, @stage, $estimate);

            if $t ~~ -∞ {
                last;
            }

            # Can't solve; this shouldn't happen.
            if $t ~~ ∞ {
                last;
            }

            $estimate = $t;
        }

        @path.push(| @stage[1 .. *]);
        @stage = [];
        $knight = $target;
    }

    return @path;
}

sub MAIN() {

    my Position @treasures = [
        Position.new(2, 4),
        Position.new(4, 2),
        Position.new(5, 1),
        Position.new(6, 0),
        Position.new(6, 1),
        Position.new(7, 1),
    ];

    my $shortest = ∞;
    my @shortestPath;
    for @treasures.permutations -> @perm {
        my $knight = Position.new(0, 0);
        my Position @p = @perm;

        my @path = makePath($knight, @p);

        if @path.elems < $shortest {
            $shortest = @path.elems;
            @shortestPath = @path;
        }
    }

    @shortestPath.join(q{ }).say;
}