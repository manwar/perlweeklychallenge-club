#!/usr/bin/perl

# Challenge 012
#
# Challenge #2
# Write a script that finds the common directory path, given a collection of
# paths and directory separator. For example, if the following paths are
# supplied.
# /a/b/c/d
# /a/b/cd
# /a/b/cc
# /a/b/c/d/e
# and the path separator is /. Your script should return /a/b as common
# directory path.

use strict;
use warnings;
use 5.030;

# extract a common prefix, if one exists
sub extract_common_prefix {
    my($paths) = @_;

    # check if all paths have the same prefix
    my $dir;
    for my $i (0 .. $#{$paths}) {
        return unless @{$paths->[$i]};              # path empty
        if ($i == 0) {
            $dir = $paths->[$i][0];                 # first path
        }
        else {
            return unless $dir eq $paths->[$i][0];  # not same prefix
        }
    }

    # all have $dir prefix, shift if out
    shift @$_ for (@$paths);

    return $dir;
}

sub common_prefix {
    my($sep, @paths) = @_;

    # split paths by separator
    @paths = map {$_ = [split($sep, $_)]} @paths;

    # find common prefix
    my @prefix;
    while (defined(my $dir = extract_common_prefix(\@paths))) {
        push @prefix, $dir;
    }

    return join($sep, @prefix);
}


my($sep, @paths) = @ARGV;
say common_prefix($sep, @paths);
