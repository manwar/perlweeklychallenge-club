#!/usr/bin/perl
use strict;
use warnings;
use feature qw/say/;


die "Please supply a file name as argument" unless @ARGV == 1;
my $file = shift;
die "File $file does not exist" unless -e $file;
die "File $file is empty" if -z _;
die "File $file isn't a plain file" unless -f _;
if (-B _) {
    say "$file is a binary file";
} elsif (-T _) {
    say "$file is a text file (ASCII or UTF8)";
} else {
    say "Could not determine file type"; # Probaby can't happen
}
