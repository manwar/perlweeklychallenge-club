# Task 1 of the Weekly Challenge 351
# https://theweeklychallenge.org/blog/perl-weekly-challenge-351/#TASK1

say special-average 8000, 5000, 6000, 2000, 3000, 7000; # 5250
say special-average 100_000, 80_000, 110_000, 90_000; # 95000
say special-average 2500, 2500, 2500, 2500; # 0
say special-average 2000; # 0
say special-average 1000, 2000, 3000, 4000, 5000, 6000; # 3500


sub special-average (*@data) {
    my $min = @data.min;
    my $max = @data.max;

    my @selected = @data.grep: * != any($min, $max);

    return 0 unless @selected.elems;
    return @selected.sum / @selected.elems;
}
