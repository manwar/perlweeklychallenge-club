use v6;

sub get-count (\i, \j) {
    my $count = 0;
    my @positions;
    for -1, 0, +1 -> $k {
        for -1, 0, +1 -> $m {
            push @positions, (i + $k, j + $m) unless $k == $m == 0;
        }
    }
    my $count-mines = 0;
    for @positions -> $pos {
        next if $pos[0] | $pos[1] < 0;
        next if $pos[0] > $*max-i or $pos[1] > $*max-j;
        $count-mines++ if @*mine-field[$pos[0]][$pos[1]] eq 'x';
    }
    return $count-mines;
}

my @in-str =
    "x * * * x * x x x x",
    "* * * * * * * * * x",
    "* * * * x * x * x *",
    "* * * x x * * * * *",
    "x * * * x * * * * x";

my @*mine-field;
# Populating an AoA from the array of strings
for @in-str -> $line {
    push @*mine-field, [split /\s+/, $line];
}
say join "\n", @*mine-field, "\n";
my $*max-i = @*mine-field.end;
my $*max-j = @*mine-field[0].end;
for 0..$*max-i -> $i {
    for 0..$*max-j -> $j {
        next if @*mine-field[$i][$j] eq 'x';
        @*mine-field[$i][$j] = get-count $i, $j;
    }
}
say join "\n", @*mine-field;
