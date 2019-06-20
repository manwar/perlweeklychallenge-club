#!/usr/bin/perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-012/
# Challenge #2
# Write a script that finds the common directory path, given a collection of paths and directory separator.
# For example, if the following paths are supplied.
# /a/b/c/d
# /a/b/cd
# /a/b/cc
# /a/b/c/d/e
# and the path separator is /. Your script should return /a/b as common directory path.


use strict;
use warnings;

use constant SEPARATOR => '/';

my $usage = "Usage: $0 <absolute-path-with-".SEPARATOR."-as-separator>\n";

die $usage unless @ARGV > 0;
foreach (@ARGV) {
    die "'$_' is not an absolute path\n".$usage if(substr($_,0,1) ne SEPARATOR);
}

my @chosen = split SEPARATOR, shift @ARGV;
shift @chosen; #first element is empty

#Last common directory
my $lcd = @chosen;

#Compare each given absolute path with the first one
PATH: foreach my $path (@ARGV) {
    my @dirs = split SEPARATOR, $path;
    shift @dirs; #first element is empty

    my $matches = 0;
    my $upto = ($lcd <= @dirs) ? $lcd : @dirs;
    --$upto; #last directory index to compare

    #Compare directories between this path and the chosen one
    for my $index (0 .. $upto){
        last if ($dirs[$index] ne $chosen[$index]);
        $matches++;
    }

    $lcd = $matches if ($matches < $lcd);
    last PATH if ($lcd == 0); #avoid checking others
}

splice(@chosen,$lcd);
print 'Common directory path: /'.join(SEPARATOR, @chosen );