use v6;

for 1900..2100 -> $y {
    my $year = DateTime.new(:year($y));
    my $new-year-day = Date.new("$y-01-01").day-of-week;
    print "$y, " if $new-year-day == 4; # DoW 4 = Thursday
    print "$y, " if $year.is-leap-year and $new-year-day == 3;
}
say "";
