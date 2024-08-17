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
    return 1;
}

sub stepCost(Position $position) {
    return 1;
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

sub search(Position @path, Position $target, Int $cost, Int $bound) {
    my $current = @path[*-1];

    my $estimate = $cost + estimatedCost($current, $target);
    if $estimate > $bound {
        return $estimate;
    }

    if $current == $target {
        return -∞;
    }

    my $min = ∞;

    for possibleMoves($current, $target) -> $move {
        if $move ⊄ @path {
            @path.push($move);
            my $t = search(@path, $target, $cost + stepCost($move), $bound);

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

sub makePath(Position $current, Position $target) {
    my Position @path = [ $current ];
    my $bound = estimatedCost($current, $target);

    loop {
        my $t = search(@path, $target, 0, $bound);

        if $t ~~ -∞ {
            last;
        }

        # Can't solve; this shouldn't happen.
        if $t ~~ ∞ {
            last;
        }

        $bound = $t;
    }

    return @path;
}

sub MAIN(
    Str $s where  $s.chars == 2 ,
    Str $e where $e.chars == 2
) {

    my ($sc, $sr) = $s.comb;
    my ($ec, $er) = $e.comb;
    my $start = Position.new('8'.ord - $sr.ord, $sc.ord - 'a'.ord );
    my $end = Position.new('8'.ord - $er.ord, $ec.ord - 'a'.ord);

    say makePath($start, $end).elems - 1;

}