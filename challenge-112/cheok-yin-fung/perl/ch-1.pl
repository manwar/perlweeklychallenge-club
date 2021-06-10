#!/usr/bin/perl
# The Weekly Challenge 112
# Task 1 Canonical Path
use strict;
use warnings;

my $origin = $ARGV[0] || "/a//b/c/../../";

my @directories = grep { $_ ne "" && $_ ne "."  } split "/", $origin;

my @new_dirs = ();

for (@directories) {
    if ($_ ne "..") {
        push @new_dirs, $_;
    }
    else {
        pop @new_dirs;
    }
}

print ( "/" . (join "/", @new_dirs));
print "\n";
