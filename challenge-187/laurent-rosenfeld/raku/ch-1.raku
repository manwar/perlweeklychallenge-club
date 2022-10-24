my @m = < 0 31 28 31 30 31 30 31 31 30 31 30 31 >;
my $c = 1;
my %dates = map { $_ => $c++ },
            (map { ((1..@m[$_])>>.fmt("%02d-$_")) },
            map {.fmt("%02d")}, 1..12).flat;

sub compute-common ($sd1, $ed1, $sd2, $ed2) {
    my $start-common = max %dates{$sd1}, %dates{$sd2};
    my $end-common = min %dates{$ed1}, %dates{$ed2};
    return $end-common - $start-common + 1;
}

for <12-01 20-01 15-01 18-01>, <03-03 12-03 13-03 14-03>,
    <02-03 12-03 11-03 15-03>, <30-03 05-04 28-03 02-04>,
    <12-01 13-03 09-01 25-04>
        -> @input-dates {
    say "Number of days together for dates @input-dates[]: ", compute-common | @input-dates;
}
