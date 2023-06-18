#!/usr/bin/perl

use strict;
use v5.24;

my %chars;
$chars{$_}++ for (split(//, shift));

my $total;

foreach (@ARGV) {
    my @currWordChars = split(//, $_);
    my %list = %chars;
    my $notFound;

    for my $char (@currWordChars) {
        if ($list{$char}) {
            $list{$char}--;
        } else {
            $notFound = 1;
            last;
        }
    }
    $total += ($notFound ? 0 : @currWordChars);
}
say $total;
