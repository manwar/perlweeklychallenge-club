for ('2019-02-10', '2022-11-01'),
    ('2020-09-15', '2022-03-29'),
    ('2019-12-31', '2020-01-01'),
    ('2019-12-01', '2019-12-31'),
    ('2019-12-31', '2020-12-31'),
    ('2019-12-31', '2021-12-31'),
    ('2020-09-15', '2020-09-16'),
    ('2019-09-15', '2021-09-16') -> @test {
    my @dates = map {Date.new($_) }, sort @test;
    my $delta-y = @dates[1].year - @dates[0].year;
    my ($y, $m, $d) = @dates[0].year, @dates[0].month.fmt("%02d"),
        @dates[0].day.fmt("%02d");
    $delta-y -= 1 if "$m$d" > join "", @dates[1].month.fmt("%02d"),
        @dates[1].day.fmt("%02d");
    $y += $delta-y;
    my $new-date = Date.new("$y-$m-$d");
    my $delta-d = @dates[1] - $new-date;
    say "@dates[]: $delta-y year(s) {$delta-d.fmt("%3d")} day(s)";
}
