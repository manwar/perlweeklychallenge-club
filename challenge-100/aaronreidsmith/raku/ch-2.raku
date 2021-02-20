#!/usr/bin/env raku

sub challenge(@triangle) {
    my @layers = (0..@triangle.end);
    my @indices = gather {
        for @triangle -> @layer {
            take (0..@layer.end).List;
        }
    }
    my @paths = gather {
        for ([X] @indices) -> @path {
            my @zipped = @path Z @path[1..*];
            my $valid = True;
            for @zipped -> ($a, $b) {
                if $b < $a || $b > $a + 1 {
                    $valid = False;
                    last;
                }
            }
            take @path if $valid;
        }
    }
    my @sums = gather {
        my $sum = 0;
        for @paths -> @path {
            for @layers Z @path -> ($layer, $index) {
                $sum += @triangle[$layer][$index];
            }
            take $sum;
            $sum = 0;
        }
    }
    @sums.min;
}

multi sub MAIN(*@N where all(@N) ~~ Int) {
    my ($index, $size) = (0, 1);
    my @triangle;
    while $index <= @N.end {
        my $end-index = $index + $size;

        my @layer = @N[$index..^$end-index];
        @triangle.push(@layer);

        $index = $end-index;
        $size++;
    }
    say challenge(@triangle);
}

multi sub MAIN(Bool :$test) {
    use Test;

    my @tests = (
        (((1,), (2, 4), (6, 4, 9), (5, 1, 7, 2)), 8),
        (((3,), (3, 1), (5, 2, 3), (4, 3, 1, 3)), 7)
    );

    for @tests -> (@triangle, $expected) {
        is(challenge(@triangle), $expected);
    }

    done-testing;
}
