use v5.38;

# Returns true if a square with side length lvl exists at location i, j
sub detect($i, $j, $lvl, $height, $width, @matrix) {
    return 0 if ($i + $lvl > $height || $j + $lvl > $width);
    for my $i_ ($i .. $i + $lvl - 1) {
        for my $j_ ($j .. $j + $lvl - 1) {
            return 0 if (0 == ${$matrix[$i_]}[$j_]);
        }
    }
    return 1;
}

sub proc(@matrix) {
    say "Input: ";
    say "\t@$_" for (@matrix);
    my $width = scalar @{$matrix[0]};
    my $height = scalar @matrix;
    my $area = 0;
    my $lvl = 2;
    for my $i (0 .. $height - 1) {
        for my $j (0 .. $width - 1) {
            next if (0 == ${$matrix[$i]}[$j]);
            $area = $area || 1;
            while (detect($i, $j, $lvl, $height, $width, @matrix) == 1) {
                $area = $lvl * $lvl;
                $lvl++;
            }
        }
    }
    say "\nOutput: $area\n";
}

my @matrix = ([1, 0, 1, 0, 0],
              [1, 0, 1, 1, 1],
              [1, 1, 1, 1, 1],
              [1, 0, 0, 1, 0]);
proc(@matrix);
@matrix = ([0, 1],
           [1, 0]);
proc(@matrix);
@matrix = ([0]);
proc(@matrix);
