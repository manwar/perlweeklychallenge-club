use strict;
use warnings;

sub reshape {
    my ($matrix, $r, $c) = @_;
    my $m = scalar @$matrix;
    my $n = scalar @{$matrix->[0]};

    if ($m * $n != $r * $c) {
        return 0;
    }

    my @result;
    for my $i (0 .. $r-1) {
        for my $j (0 .. $c-1) {
            my $idx = $j + $i * $c;
            my $x = int($idx / $n);
            my $y = $idx % $n;
            $result[$i][$j] = $matrix->[$x][$y];
        }
    }
    return \@result;
}

my $matrix = [[1, 2], [3, 4]];
my $r = 1;
my $c = 4;

my $result = reshape($matrix, $r, $c);
if ($result) {
    print "Reshaped matrix:\n";
    for my $row (@$result) {
        print join(" ", @$row), "\n";
    }
} else {
    print "Cannot reshape matrix\n";
}

