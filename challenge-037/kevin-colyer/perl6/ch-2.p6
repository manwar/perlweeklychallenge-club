#!/usr/bin/perl6
use v6;

use Test;

=begin pod

Task 37.2

Write a script to find out the DayLight gain/loss in the month of December 2019 as compared to November 2019 in the city of London. You can find out sunrise and sunset data for November 2019 and December 2019 for London.

N: https://www.timeanddate.com/sun/uk/london?month=11&year=2019
D: https://www.timeanddate.com/sun/uk/london?month=12&year=2019


=end pod

my %n =
1   => "-3:35",
2   => "-3:33",
3   => "-3:32",
4   => "-3:30",
5   => "-3:29",
6   => "-3:27",
7   => "-3:25",
8   => "-3:23",
9   => "-3:21",
10  => "-3:18",
11  => "-3:16",
12  => "-3:14",
13  => "-3:11",
14  => "-3:09",
15  => "-3:06",
16  => "-3:03",
17  => "-3:00",
18  => "-2:57",
19  => "-2:54",
20  => "-2:50",
21  => "-2:47",
22  => "-2:43",
23  => "-2:40",
24  => "-2:36",
25  => "-2:32",
26  => "-2:28",
27  => "-2:23",
28  => "-2:19",
29  => "-2:15",
30  => "-2:10";

my %d =
1   =>  "-2:05",
2   =>  "-2:00",
3   =>  "-1:55",
4   =>  "-1:50",
5   =>  "-1:45",
6   =>  "-1:39",
7   =>  "-1:34",
8   =>  "-1:28",
9   =>  "-1:22",
10  =>  "-1:16",
11  =>  "-1:10",
12  =>  "-1:04",
13  =>  "-0:58",
14  =>  "-0:52",
15  =>  "-0:46",
16  =>  "-0:39",
17  =>  "-0:33",
18  =>  "-0:27",
19  =>  "-0:20",
20  =>  "-0:14",
21  =>  "-0:07",
22  =>  "-0:01",
23  =>  "+0:05",
24  =>  "+0:11",
25  =>  "+0:18",
26  =>  "+0:24",
27  =>  "+0:31",
28  =>  "+0:37",
29  =>  "+0:44",
30  =>  "+0:50",
31  =>  "+0:56";

sub parse-duration($s) {
    my $sign=$s.substr(0,1);
    my @min-secs = $s.substr(1..*).split(":"); # assumes no hours... not robust!
    return ( @min-secs[0] * 60 + @min-secs[1] ) * ( $sign eq "-" ?? -1 !! 1 );
}

sub say-duration($d) {
    my $sign = $d < 0 ?? "-" !! "";
    # concats '-' if negative, then forces positive value, modular divides by 60 twice, reverses the list then sends each item to be formatted for printing and joins them with ':'. Phew!
    return $sign ~ $d.abs.polymod(60, 60).reverse>>.fmt("%02d").join(":");
}

say "Nov (gain/loss) hh:mm:ss " ~ say-duration [+] ( parse-duration $_ for %n.values ) ;
say "Dec (gain/loss) hh:mm:ss " ~ say-duration [+] ( parse-duration $_ for %d.values ) ;

