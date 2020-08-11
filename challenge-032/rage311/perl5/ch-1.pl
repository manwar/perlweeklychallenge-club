#!/usr/bin/env perl

# 032-1
# Create a script that either reads standard input or one or more files
# specified on the command-line. Count the number of times and then print a
# summary, sorted by the count of each entry.

use 5.030;
use strict;
use warnings;

use Getopt::Long;

my $csv = 0;
GetOptions csv => \$csv;

undef $/;
my %count;

# file names
if (@ARGV) {
  while (my $file = shift @ARGV) {
    open my $fh, '<', $file or warn "$!" and next;
    $count{$_}++ for split /\n/, <$fh>;
  }
}
# STDIN
else {
  $count{$_}++ for split /\n/, <<>>;
}

say for map {
    join $csv ? ',' : "\t", $_, $count{$_}
  } sort {
    $count{$b} <=> $count{$a}
  } keys %count;


__DATA__

Output:

cat example.txt | perl ch-1.pl
apple   3
cherry  2
banana  1

cat example.txt | perl ch-1.pl --csv
apple,3
cherry,2
banana,1

perl ch-1.pl example.txt
apple   3
cherry  2
banana  1

perl ch-1.pl --csv *.txt
apple,9
cherry,6
banana,3

