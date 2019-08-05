#!/usr/bin/perl
use Modern::Perl;
use DateTime;

# Find all year/months from 1900 to 2019 with 5 full weekends.
# Noting that it must be a month with 31 days and begin on a Friday yields:
my $FRIDAY = 5;

# Popluate a hash with months that have 31 days
my @mon_val = qw( Jan Mar May Jul Aug Oct Dec );
my @mon_key = (1,3,5,7,8,10,12); 
my %mon_31_days;
@mon_31_days{@mon_key} = @mon_val;

foreach my $year (1900 .. 2019) {
	foreach my $month (keys %mon_31_days) {
		my $dt = DateTime->new(
			'year'   => $year,
			'month'  => $month,
			'day'    => 1,
		);

		if ($dt->day_of_week == $FRIDAY) {
			say "$mon_31_days{$month} $year";
		}
	}
}

__END__

./ch1.pl
Mar 1901
Aug 1902
May 1903
Jan 1904
Jul 1904
Dec 1905
...
Mar 2013
Aug 2014
May 2015
Jan 2016
Jul 2016
Dec 2017
Mar 2019
