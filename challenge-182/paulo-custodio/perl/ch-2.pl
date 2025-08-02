#!/usr/bin/env perl

# Challenge 182
#
# Task 2: Common Path
# Submitted by: Julien Fiegehenn
#
# Given a list of absolute Linux file paths, determine the deepest path to the
# directory that contains all of them.
# Example
#
# Input:
#     /a/b/c/1/x.pl
#     /a/b/c/d/e/2/x.pl
#     /a/b/c/d/3/x.pl
#     /a/b/c/4/x.pl
#     /a/b/c/d/5/x.pl
#
# Ouput:
#     /a/b/c

use Modern::Perl;

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
say common_prefix('/', @paths);
