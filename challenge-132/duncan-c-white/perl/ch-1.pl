#!/usr/bin/perl
# 
# TASK #1 - Mirror Dates
# 
# You are given a date (yyyy/mm/dd).
# 
# Assuming, the given date is your date of birth. Write a script to find
# the mirror dates of the given date.
# 
# Assuming today is 2021/09/22.
# 
# Example 1:
# 
# Input: 2021/09/18
# Output: 2021/09/14, 2021/09/26
# 
# On the date you were born, someone who was your current age, would have
# been born on 2021/09/14.  Someone born today will be your current age
# on 2021/09/26.
# 
# Example 2:
# 
# Input: 1975/10/10
# Output: 1929/10/27, 2067/09/05
# 
# On the date you were born, someone who was your current age, would have
# been born on 1929/10/27.  Someone born today will be your current age
# on 2067/09/05.
# 
# Example 3:
# 
# Input: 1967/02/14
# Output: 1912/07/08, 2076/04/30
# 
# On the date you were born, someone who was your current age, would have
# been born on 1912/07/08.  Someone born today will be your current age
# on 2076/04/30.
# 
# MY NOTES: Sounds like a pretty easy date manipulation exercise:  dob - delta,
# today + delta where delta = today - date.  The hardest part is working out
# which Date manipulation module to use, as Perl has so many.
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
#use Data::Dumper;
use Date::Simple ('date', 'today');

my $debug=0;
die "Usage: mirror-dates YOUR_DOB\n" unless
	GetOptions( "debug"=>\$debug ) && @ARGV==1;
my $dobstr = shift @ARGV;
$dobstr =~ s|/|-|g;		# Date::Simple likes YYYY-MM-DD not YYYY/MM/DD
my $dob = date($dobstr) || die "bad date: $dobstr\n";

my $today = today();
$today = date("2021-09-22") if $debug;	# use today=exampletoday if debugging
say "Using today = $today" if $debug;

say "dob=$dob, today=$today" if $debug;

my $delta = $today - $dob;
say "delta=$delta" if $debug;

my $before = $dob - $delta;
my $after = $today + $delta;

say "$before, $after";
