#!/usr/bin/env perl

# Challenge 287
#
# Task 1: Strong Password
# Submitted by: Mohammad Sajid Anwar
#
# You are given a string, $str.
#
# Write a program to return the minimum number of steps required to make the
# given string very strong password. If it is already strong then return 0.
#
# Criteria:
#
# - It must have at least 6 characters.
# - It must contains at least one lowercase letter, at least one upper case
#   letter and at least one digit.
# - It shouldn't contain 3 repeating characters in a row.
#
# Following can be considered as one step:
#
# - Insert one character
# - Delete one character
# - Replace one character with another
#
# Example 1
#
# Input: $str = "a"
# Output: 5
#
# Example 2
#
# Input: $str = "aB2"
# Output: 3
#
# Example 3
#
# Input: $str = "PaaSW0rd"
# Output: 0
#
# Example 4
#
# Input: $str = "Paaasw0rd"
# Output: 1
#
# Example 5
#
# Input: $str = "aaaaa"
# Output: 2

use Modern::Perl;

say steps_to_strong(shift // "");

sub steps_to_strong {
    my($password) = @_;

    my $steps = 0;
    while (!is_strong($password)) {
        my $new_ch = next_char($password);

        if ($password =~ /(.)\1\1+/) {
            my $ch = $1;
            $password =~ s/$ch{3}/$ch$ch$new_ch$ch/;
        }
        else {
            $password .= $new_ch;
        }
        $steps++;
    }
    return $steps;
}

sub is_strong {
    local($_) = @_;
    return length($_)>=6 && /[a-z]/ && /[A-Z]/ && /[0-9]/ && !/(.)\1\1+/;
}

sub next_char {
    my($password) = @_;

    my $avail_chars = "";
    if ($password !~ /[0-9]/) {
        $avail_chars .= join "", '0'..'9';
    }
    if ($password !~ /[A-Z]/) {
        $avail_chars .= join "", 'A'..'Z';
    }
    if ($password !~ /[a-z]/) {
        $avail_chars .= join "", 'a'..'z';
    }
    $avail_chars .= join "", '0'..'9', 'A'..'Z', 'a'..'z';

    for my $ch (split //, $password) {
        $avail_chars =~ s/$ch//g;
    }

    return substr($avail_chars, 0, 1);
}
