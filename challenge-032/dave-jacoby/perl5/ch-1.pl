#!/usr/bin/env perl

# Task #1 - Count instances
# Create a script that either reads standard input or one or more files
# specified on the command-line. Count the number of times and then
# print a summary, sorted by the count of each entry.

# So with the following input in file example.txt

# apple
# banana
# apple
# cherry
# cherry
# apple

# the script would display something like:

# apple     3
# cherry    2
# banana    1

# For extra credit, add a -csv option to your script, which would generate:

# apple,3
# cherry,2
# banana,1

use strict;
use warnings;
use feature qw{ say };

use Getopt::Long;
my $csv = 0;
GetOptions( 'csv' => \$csv, );

# all the arguments are in ARGV, except we've removed the -csv flag with
# GetOptions, we just do a file test to make sure we can open them before
# opening them. We COULD test for repeated files, but we don't.

# and we use the hash to keep a count, rather than store as an array
# and count later.

my %lines;
if ( scalar @ARGV ) {
    for my $arg (@ARGV) {
        if ( -f $arg && open my $fh, '<', $arg ) {
            while (<$fh>) {
                chomp;
                $lines{$_}++;
            }
        }
    }
}
else {
    while (<STDIN>) {
        chomp;
        $lines{$_}++;
    }
}

my $separator = $csv ? ',' : "\t";
for my $k ( sort { $lines{$b} <=> $lines{$a} } keys %lines ) {
    my $v = $lines{$k};
    say join $separator, $k, $v;
}
