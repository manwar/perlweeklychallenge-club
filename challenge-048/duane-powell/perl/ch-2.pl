#!/usr/bin/perl
use warnings;
use strict;
use feature 'say';
use DateTime;
use DateTime::Duration;

# Problem: https://perlweeklychallenge.org/blog/perl-weekly-challenge-048/ Task #2

my $year_end = shift || 3000;

my $dt  = DateTime->new('year' => 2000, 'month' => 1, 'day' => 1);
my $day = DateTime::Duration->new('days' => 1);

until ($dt->year == $year_end) {
	my @pali = split('',$dt->mdy);
	# @pali is a 10 element array MM-DD-YYYY
	say $dt->mdy() if ($pali[0] == $pali[9] and $pali[1] == $pali[8] and $pali[3] == $pali[7] and $pali[4] == $pali[6]);
	$dt->add( $day );
}

__END__

./ch-2.pl
10-02-2001
01-02-2010
11-02-2011
02-02-2020
12-02-2021
03-02-2030
04-02-2040
05-02-2050
06-02-2060
07-02-2070
08-02-2080
09-02-2090
10-12-2101
01-12-2110
11-12-2111
02-12-2120
12-12-2121
03-12-2130
04-12-2140
05-12-2150
06-12-2160
07-12-2170
08-12-2180
09-12-2190
10-22-2201
01-22-2210
11-22-2211
02-22-2220
12-22-2221
03-22-2230
04-22-2240
05-22-2250
06-22-2260
07-22-2270
08-22-2280
09-22-2290

