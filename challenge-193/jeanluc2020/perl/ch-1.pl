#!/usr/bin/perl
# task1.pl

use warnings;
use strict;

my $input = $ARGV[0];
$input //= 2;

my $LENGTH = 0;
my $MAX_WIDTH = 80;

print_binaries("", $input);
# Add a newline at the end, but "delete" the ", " and the end of the last string
print " \n" if $input; # No need to print "\n" if $input is 0

# we recursively create all possible binary numbers. Once hitting a leaf, we
# print the current number and return to the caller
# This way, we go recursively to a depth that's one more than the length we
# provide as input (remaining length of 0 is used to indicate we reached a leaf)
sub print_binaries {
    my $current_string = shift;
    my $remaining_digits = shift;
    unless ($remaining_digits) {
        # $remaining_digits is 0, so we can print what we have
        # in $current_string and return.
        # In case we're longer than $MAX_WIDTH, we print a "\n"
        # first and then reset $LENGTH
        $LENGTH += length("$current_string, ");
        if ($LENGTH > $MAX_WIDTH) {
            print "\n";
            $LENGTH = length("$current_string, ");
        }
        print "$current_string, ";
        return;
    }
    # We still have some remaining digits to go, so
    # recursively walk down for each possible digit
    foreach my $digit ( 0..1 ) {
        print_binaries("$current_string$digit", $remaining_digits-1);
    }
}
