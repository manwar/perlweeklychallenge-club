my @mat = [ [ [<0 1 0 1>], [<0 0 1 0>], [<1 1 0 1>], [<1 0 0 1>] ],
            [ [<1 1 0 1>], [<1 1 0 0>], [<0 1 1 1>], [<1 0 1 1>] ],
            [ [<0 1 0 1>], [<1 0 1 0>], [<0 1 0 0>], [<1 0 0 1>] ],
            [ [<1 1 0 1 1 1>], [<1 1 1 0 1 0>], [<1 1 0 1 0 1>],
                [<1 1 1 0 0 1>] ],
          ];

for @mat -> @m {
    print-matrix @m;
    say "Number of matrices: ", find-squares(@m), "\n";
}
sub print-matrix (@matrix) {
    for @matrix -> @row {
        say '[ ', @row.join(" "), ' ]';
    }
    say " ";
}

sub find-squares (@matrix) {
    my $nb_lines = @matrix.elems;
    my $nb_col = @matrix[0].elems;
    my $nb_squares = 0;
    my $max_square_size = min $nb_lines, $nb_col;
    for 2..$max_square_size -> $square_size {
        for 0..$nb_col - $square_size -> $j {
            for 0..$nb_lines - $square_size -> $i {
                next if @matrix[$i][$j] == 0;
                next if @matrix[$i][$j+$square_size-1] == 0;
                next if @matrix[$i+$square_size-1][$j] == 0;
                next if @matrix[$i+$square_size-1][$j+$square_size-1] == 0;
                say "Value in position $i, $j is the top left corner of a square of size $square_size";
                $nb_squares++;
            }
        }
    }
    return $nb_squares;
}
