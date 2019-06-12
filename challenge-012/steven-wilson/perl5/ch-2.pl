#!/usr/bin/env perl
# Author: Steven Wilson
# Date: 2019-06-10
# Week: 012
# Challenge: #2
#
# Write a script that finds the common directory path, given a
# collection of paths and directory separator. For example, if the
# following paths are supplied.
#
# /a/b/c/d
# /a/b/cd
# /a/b/cc
# /a/b/c/d/e
#
# and the path separator is /. Your script should return /a/b as common
# directory path.

use strict;
use warnings;
use feature qw / say /;

my @paths = qw# /a/b/c/d /a/b/cd /a/b/cc /a/b/c/d/e #;
my @path_dirs;
my $common_path;

for (@paths) {
    my @dirs = split m#/#, $_;
    push @path_dirs, \@dirs;
}

my $common_length = @{ $path_dirs[0] };

for ( 1 .. ( scalar @path_dirs - 1 ) ) {
    my $count            = 0;
    my $difference_found = 0;
    my $compare_length = @{ $path_dirs[$_]};
    while ( !$difference_found ) {
        if ( $count < $common_length
            && $count < $compare_length
            && @{ $path_dirs[0] }[$count] eq @{ $path_dirs[$_] }[$count])
        {
            $count++;
        }
        else {
            $difference_found = 1;
        }
    }
    if ( $count < $common_length ) {
        $common_length = $count;
    }
}

$common_path = join "/", splice( @{ $path_dirs[0] }, 0, $common_length );

say "The common directory path is $common_path.";
