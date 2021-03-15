#!/usr/bin/perl

# Challenge 098
#
# TASK #1 › Read N-characters
# Submitted by: Mohammad S Anwar
# You are given file $FILE.
#
# Create subroutine readN($FILE, $number) returns the first n-characters and
# moves the pointer to the (n+1)th character.
#
# Example:
# Input: Suppose the file (input.txt) contains "1234567890"
# Output:
#     print readN("input.txt", 4); # returns "1234"
#     print readN("input.txt", 4); # returns "5678"
#     print readN("input.txt", 4); # returns "90"

use strict;
use warnings;
use 5.030;

sub readN {
    my($file, $length) = @_;
    state %open_files;
    if (!$open_files{$file}) {
        open($open_files{$file}, "<", $file) or die "Open $file: $!\n";
    }
    read($open_files{$file}, my $data, $length);
    return $data;
}

# main
while (my($file, $length) = splice(@ARGV, 0, 2)) {
    say readN($file, $length);
}
