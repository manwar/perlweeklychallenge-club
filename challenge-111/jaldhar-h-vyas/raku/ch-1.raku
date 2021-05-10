#!/usr/bin/raku

sub MAIN() {
    my @matrix = (1 .. 50).pick(25).sort.batch(5);
    my $input = (1 .. 50).pick;
    my $output = 0;

    for 0 ..^ @matrix.elems -> $i {
        if $input <=  @matrix[$i][*-1] {
            for 0 ..^ @matrix[$i].elems -> $j {
                if @matrix[$i][$j] == $input {
                    $output = 1;
                    last;
                }
            }
            last;
        }
    }

    for 0 .. 4 -> $i {
        print $i ?? q{        } !! 'matrix: ';
        say q{[ }, @matrix[$i].map({ sprintf("%2d", $_)}).join(q{, }), q{ ]};
    }
    say "\nInput: ", $input;
    say $output;
}