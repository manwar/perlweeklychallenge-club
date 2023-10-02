use strict;
use warnings;

sub find_paths {
    my ($n, $pos, $path) = @_;
    $pos //= [0, 0];
    $path //= '';

    my %directions = (
        'R' => [0, 1],
        'L' => [1, 0],
        'H' => [1, 1]
    );
    my @paths;
    if ($pos->[0] == $n-1 && $pos->[1] == $n-1) {
        return ($path);
    }
    while (my ($move, $d) = each %directions) {
        my $new_pos = [$pos->[0] + $d->[0], $pos->[1] + $d->[1]];
        if (0 <= $new_pos->[0] && $new_pos->[0] < $n && $pos->[1] <= $new_pos->[1] && $new_pos->[1] < $n) {
            push @paths, find_paths($n, $new_pos, $path . $move);
        }
    }
    return @paths;
}

# For N = 1
print join(", ", find_paths(2)), "\n";

# For N = 2
print join(", ", find_paths(3)), "\n";

