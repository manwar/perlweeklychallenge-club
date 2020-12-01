#!/usr/bin/perl6

sub MAIN(
    Str $file #= a file describing a matrix of numbers where every line
              #= is a row in the matrix.
) {
    my @matrix;
    for $file.IO.lines -> $line {
        @matrix.push($line.match(/ (\d+) /, :g));
    }

    my @spiral;
    my $top = 0;
    my $right = @matrix[0].elems - 1;
    my $bottom = @matrix.elems - 1;
    my $left = 0;

    while $top < @matrix.elems / 2 {
        if $top == $bottom {
            push @spiral, @matrix[$top][$left];
        } else {

            for $left .. $right -> $i {
                push @spiral, @matrix[$top][$i];
            }

            for $top ^..^ $bottom -> $i {
                push @spiral, @matrix[$i][$right];
            }

            for reverse $left .. $right -> $i {
                push @spiral, @matrix[$bottom][$i];
            }

            for reverse $top ^..^ $bottom -> $i {
                push @spiral, @matrix[$i][$left];
            }
        }

        $top++;
        $right--;
        $bottom--;
        $left++;
    }

    @spiral.join(q{, }).say;
}