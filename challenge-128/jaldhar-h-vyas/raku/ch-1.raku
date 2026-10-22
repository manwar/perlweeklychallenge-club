#!/usr/bin/raku

class Submatrix {
    has $.top is required;
    has $.left is required;
    has $.bottom is required;
    has $.right is required;
    has $.height;
    has $.width;
    has $.area;

    submethod TWEAK(:$top, :$left, :$bottom, :$right) {
        $!height = $bottom - $top + 1;
        $!width = $right - $left + 1;
        $!area = $!height * $!width;
    }
};

sub MAIN(
    *@args
) {
    my @matrix = @args.map({ $_.words });
    my $m = @matrix.end;
    my $n = @matrix[0].end;
    my $best = Submatrix.new(top => 0, left => 0, bottom => 0, right => 0);

    for  0 .. $m -> $top {
        for 0 .. $n -> $left {
            for $top .. $m -> $bottom {
                for $left .. $n -> $right {
                    my $current = Submatrix.new(top => $top, left => $left,
                        bottom => $bottom, right => $right);
                    my $isZero = True;

                    LOOP: for $top .. $bottom -> $row {
                        for $left .. $right -> $column {
                            if @matrix[$row][$column] != 0 {
                                $isZero = False;
                                last LOOP;
                            }
                        }
                     }

                    if $isZero && ($current.area() > $best.area() ||
                        $current.area() == $best.area() && $current.width() > $best.width()) {
                        $best = $current;
                    }
                }
            }
        }
    }

    for $best.top() .. $best.bottom() -> $row {
        say q{[ }, @matrix[$row][$best.left() .. $best.right()].join(q{ }), q{ ]};
    }
}
