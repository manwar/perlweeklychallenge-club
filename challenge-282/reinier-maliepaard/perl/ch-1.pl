#!/usr/bin/perl
use strict;
use warnings;

sub good_integer {
    # Return -1 for invalid, i.e. too short strings
    return(-1) unless length($_[0]) >= 3;

    my @chars = split(//, $_[0]);
    my @results = ();
    # Initialize with the first character
    my $current_char = $chars[0];
    # Start counting
    my $count = 1;

    for my $i (1 .. $#chars) {

        my $char = $chars[$i];

        if ($char eq $current_char) {
            $count++;
            # Check if we have exactly three consecutive, identical characters
            # i.e. the following fourth character '$chars[$i+1]' should be different
            # if there is one...
            if ($count == 3) {
               if (defined($chars[$i+1]) && ($char != $chars[$i+1]) ) {
                push( @results, ($current_char x $count) );
               }
               else {
                  # ...in case we're at the end of the string
                  push( @results, ($current_char x $count) ) if (!defined($chars[$i+1]));
               }
            }
        }
        else {
            # Character changed, update the tracking character
            $current_char = $char;
            # Reset count for new character
            $count = 1;
        }
    }

    (@results) ? return("@results") : return(-1);
}

# Tests

my $int;

# Example 1
$int = 12344456;
print(good_integer($int), "\n"); # Output: 444

# Example 2
$int = 1233334;
print(good_integer($int), "\n"); # Output: -1

# Example 3
$int = 10020003;
print(good_integer($int), "\n"); # Output: 000

# Example 4
$int = 9999123;
print(good_integer($int), "\n"); # Output: -1

# Example 5
$int = 123999;
print(good_integer($int), "\n"); # Output: 999

# Example 6
$int = 1239999;
print(good_integer($int), "\n"); # Output: -1

# Example 7
$int = 1234445678999;
print(good_integer($int), "\n"); # Output: 444 999

# Example 8
$int = 111234445678999;
print(good_integer($int), "\n"); # Output: 111 444 999
