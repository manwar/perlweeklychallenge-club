# The Weekly Challenge 175
# Task 1 Last Sunday
use v5.30.0;
use Time::Local qw'timegm_nocheck';
use Time::gmtime;


say join "\n", last_sun_year($ARGV[0] || 2022)->@*;


sub last_sun_month {
    my ($m, $y)= @_;
    my $n = gmtime timegm_nocheck 0, 0, 0, 1, $m+1, $y;
    my $constant = $n->wday() == 0 ? 7 : $n->wday();
    return (gmtime timegm_nocheck 0, 0, 0, 1-$constant, $m+1, $y);
}



sub date_str {
    my $d_s = $_[0];
    return 
         ($d_s->year()+1900)."-"
        .($d_s->mon()<=8 ? 0 : "").($d_s->mon()+1)."-"
        .($d_s->mday()<10 ? 0 : "").($d_s->mday())
}



sub last_sun_year {
    my $y = $_[0]-1900;
    my @suns = map {last_sun_month($_, $y)} (0..10);
    return [map {date_str $_} @suns, last_sun_month(-1, $y+1)];
}


use Test::More tests => 1;
use Test::Deep;
cmp_deeply 
    last_sun_year(2022), 
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
    "2022-12-25"];
