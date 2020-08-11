#!/usr/bin/perl

# Create a script that either reads standard input or one or more files specified on the command-line.
# Count the number of times and then print a summary, sorted by the count of each entry.

# The script would display something like:
# apple     3
# cherry    2
# banana    1

# For extra credit, add a -csv option to your script, which would generate:
# apple,3
# cherry,2
# banana,1

use strict;
use warnings;

my %list = ();
my $csv = shift if @ARGV && grep { $_ eq "-csv" } @ARGV;

chomp,$list{ $_ }++ while(<>);

my $format = $csv ? "%s,%s\n" : "%s\t%s\n";

map { printf $format,$_,$list{$_} } sort { $list{$b} <=> $list{$a} } keys %list

# perl ch-1.pl example1.txt

# apple   3
# cherry  2
# banana  1

# perl ch-1.pl example1.txt example2.txt

# apple   6
# cherry  4
# banana  2

# perl ch-1.pl -csv example1.txt example2.txt

# apple,6
# cherry,4
# banana,2
