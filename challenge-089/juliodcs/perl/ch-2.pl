use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub set_positions($matrix, $side) {
    my $y = int($side / 2);
    my $x = $side - 1;
    for my $number (1 .. $side ** 2) {
        if ($y == 0 && $x == $side - 1) {
            $x--;
        }
        elsif ($number > 1) {
            $y = ($y - 1) % $side;
            $x = ($x + 1) % $side;
        }
        
        if ($matrix->[$y][$x] != 0) {
            $y = ($y + 1) % $side;
            $x = ($x - 2) % $side;
        }

        $matrix->[$y][$x] = $number;
    }
}

sub print_magic($side) {
    die 'Not an odd matrix' unless $side % 2;
    my @matrix;
    push @matrix, [(0) x $side] for 1 .. $side;
    set_positions(\@matrix, $side);
    display_matrix(\@matrix, $side);
}

sub display_matrix($matrix, $side) {
    my $sum = $side * (1 + $side ** 2) / 2;
    my $max_number = length($side * $side);

    say "The sum for a $side-side matrix is: $sum";

    for my $row ($matrix->@*) {
        say join ' ', map { sprintf "%${max_number}s", $_ } $row->@*;
    }
}

say print_magic(3);
say print_magic(5);
say print_magic(7);
say print_magic(9);
say print_magic(11);
