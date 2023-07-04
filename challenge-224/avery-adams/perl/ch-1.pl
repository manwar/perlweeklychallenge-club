#!/usr/bin/perl

use strict;
use v5.24;

my ($source, $target) = @ARGV;
my %chars;

foreach (split //, $source) {$chars{$_}++}

foreach (split //, $target) {
    if ($chars{$_}) {
        $chars{$_}--;
    } else {
        say 'false' and exit;
    }
}
say 'true';
