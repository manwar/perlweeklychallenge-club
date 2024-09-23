#!/usr/bin/perl
use strict;
use warnings;
use List::Util 'max';

# Function to count groups of three or more repeating characters
sub count_repeats {
    my ($str) = @_;
    my $repeats = 0;

    # Find repeating characters and count the required changes
    while ($str =~ /(.)\1{2,}/g) {
        $repeats += int(length($&) / 3);
    }

    return $repeats;
}

# Function to calculate the minimum steps to create a strong password
sub minimum_steps_to_strong_password {
    my ($str) = @_;
    my $length = length($str);
    
    # Check if the password contains the required character types
    my $has_lower = $str =~ /[a-z]/;
    my $has_upper = $str =~ /[A-Z]/;
    my $has_digit = $str =~ /\d/;

    # Calculate the number of types needed
    my $types_needed = !$has_lower + !$has_upper + !$has_digit;
    my $repeats = count_repeats($str);

    # Return the minimum steps based on the length of the password
    return ($length < 6) ? max(6 - $length, $types_needed) : $types_needed + $repeats;
}

1;
