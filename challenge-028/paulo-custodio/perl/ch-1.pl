#!/usr/bin/perl

# Challenge 028

# Task #1
# Write a script to check the file content without explicitly reading the
# content. It should accept file name with path as command line argument and
# print "The file content is binary." or else "The file content is ascii."
# accordingly.

use Modern::Perl;

my $file = shift or die "Usage: $0 file\n";
if (-T $file) {
    say "The file content is ascii.";
}
else {
    say "The file content is binary.";
}
