#!/usr/bin/env raku

sub date-diference (Date() $start, Date() $end) {
    my @year-seq = $start, *.later(:1year) ...^ * > $end;
    my $year = @year-seq.elems - 1 ;
    my $day = $end - @year-seq.tail;
    \(:$year, :$day)
}

multi MAIN (Bool :test($)!) {
    use Test;
    is date-diference('2019-02-10','2022-11-01').<year day>, (3, 264);
    is date-diference('2020-09-15','2022-03-29').<year day>, (1, 195);
    is date-diference('2020-09-15','2022-03-09').<year day>, (1, 175);
    is date-diference('2019-12-31','2020-01-01').<year day>, (0,   1);
    is date-diference('2019-12-01','2019-12-31').<year day>, (0,  30);
    is date-diference('2019-12-31','2021-12-31').<year day>, (2,   0);
    is date-diference('2019-12-31','2020-12-31').<year day>, (1,   0);
    is date-diference('2020-09-15','2021-09-16').<year day>, (1,   1);
    is date-diference('2019-09-15','2021-09-16').<year day>, (2,   1);
    done-testing;
}

multi MAIN (Date() $start, Date() $end) {
    say date-diference $start, $end
}
