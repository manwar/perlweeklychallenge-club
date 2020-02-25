#!/usr/bin/perl
#
# Challenge 1: "A guest house had a policy that the light remain ON as
# long as the at least one guest is in the house. There is guest book
# which tracks all guest in/out time. Write a script to find out how long
# in minutes the light were ON.
# 
# Guest Book
# 
# 1) Alex    IN: 09:10 OUT: 09:45
# 2) Arnold  IN: 09:15 OUT: 09:33
# 3) Bob     IN: 09:22 OUT: 09:55
# 4) Charlie IN: 09:25 OUT: 10:05
# 5) Steve   IN: 09:33 OUT: 10:01
# 6) Roger   IN: 09:44 OUT: 10:12
# 7) David   IN: 09:57 OUT: 10:23
# 8) Neil    IN: 10:01 OUT: 10:19
# 9) Chris   IN: 10:10 OUT: 11:00
# "
# 
# My notes: Nice question.  Looks reasonably straightforward, especially if
# we may assume that the IN times are in time order (as they are in the example
# data above, and would naturally be in a physical guest book, where each person
# writes their name and "IN" time in the first free row.
# 
# Simpler version: When manually checking the answer, I realised that I didn't
# need the "future-time diary events", the callbacks, the "set of users who
# are in".  I don't need to know WHO is IN @ time T only whether or not ANYONE
# is.  This simpler algorithm REQUIRES that the IN times are in time order.
# 

use v5.10;	# to get "say"
use strict;
use warnings;
use Function::Parameters;
use Data::Dumper;

use lib qw(.);
use Tuple qw(tuple);

die "Usage: ch-1.pl GUEST_BOOK_FILENAME]\n" unless @ARGV==1;
my $filename = shift;


#
# my $t = t2i( $time );
#	Convert $time, a 24-hour clock hh:mm string, into an integer $t,
#	specifically 60*hh + mm.
#
fun t2i( $time )
{
	$time =~ /^(\d+):(\d+)$/;
	my( $h, $m ) = ( $1, $2 );
	return 60*$h+$m;
}


#
# my @data = parse_guestbook( $filename );
#	Given the $filename of the file containing the guest book data,
#	open and read the data from the guestbook file ($filename) (dying
#	if you can't open the guestbook), build and return @data, a list
#	of (person, timein, timeout) tuples.
#
fun parse_guestbook( $filename )
{
	open( my $fh, '<', $filename ) || die "can't open $filename\n";
	my @result;
	while( <$fh> )
	{
		chomp;
		# format is: 1) Alex    IN: 09:10 OUT: 09:45
		/^\s*\d+\)\s+(\w+)\s+IN:\s+(\S+)\s+OUT:\s+(\S+)\s*$/ ||
			die "bad format '$_' at line $. in $filename\n";
		my( $name, $intime, $outtime ) = ( $1, $2, $3 );
		push @result, tuple( $name, $intime, $outtime );
		#say "name=$name, intime=$intime, outtime=$outtime";
	}
	close( $fh );
	return @result;
}


my @data = parse_guestbook( $filename );
#die Dumper \@data;

# now, to calculate the number of minutes that the house light is ON
# (which in time happens whenever the house is NON EMPTY), run through
# the @data, maintaining the people set.

my $totaltime = 0;		# total time house is non empty (in minutes)
my $lighton = 0;		# is light on?
my $lightonuntil = "00:00";	# if light is on, until when? (hh:mm format)

foreach my $tuple (@data)
{
	my( $name, $intime, $outtime ) = $tuple->detuple;
	my $it = t2i( $intime );
	my $ot = t2i( $outtime );
	my $delta = $ot - $it;
	say "$name enters house at $intime, leaves at $outtime";

	unless( $lighton )
	{
		$lightonuntil = $outtime;
		$lighton = 1;
		$totaltime += $delta;
		say "Light on for $delta minutes ".
		    "(from $intime until $outtime), ".
		    "so totaltime $totaltime";
		next;
	}

	# we already know the light is on until $lightonuntil 
	# now we now that name is IN from $intime to $outtime

	# lou is lights on until (but in minutes since midnight)
	my $lou = t2i($lightonuntil);

	if( $it <= $lou )
	{
		# ok: light on ..lightonuntil and
		# also on from intime(<=lightonuntil)..outtime:

		# if outtime > lightonuntil then:
		#	extend light on from lightonuntil until new outtime,
		if( $ot > $lou )
		{
			# now know light is on from $lou to $ot:
			my $extraontime = $ot - $lou;
			$totaltime += $extraontime;
			my $from = $lightonuntil;
			$lightonuntil = $outtime;
			say "Light on for another $extraontime minutes ".
			    "(from $from until $outtime), ".
			    "totaltime now $totaltime";
		}
	} else
	{
		# (light on ..lightonuntil and on intime(>lightonuntil)..outtime:
		# so light OFF from lightonuntil .. intime
		# THEN ON from intime..outtime: that's $delta
		$lightonuntil = $outtime;
		$totaltime += $delta;
		say "Light on for $delta minutes ".
		    "(from $intime until $outtime), ".
		    "totaltime now $totaltime";
	}
}

say "\nLight was on for $totaltime minutes";
