#!/usr/bin/perl6

sub rotate(Int $angle) {
    my @matrix =
        [ 1, 2, 3 ],
        [ 4, 5, 6 ],
        [ 7, 8, 9 ],
    ;

    my $side = @matrix.elems;

    for (0 ..^ $angle / 90) {
        for (0 ..^ $side / 2) -> $row {
            for ($row ..^ $side - $row - 1) -> $col {
                my $temp = @matrix[$row][$col];

                @matrix[$row][$col] = @matrix[$side - 1 - $col][$row];

                @matrix[$side - 1 - $col][$row] =
                    @matrix[$side - 1 - $row][$side - 1 - $col]; 

                @matrix[$side - 1 - $row][$side - 1 - $col] =
                    @matrix[$col][$side - 1 - $row]; 

                @matrix[$col][$side - 1 -$row] = $temp;
            }
        }
    }

    return @matrix;
}

multi sub MAIN (
    Int $angle where { $angle == any (90, 180, 270) }  #= angle to rotate matrix (0, 90, 180, or 270)
) {

    for rotate($angle) -> @row {
        say '[ ', @row.join(q{, }), ' ]';
    }
}