# The Weekly Challenge 175
# Task 1 Last Sunday
use v6;
use Test;


sub lastsun ($s) {
    return $s.earlier(days => $s.day-of-week == 0 ?? 7 !! $s.day-of-week );
}



sub last_sun_year ($year) {
    my @ans;
    for (2..12) {
        my $m = $_ < 10 ?? '0'~"$_" !! $_;
        my $s = Date.new("2022-$m-01");
        my $n = lastsun $s;
        @ans.push($n);
    }
    my $ny = Date.new("{$year+1}-01-01");
    my $n = lastsun $ny;
    @ans.push($n);
    return @ans;
}



is( last_sun_year(2022), 
    ["2022-01-30",
    "2022-02-27",
    "2022-03-27",
    "2022-04-24",
    "2022-05-29",
    "2022-06-26",
    "2022-07-31",
    "2022-08-28",
    "2022-09-25",
    "2022-10-30",
    "2022-11-27",
    "2022-12-25"]
); 

plan 1;

done-testing;
