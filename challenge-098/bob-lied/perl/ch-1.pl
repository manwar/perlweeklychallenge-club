#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-1.pl
#=============================================================================
# Copyright (c) 2021, Bob Lied
#=============================================================================
# Perl Weekly Challenge 098 Challenge 1
# You are given file $FILE.
# Create subroutine readN($FILE, $number) returns the first n-characters and
# moves the pointer to the (n+1)th character.
# Example:
# Input: Suppose the file (input.txt) contains "1234567890"
# Output:
#    print readN("input.txt", 4); # returns "1234"
#    print readN("input.txt", 4); # returns "5678"
#    print readN("input.txt", 4); # returns "90"
#=============================================================================

use strict;
use warnings;
use v5.20;

use experimental qw/signatures /;

sub Usage { "Usage: $0 filename N" };

my $FILE = shift;
my $N        = shift;

die Usage() unless $FILE;
die Usage() unless $N;
die "Need positive N" if ( $N <= 0 );

# Cache open file handles per file.  The file handle will
# keep track of the position in the file, advancing each time
# that we call read().
my %fileToFH;

sub readN($s, $n)
{
    my $fh;
    if ( exists $fileToFH{$s} )
    {
        $fh = $fileToFH{$s};
    }
    elsif ( open($fh, "<:utf8", $s) )
    {
        $fileToFH{$s} = $fh;
    }
    else
    {
        die "Invalid filename $s ($!)";
    }
    my $howmany = read($fh, my $bytes, $n);
    return $bytes;
}
binmode(STDOUT, "utf8");
say readN($FILE, $N);
say readN($FILE, $N);
say readN($FILE, $N);
