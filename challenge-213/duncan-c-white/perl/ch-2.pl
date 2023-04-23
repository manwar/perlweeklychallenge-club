#!/usr/bin/perl
#
# Task 2: Shortest Route
# 
# You are given a list of bidirectional routes defining a network of nodes,
# as well as source and destination node numbers.  Write a script to find
# the route from source to destination that passes through fewest nodes.
# 
# Example 1:
# 
#   Input: @routes = ([1,2,6], [5,6,7])
#          $source = 1
#          $destination = 7
# 
#   Output: (1,2,6,7)
# 
#   Source (1) is part of route [1,2,6] so the journey looks like 1 -> 2 -> 6
#   then jump to route [5,6,7] and takes the route 6 -> 7.
#   So the final route is (1,2,6,7)
# 
# Example 2:
# 
#   Input: @routes = ([1,2,3], [4,5,6])
#          $source = 2
#          $destination = 5
# 
#   Output: -1
# 
# Example 3:
# 
#   Input: @routes = ([1,2,3], [4,5,6], [3,8,9], [7,8])
#          $source = 1
#          $destination = 7
#   Output: (1,2,3,8,7)
# 
#   Source (1) is part of route [1,2,3] so the journey looks like 1 -> 2 -> 3
#   then jump to route [3,8,9] and takes the route 3 -> 8
#   then jump to route [7,8] and takes the route 8 -> 7
#   So the final route is (1,2,3,8,7)
# 
# MY NOTES: hmmm.. weird "list of routes" data format.  Easier if we can
# convert the data into "normal" node -> list possible next nodes form.
# Shortest route means: find all routes and min() them?
# 
# GUEST LANGUAGE: I will translate ch-2.pl into C tomorrow. Run out of
# time to do it today.
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Data::Dumper;
use Function::Parameters;

my $debug=0;
die "Usage: shortest-route [--debug] start end intlist [intlist..]\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV > 3;


my @sr;		# curr shortest route
my $srlen; 	# current length of shortest route


#
# my @shortest = shortest_route( $start, $end, \%link );
#	Find the shortest route from $start to $end using links %link,
#
fun shortest_route( $start, $end, $link )
{
	@sr = ();
	$srlen = keys(%$link) + 1;
	all_routes( $start, $end, $link, [] );
	return @sr;
}

#
# all_routes( $start, $end, $link, $done );
#	Find all routes from $start to $end using links %$link,
#	where we have already visted @$done, and set @sr/$srlen
#	to the shortest route found.
#
fun all_routes( $start, $end, $link, $done )
{
	if( $start == $end )
	{
		# found route @$done . $end
		my @r = @$done;
		push @r, $end;
		say "debug: done:", join(',',@$done), " found new route ",
		    join(',',@r) if $debug;
		if( @r < $srlen )
		{
			$srlen = @r;
			@sr = @r;
			say "debug: done:", join(',',@$done),
			    " found new shortest route ", join(',',@r)
				if $debug;
		}
	}
	my %vis = map { $_ => 1 } @$done;		# already visited
	my @next = grep { ! $vis{$_} } @{$link->{$start}};
	say "debug: done:", join(',',@$done), " start=$start, end=$end, ",
	    "next=", join(',',@next) if $debug;
	
	my @newdone = @$done;
	push @newdone, $start;
	foreach my $node (@next)
	{
		all_routes( $node, $end, $link, \@newdone );
	}
}


my $start = shift;
my $end = shift;
my @route = map { [ split(/,/,$_) ] } @ARGV;

if( $debug )
{
	say "debug: start=$start, end=$end, routes: ";
	foreach my $r (@route)
	{
		say "route: ", join(',',@$r);
	}
}


my %link;	# node -> list(next node)
foreach my $route (@route)
{
	my @p = @$route;
	my $prev = shift @p;
	foreach my $node (@p)
	{
		$link{$prev} //= [];
		push @{$link{$prev}}, $node;
		$link{$node} //= [];
		push @{$link{$node}}, $prev;
		$prev = $node;
	}
}

if( $debug )
{
	foreach my $n (sort keys %link)
	{
		say "$n: ", join(',',@{$link{$n}});
	}
}

my @shortest = shortest_route( $start, $end, \%link );

if( @shortest )
{
	say join(',',@shortest);
} else
{
	say -1;
}
