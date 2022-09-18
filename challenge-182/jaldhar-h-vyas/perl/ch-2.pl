#!/usr/bin/perl
use 5.030;
use warnings;
use English;

sub usage() {
print <<"-USAGE-";
Usage:
  $PROGRAM_NAME [<args> ...]

    [<args> ...]    File paths.
-USAGE-
    exit 0;
}

scalar @ARGV || usage();

if (scalar grep { !/^\// } @ARGV) {
   usage();
}

my @paths = map { [ split q{/} ] } reverse sort @ARGV;

my @commonDirectoryPath;
for my $segment (0 .. scalar @{$paths[0]} - 1) {
    my $dir = @{$paths[0]}[$segment];
    if (!scalar grep { !/$dir/ } map { @{$_}[$segment] } @paths) {
        push @commonDirectoryPath, $dir;
    } else {
        last;
    }
}

say scalar @commonDirectoryPath > 1 ? join q{/}, @commonDirectoryPath : q{/};