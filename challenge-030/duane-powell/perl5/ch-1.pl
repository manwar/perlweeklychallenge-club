#!/usr/bin/perl
use warnings;
use strict;

# Write a script to list dates for Sunday Christmas between 2019 and 2100. For example, 25 Dec 2022 is Sunday.

use DateTime;
use constant SUNDAY   => 7;
use constant DECEMBER => 12;
use constant XMAS     => 25;

print "List of Sunday Christmas between 2019 and 2100\n";
foreach my $year (2019 .. 2100) {
	my $dt = DateTime->new(
		'year'   => $year,
		'month'  => DECEMBER,
		'day'    => XMAS,
	);

	print "$year/12/25\n" if ($dt->day_of_week == SUNDAY); 
}

__END__

./ch-1.pl
List of Sunday Christmas between 2019 and 2100
2022/12/25
2033/12/25
2039/12/25
2044/12/25
2050/12/25
2061/12/25
2067/12/25
2072/12/25
2078/12/25
2089/12/25
2095/12/25
