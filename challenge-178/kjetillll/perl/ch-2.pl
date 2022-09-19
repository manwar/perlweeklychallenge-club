#!/usr/bin/perl
#https://theweeklychallenge.org/blog/perl-weekly-challenge-178/
use strict; use warnings; use v5.10; use Time::Local;

# I could have used Business::Hours::add_seconds() but wanted
# to try out my own ineffective but succinct algorithm instead:

sub ts_plus {
    no warnings 'recursion'; #no warn at dept 100
    my($ts, $hours, $min) = (@_,0,0);
    $hours < 0       ? die "ts_plus: negative hours"
   :$hours+$min == 0 ? $ts
   :$hours > 0       ? ts_plus( $ts, 0, 60*$hours + $min )
   :                   ts_plus( ts_plus1min($ts), 0, $min - ts_in_work_hours($ts) );
}

sub ts_plus1min {
    my @ts = shift() =~ /\d+/g;
    my @nt = gmtime(60 + timegm(0, @ts[4,3,2], $ts[1]-1, $ts[0]));
    sprintf "%04d-%02d-%02d %02d:%02d", $nt[5]+1900, $nt[4]+1, @nt[3,2,1];
}

sub ts_in_work_hours {
    my @ts = shift() =~ /\d+/g;
    my @nt = gmtime( timegm(0, @ts[4,3,2], $ts[1]-1, $ts[0]-1900) );
    my($hm, $wday) = ($nt[2]*100+$nt[1], $nt[6]);
    $hm>=900 and $hm<1800 and $wday =~ /^[1-5]$/;
}



use Test::More;
for(['2022-08-01 10:30', 4       => '2022-08-01 14:30'],
    ['2022-08-01 17:00', 3.5     => '2022-08-02 11:30'],
    ['2022-08-01 17:00', 0       => '2022-08-01 17:00'],
    ['2022-08-15 17:45', '0:01'  => '2022-08-15 17:46'],
    ['2022-08-15 17:59', '0:01'  => '2022-08-15 18:00'],
    ['2022-08-15 18:00', '0:01'  => '2022-08-16 09:01'],
    ['2022-08-15 18:00', '1:01'  => '2022-08-16 10:01'],
    ['2022-08-15 17:45', 3.5     => '2022-08-16 12:15'],
    ['2022-08-15 17:45', '3:30'  => '2022-08-16 12:15'],
    ['2022-08-12 17:45', '3:30'  => '2022-08-15 12:15'],
    ['2022-07-15 17:45', 140+2/3 => '2022-08-08 14:25'])
{   my($ts, $duration, $exp) = @$_;
    $duration = $` + $' / 60 if $duration =~ /:/;
    my $got = ts_plus($ts, $duration);
    is $got, $exp, "ts: $ts   duration: $duration   got: $got   expected: $exp";
}
done_testing;
