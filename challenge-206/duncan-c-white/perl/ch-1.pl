#!/usr/bin/perl
# 
# Task 1: Shortest Time
# 
# You are given a list of time points, at least 2, in the 24-hour clock
# format HH:MM.  Write a script to find out the shortest time in minutes
# between any two time points.
# 
# Example 1
# 
#   Input: @time = ("00:00", "23:55", "20:00")
#   Output: 5
# 
#   Since the difference between "00:00" and "23:55" is the shortest (5 minutes).
# 
# Example 2
# 
#   Input: @array = ("01:01", "00:50", "00:57")
#   Output: 4
# 
# Example 3
# 
#   Input: @array = ("10:10", "09:30", "09:00", "09:55")
#   Output: 15
# 
# MY NOTES: reasonably easy, although of course wraparound has to taken
# into account.  Might convert each hh:mm time into a number of minutes,
# then sort the array.. then check every adjacant pair (including the
# wraparound pair, i.e the last and the first)..
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Data::Dumper;

my $debug=0;
die "Usage: shortest-time [--debug] stringlist\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV>0;

#
# my $time = parsehhmm( $hhmm );
#	Parse a 24-hour hh:mm time string into the total number
#	of minutes since 00:00, and return it.
#
sub parsehhmm
{
	my( $hhmm ) = @_;
	$hhmm =~ /^(\d\d):(\d\d)$/  || die "parsehhmm: bad format $hhmm\n";
	return 60*$1 + $2;
}



my @list = split( /,/, join(',',@ARGV) );

@list = map { parsehhmm($_) } @list;

say "parsed: ", join(',',@list) if $debug;

@list = sort { $a <=> $b } @list;

say "sorted: ", join(',',@list) if $debug;

my $best   = 1440;
my $bestt1 = -1;
my $bestt2 = -1;

push @list, 1440 + $list[0];

say "wraparound: ", join(',',@list) if $debug;

foreach my $pos (0..$#list-1)
{
	my $t = $list[$pos+1];
	my $diff = $t - $list[$pos];
	say "pos $pos, diff $diff" if $debug;
	if( $best > $diff )
	{
		$best = $diff;
		$bestt1 = $list[$pos];
		$bestt2 = $t;
	}
}

say $best;

if( $debug )
{
	$bestt1 = sprintf( "%02d:%02d", $bestt1/60, $bestt1%60 );
	$bestt2 = sprintf( "%02d:%02d", $bestt2/60, $bestt2%60 );
	say "($bestt1..$bestt2)";
}
