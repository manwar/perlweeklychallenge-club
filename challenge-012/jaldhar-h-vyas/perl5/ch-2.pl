#!/usr/bin/perl
use warnings;
use strict;
use 5.010;

sub usage() {
print <<"-USAGE-";
Usage:
  $0 [<args> ...]

    [<args> ...]    File paths.
-USAGE-
    exit 0;
}

# There must be atleast one argument and ach argument must start with a / to be
# a valid file path.
scalar @ARGV || usage();

if (scalar grep { !/^\// } @ARGV) {
   usage();
}

# Sort the arguments so the shortest is first because the common directory path
# cannot be longer than the shortest path.  Split each path into an array
# of path segments and put those arrays in @path. 
my @paths = map { [ split q{/} ] } reverse sort @ARGV;

# Compare the same segment of each path.  If they are all the same, the
# segment is part of the common directory path.  If it isn't, we can stop.
my @commonDirectoryPath;
for my $segment (0 .. scalar @{$paths[0]} - 1) {
    my $dir = @{$paths[0]}[$segment];
    if (!scalar grep { !/$dir/ } map { @{$_}[$segment] } @paths) {
        push @commonDirectoryPath, $dir;
    } else {
        last;
    }
}

# Print the common directory path with the directory separator re-added.  if
# there were no matches in the previous step, the common directory path is /.
say scalar @commonDirectoryPath > 1 ? join q{/}, @commonDirectoryPath : q{/};