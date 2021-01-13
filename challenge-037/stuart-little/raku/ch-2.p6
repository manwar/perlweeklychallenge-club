#!/usr/bin/env perl6
use v6;
use HTTP::Tiny;

sub sec_daylight($month,$year) {
    my $url=qq{https://www.timeanddate.com/sun/uk/london?month=$month&year=$year};
    my $response = HTTP::Tiny.new.get: $url;
    $response<content>.decode ~~ m:g/\d+':'\d+':'\d+ <?before \< >/;
    return $/.map({ ($_.split(':').map(*.Int) Z* (60 ** 2, 60, 1)).sum }).sum;
}

sub sec_to_hms(Int $sec where * >= 0) {
    (($sec div (60 ** 2)), (($sec % (60 ** 2)) div 60), ($sec % 60));
}

say "Nov 2019 seconds of daylight: ", my $nov=sec_daylight(11,2019);
say "Dec 2019 seconds of daylight: ", my $dec=sec_daylight(12,2019);
say "Difference: {$dec - $nov} seconds, i.e. {((($dec-$nov).sign == -1) ?? "-" !! "")}(%s hours, %s minutes and %s seconds)".sprintf(|sec_to_hms(abs($dec-$nov))); 
