#!/usr/bin/perl6

sub MAIN(
    Str $file #= a file describing a matrix of 1's and 0's where every line
              #= is a row in the matrix.
) {
    my @matrix;
    for $file.IO.lines -> $line {
        @matrix.push($line.match(/ (0|1) /, :g));
    }

    my $maxheight = 0;
    my $maxwidth = 0;

    for 0 ..^ @matrix.elems -> $m {
        for 0 ..^ @matrix[$m].elems -> $n {
            if @matrix[$m][$n] == 1 {
                my $row = $m;
                my $col = $n;
                my $left = $n;
                my $height = 0;
                my $width = 0;
                while $col < @matrix[$row].elems && @matrix[$row][$col] == 1 {
                    $width++;
                    $col++;
                }

                while $row < @matrix.elems && @matrix[$row][$left ..^ $left + $width].all == 1 {
                    $height++;
                    $row++;
                }

                if $height * $width > $maxheight * $maxwidth {
                    $maxheight = $height;
                    $maxwidth = $width;
                }
            }
        }
    }

    if $maxheight * $maxwidth < 2 {
        say '0';
    } else {
        for 0 ..^ $maxheight {
            say q{[ }, "1 " x $maxwidth, q{]};
        }
    }
}