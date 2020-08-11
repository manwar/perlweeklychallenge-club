#!/usr/bin/perl
# Perl Weekly Challenge #072 Task 2
# Lines Range
# Usage: ch-2.pl $file $A $B
use strict;
use warnings;

my ($file, $A, $B);

if ($ARGV[0] && $ARGV[1] && $ARGV[2]) {
    $file = shift @ARGV;
    ($A,$B) = @ARGV;
} 
else {
    $file = "text";
    $A = 4;
    $B = 12;
}

open TEXT, $file or die "No files named $file";

my $eye = 1;

if ($A > 1) {
    while (<TEXT>) {
        chomp $_;
        $eye++;
        last if $eye >= $A;
    }
}

while (<TEXT>) {
    chomp $_;
    print $_;
    print "\n";
    $eye++;
    last if $eye > $B;
}

close TEXT;



