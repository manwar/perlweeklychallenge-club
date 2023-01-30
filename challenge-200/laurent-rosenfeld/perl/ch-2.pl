use strict;
use warnings;
use feature "say";

my %c;                   # ascii coding of digit's slices
$c{'h'} = "-" x 7;       # Horizontal line
$c{'l'} = "|      ";     # Vertical bar, left
$c{'r'} = "      |";     # Vertical bar, right
$c{'2'} = "|     |";     # 2 vertical bars
$c{'n'} = " " x 7;       # empty horizontal line

my @nums = (             # Digit hoirizontal slices
    [<h 2 2 n 2 2 h>],   # 0
    [<n r r n r r n>],   # 1
    [<h r r h l l h>],   # 2
    [<h r r h r r h>],   # 3
    [<n 2 2 h r r n>],   # 4
    [<h l l h r r h>],   # 5
    [<n l l h 2 2 h>],   # 6
    [<h r r n r r n>],   # 7
    [<h 2 2 h 2 2 h>],   # 8
    [<h 2 2 h r r n>]);  # 9


sub display{
    my @digits = split //, shift;
    for my $l (0..6) {
        say join "  ", map {$c{$nums[$_][$l]}} @digits;
    }
}

for my $test (<200 2023 01234 56789>) {
  display $test;
}
