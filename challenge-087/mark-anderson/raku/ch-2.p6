use Test;
plan 4;

my @example1 = < 0 0 0 1 0 1 >,
               < 1 1 1 0 0 0 >,
               < 0 0 1 0 0 1 >,
               < 1 1 1 1 1 0 >,
               < 1 1 1 1 1 0 >;

my @example2 = < 1 0 1 0 1 0 >,
               < 0 1 0 1 0 1 >,
               < 1 0 1 0 1 0 >,
               < 0 1 0 1 0 1 >;
               
my @example3 = < 0 0 0 1 1 1 >,
               < 1 1 1 1 1 1 >,
               < 0 0 1 0 0 1 >,
               < 0 0 1 1 1 1 >,
               < 0 0 1 1 1 1 >;

my @example4 = < 0 0 1 1 >,
               < 0 0 1 1 >,
               < 0 0 1 1 >,
               < 0 0 1 1 >,
               < 0 0 1 1 >,
               < 0 0 1 1 >,
               < 0 0 1 1 >,
               < 0 0 1 1 >;

cmp-ok get-max-rectangle(@example1), &[eqv], [[1,1,1,1,1] xx 2], "Example 1";

ok     get-max-rectangle(@example2)    == 0,                     "Example 2";

cmp-ok get-max-rectangle(@example3), &[eqv], [[1,1,1,1] xx 2],   "Example 3";

cmp-ok get-max-rectangle(@example4), &[eqv], [[1,1] xx 8],       "Example 4";

sub get-max-rectangle(@matrix) {
    my @drawing;
    my @max-rectangle;
    my $max-area = 0;
    my $cols = @matrix[0].elems;
    my @histogram = 0 xx $cols;

    for @matrix -> @row {
        for ^@row -> $i {
            @histogram[$i] = @row[$i] ?? @histogram[$i]+1 !! 0;
        }
        get-drawing();
        check-for-rectangles();
    }

    return @max-rectangle || 0;

    sub get-drawing {
        @drawing = Empty;
        for @histogram.max-1...0 -> $r {
            for ^$cols -> $c {
                @drawing.push: @histogram[$c] > $r ?? 1 !! 0;
            }
        }
        @drawing = @drawing.rotor($cols).map(*.join);
    }

    sub check-for-rectangles {
        for ^@drawing.end -> $i {
            for @drawing[$i] ~~ m:g/1+/ -> $m {
                my $width  = $m.to - $m.from;
                my $height = min @histogram[$m.from..$m.to-1];
                my $area   = $width * $height;
                if $area > $max-area {
                    $max-area = $area;
                    @max-rectangle = [1 xx $width] xx $height;
                }
            }
        }
    }
}
