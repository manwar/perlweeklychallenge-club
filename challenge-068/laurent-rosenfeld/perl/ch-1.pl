use strict;
use warnings;
use feature qw/say/;

sub display {
    say "@$_" for @_; say "";
}

my @matrix = ([1, 1, 1], [1, 0, 1], [1, 1, 1], [1, 1, 1]);
display @matrix;
my @new_matrix;
push @new_matrix, [ @$_ ] for @matrix; # deep copy
for my $i (0..$#matrix) {
    for my $j (0..scalar @{$matrix[$i]} - 1) {
        if ($matrix[$i][$j] == 0) {
            $new_matrix[$i] = [ (0) x scalar @{$matrix[$i]} ];
            $new_matrix[$_][$j] = 0 for 0..$#matrix;
        }
    }
}
display @new_matrix;
