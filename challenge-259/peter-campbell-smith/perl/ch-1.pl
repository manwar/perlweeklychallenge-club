#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2024-03-04
use utf8;     # Week 259 - task 1 - Banking day offset
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';

use Time::Local;

banking_day_offset('2024-03-04', 5);
banking_day_offset('2024-03-28', 1); # Easter weekend
banking_day_offset('2024-01-02', 254);
banking_day_offset('1970-01-01', 10000);

sub banking_day_offset {
	
	my ($start_date, $unix_date, $one_day, $hol_year, @d, 
		$year, @hols, $hol_string, $ymd_date, $offset);
	
	($start_date, $offset) = @_;

	# initialise
	say qq[\nInput:  \$start_date = '$start_date', \$offset = $offset];
	$start_date =~ m|(....)-(..)-(..)|;
	$unix_date = timelocal(0, 0, 12, $3, $2 - 1, $1 - 1900);
	
	$one_day = 86400; # secs in a day
	$hol_year = 0;
	
	# move forward day by day
	while ($offset > 0) {
		$unix_date += $one_day;
		@d = localtime($unix_date);
		
		# weekend no good
		next if ($d[6] == 0 or $d[6] == 6);
		
		# bank holiday no good
		$year = $d[5] + 1900;
		if ($hol_year != $year) {
			@hols = bank_hols($year);
			$hol_string = join('|', @hols);
			$hol_year = $year;
		}
		$ymd_date = sprintf('%04d-%02d-%02d', $year, $d[4] + 1, $d[3]);
		next if $ymd_date =~ m|$hol_string|;
	
		# decrement $offset until 0
		$offset --;		
	}
	
	say qq[Output: '$ymd_date'];
}

sub bank_hols { 	# (year as yyyy)

	# pjcs - 2001-01-29
	
	my ($year, @hols, $thedate, @d, $x, $dow, $a, $b, $c, $d, $e, $f, $g, 
		$h, $i, $k, $l, $m, $n, $p, $gf);

	# get unix year
	$year = $_[0] - 1900;

	# New Year = first non-weekend day in year
	$thedate = timelocal(0, 0, 12, 1, 0, $year);
	($x, $x, $x, $x, $x, $x, $dow) = localtime($thedate);
	$thedate += 86400 if $dow == 0;
	$thedate += 172800 if $dow == 6;
	@d = localtime($thedate);
	push @hols, sprintf('%04d-%02d-%02d', $d[5] + 1900, $d[4] + 1, $d[3]);

	# Good Friday = two days before Easter

# easter algorithm

# Divide                         by       Quotient     Remainder
#
# the year                       19          -             a
# the year                      100          b             c
# b                               4          d             e
# b + 8                          25          f             -
# b - f + 1                       3          g             -
# 19*a + b - d - g + 15          30          -             h
# c                               4          i             k
# 32 + 2*e + 2*i - h - k          7          -             L
# a + 11*h + 22*L               451          m             -
# h + L - 7*m + 114              31          n             p
#
# then Easter falls on day p+1 of month n

	($x, $a) = quorem($year + 1900, 19);
	($b, $c) = quorem($year + 1900, 100);
	($d, $e) = quorem($b, 4);
	($f, $x) = quorem($b + 8, 25);
	($g, $x) = quorem($b - $f + 1, 3);
	($x, $h) = quorem(19 * $a + $b - $d - $g + 15, 30);
	($i, $k) = quorem($c, 4);
	($x, $l) = quorem(32 + 2 * $e + 2*$i - $h - $k, 7);
	($m, $x) = quorem($a + 11 * $h + 22 * $l, 451);
	($n, $p) = quorem($h + $l - 7 * $m + 114, 31);

	$thedate = timelocal(0, 0, 0, $p + 1, $n - 1, $year) - 172800;
	@d = localtime($thedate);
	push @hols, sprintf('%04d-%02d-%02d', $d[5] + 1900, $d[4] + 1, $d[3]);
	
	# Easter Monday = three days after Good Friday
	$thedate += 3 * 86400;
	@d = localtime($thedate);
	push @hols, sprintf('%04d-%02d-%02d', $d[5] + 1900, $d[4] + 1, $d[3]);

	# May Day = first Monday in May
	$thedate = timelocal(0, 0, 0, 1, 4, $year);
	($x, $x, $x, $x, $x, $x, $dow) = localtime($thedate);
	$dow = -1 if $dow == 6;
	$thedate += (1 - $dow) * 86400 if $dow <= 0;
	$thedate += (8 - $dow) * 86400 if $dow >= 2;
	$thedate += 172800 if $dow == 6;
	@d = localtime($thedate);
	push @hols, sprintf('%04d-%02d-%02d', $d[5] + 1900, $d[4] + 1, $d[3]);

	# Spring bank holiday - last Monday	in May
	$thedate = timelocal(0, 0, 0, 1, 5, $year);
	($x, $x, $x, $x, $x, $x, $dow) = localtime($thedate);
	$thedate -= ($dow - 1) * 86400 if $dow >= 2;
	$thedate -= ($dow + 6) * 86400 if $dow <= 1;
	@d = localtime($thedate);
	push @hols, sprintf('%04d-%02d-%02d', $d[5] + 1900, $d[4] + 1, $d[3]);

	# Summer bank holiday - last Monday in August
	$thedate = timelocal(0, 0, 0, 1, 8, $year);
	($x, $x, $x, $x, $x, $x, $dow) = localtime($thedate);
	$thedate -= ($dow - 1) * 86400 if $dow >= 2;
	$thedate -= ($dow + 6) * 86400 if $dow <= 1;
	@d = localtime($thedate);
	push @hols, sprintf('%04d-%02d-%02d', $d[5] + 1900, $d[4] + 1, $d[3]);

	# Christmas and Boxing Day - 2 weekdays on or after 25 December
	$thedate = timelocal(0, 0, 12, 24, 11, $year);
	for $k (0 .. 1) {
		do {
			$thedate += 86400;
			($x, $x, $x, $x, $x, $x, $dow) = localtime($thedate);
		} until ($dow >= 1 and $dow <= 5);
		@d = localtime($thedate);
		push @hols, sprintf('%04d-%02d-%02d', $d[5] + 1900, $d[4] + 1, $d[3]);
	}

	return @hols;
}

sub quorem {

#	quorem(a, b) returns (quotient, remainder) of a/b  (+ve integers only)

	return (int $_[0]/$_[1], $_[0]%$_[1]);
}
