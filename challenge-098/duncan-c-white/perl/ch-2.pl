#!/usr/bin/perl
# 
# Task 2: "Search Insert Position
# 
# You are given a sorted array of distinct integers @N and a target $N.
# Write a script to return the index of the given target if found otherwise
# place the target in the sorted array and return the index.
# 
# Example 1:
# 
# 	Input: @N = (1, 2, 3, 4) and $N = 3
# 	Output: 2 since the target 3 is in the array at the index 2.
# 
# Example 2:
# 
# 	Input: @N = (1, 3, 5, 7) and $N = 6
# 	Output: 3 since the target 6 is missing and
# 	   should be placed at the index 3.
# 
# Example 3:
# 
# 	Input: @N = (12, 14, 16, 18) and $N = 10
# 	Output: 0 since the target 10 is missing and
# 	   should be placed at the index 0.
# 
# Example 4:
# 
# 	Input: @N = (11, 13, 15, 17) and $N = 19
# 	Output: 4 since the target 19 is missing and
# 	   should be placed at the index 4.
# "
# 
# My notes: nice question.  Clearly defined for once:-)
# Note that inserting the element in the list only matters if
# we print the list out, so let's do that.
# Also added decent amount of input checking (is the list sorted etc)
# Also added test suite [invoke with --test]
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Function::Parameters;
use Data::Dumper;

my $debug=0;
my $test=0;
die "Usage: search-insert-position [--test] [--debug]\n".
    "Or...  search-insert-position [--debug] N sorted-numeric-list\n"
	unless GetOptions( "debug" => \$debug, "test" => \$test )
	    && ($test && @ARGV==0 || !$test && @ARGV>=2);

if( $test )
{
	dotests();
	exit 0;
}

my( $n, @values ) = @ARGV;
# allow list to be separate args (eg 1 2 3 4) or csv (eg 1,2,3,4)
my $instr = join(',', @values);
@values = split(/,/,$instr);

die "search-insert-position: list must be sorted\n" unless
	isnumericallysorted(@values);
my $pos = findorinsert( $n, \@values );
say "insertion pos: $pos";
say "values after: ", join(',',@values);


#
# my $issorted = isnumericallysorted( @x );
#	Return true iff the element in @x are numerically sorted;
#	false otherwise.
#
fun isnumericallysorted( @x )
{
	my $prev = shift @x;
	foreach my $next (@x)
	{
		return 0 if $next < $prev;
		$prev = $next;
	}
	return 1;
}

#
# my $pos = findorinsert( $target, $values );
#	Implement the core problem of this task:
#	Return the index of the given $target in sorted array @$values if
#	found otherwise place the target in the sorted array and return
#	the index.
#
fun findorinsert( $target, $values )
{
	foreach my $pos (0..$#$values)
	{
		my $v = $values->[$pos];
		if( $v == $target )
		{
			say "debug: found $target at pos $pos" if $debug;
			return $pos;
		}
		if( $v > $target )
		{
			say "debug: inserting $target at pos $pos" if $debug;
			splice( @$values, $pos, 0, $target );
			return $pos;
		}
	}
	say "debug: appending $target at end" if $debug;
	push( @$values, $target );
	return $#$values;
}


#
# dotests();
#	Do a load of tests.
#
fun dotests()
{
	eval "use Test::More"; die $@ if $@;

# format of each list: inputlist (eg 1,2,3,4):target:pos[:modifiedlist]
my @tests = (
	"1,2,3,4:3:2",
	"1,2,3,4:4:3",
	"1,2,3,4:2:1",
	"1,2,3,4:7:4:1,2,3,4,7",
	"10,20,30,40:7:0:7,10,20,30,40",
	"10,20,30,40:17:1:10,17,20,30,40",
	"1,2,3,4:5:4:1,2,3,4,5",
);

	say "dotests() entry" if $debug;
	say "dotests(): tests=". Dumper(\@tests) if $debug;
	foreach my $test (@tests)
	{
		say "test $test" if $debug;
		my( $input, $target, $exppos, $output ) = split( /:/, $test );
		$output //= '';
		die "dotests: bad input $input\n" unless
			$input =~ /^(\d+,)*\d+$/;
		die "dotests: bad target $target\n" unless
			$target > 0;
		die "dotests: bad pos $exppos\n" unless $exppos >= 0;
		die "dotests: bad output $output\n" unless
			$output eq '' || $output =~ /^(\d+,)*\d+$/;
		my @i = split(/,/, $input);
		$output = $input if $output eq '';

		my $pos = findorinsert( $target, \@i );
		say "insertion pos: $pos" if $debug;
		say "values after: ", join(',',@i) if $debug;
		my $fin = "findinsert($target,". join(',',@i).") ";
		is( $pos, $exppos, " $fin: position $exppos" );
		is( join(',',@i), $output, " $fin: output $output" );

	}
	done_testing();
	say "dotests() exit" if $debug;
}
