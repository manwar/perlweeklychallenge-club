#!/usr/bin/perl
#
# Challenge 1: "Count instances: Create a script that either reads standard
# input or one or more files specified on the command-line. Count the number
# of times and then print a summary, sorted by the count of each entry.
# 
# So with the following input in file example.txt
# 
# apple
# banana
# apple
# cherry
# cherry
# apple
# 
# the script would display something like:
# 
# apple     3
# cherry    2
# banana    1
# 
# For extra credit, add a -csv option to your script, which would generate:
# 
# apple,3
# cherry,2
# banana,1
# 
# My notes: Straightforward use of a hash.
#

use v5.10;	# to get "say"
use strict;
use warnings;
use Getopt::Long;

my $csv = 0;
die "Usage: ch-1.pl [--csv] filter_args\n"
	unless GetOptions( "csv" => \$csv );
my $sep = $csv ? ',' : ' ';

my %freq;
while( <> )
{
	chomp;
	$freq{$_}++;
}

foreach my $str (sort { $freq{$b} <=> $freq{$a} } keys %freq)
{
	my $v = $freq{$str};
	say "$str$sep$v";
}
