#!/usr/bin/env perl

# Challenge 028, task #1:
# Write a script to check the file content without explicitly reading the content.
# It should accept file name with path as command line argument and print
# “The file content is binary.” or else “The file content is ascii.” accordingly.

use Modern::Perl;

my $filename = shift;

if ( -B $filename ) {
    say 'The file content is binary.';
} elsif ( -T $filename ) {
    say 'The file content is ascii.';
} else {
    say 'The file is something else.';
}

# The task is worded in an unfortunate way - there exists files that are neither
# binary nor ascii. My code handles that also.
