use v5.36;
use List::Util qw(all);

sub good_one($m, $iv, $dv) {
    my ($ix, $iy) = @$iv;
    my ($dx, $dy) = @$dv;
    my $seen = '';
    for my $i (0 .. $#$m) {
        my $x = $m->[$ix][$iy];
        unless (1 <= $x <= @$m && !vec($seen, $x, 1)) {
            return 0;
        }
        vec($seen, $x, 1) = 1;
        $ix += $dx;
        $iy += $dy;
    }
    return 1;
}

sub all_good($m) {
    all {
        good_one($m, [0, $_], [1, 0]) &&
        good_one($m, [$_, 0], [0, 1])
    } 0 .. $#$m
}

sub testprint($m) {
    say all_good($m) ? "true" : "false";
}

testprint [
    [1, 2, 3, 4],
    [2, 3, 4, 1],
    [3, 4, 1, 2],
    [4, 1, 2, 3],
];

testprint [[1]];

testprint [
    [1, 2, 5],
    [5, 1, 2],
    [2, 5, 1],
];

testprint [
    [1, 2, 3],
    [1, 2, 3],
    [1, 2, 3],
];

testprint [
    [1, 2, 3],
    [3, 1, 2],
    [3, 2, 1],
];
