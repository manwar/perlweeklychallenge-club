#!/usr/bin/perl
use warnings;
use v5.12;

# run <script> <path-to-file or nothing>
# defaults to text at the bottom if no file is entered

use feature qw(signatures);
no warnings qw(experimental::signatures);

use List::AllUtils qw(zip_by);

my $fh;
(scalar @ARGV) ? (open($fh, '<', $ARGV[0])) : ($fh = *DATA);

my @data = ();
while (<$fh>) {
    chomp;
    my @line = split(/,\s*/,$_);
    push @data, \@line;
}

my @transData = map {join(",",@{$_})} zip_by { [ @_ ] } @data;
for (@transData) {
    say;
}

__DATA__
name,age,sex
Mohammad,45,m
Joe,20,m
Julie,35,f
Cristina,10,f
