#!/usr/bin/perl

use v5.16;
use warnings;

die <<EOS unless @ARGV;
usage: $0 [--] [FILE...]

FILE...
    names of files to process.  Use '-' for STDIN

EOS



main: {
    my %count;
    while (<>) {
        my $lc = lc =~ tr/[a-z]//cdr;
        $count{$_}++ for split //, $lc;
    }
    say "$_: $count{$_}" for sort keys %count;
}
