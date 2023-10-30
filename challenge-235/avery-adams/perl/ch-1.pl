#!/usr/bin/perl
use v5.36;

my $success = 0;
REMOVAL: for my $removal (0 .. $#ARGV) {
    my @modified = @ARGV;
    splice(@modified, $removal, 1);
    for my $scan (1 .. $#modified) {
        if($modified[$scan] <= $modified[$scan - 1]) {
            next REMOVAL;
        }
    }
    $success = 1;
    last;
}

say ($success ? 'true' : 'false');
