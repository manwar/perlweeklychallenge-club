#!/usr/bin/perl

use strict;
use v5.10;

my @list;

foreach (@ARGV) {
    if ($_ =~ /^[qwertyuiopQWERTYUIOP]*$/) {push @list, $_};
    if ($_ =~ /^[asdfghjklASDFGHJKL]*$/) {push @list, $_};
    if ($_ =~ /^[zxcvbnmZXCVBNM]*$/) {push @list, $_};
}
if (scalar @list) {
    foreach (@list) {
        say $_;
    }
} else {
    say "I didn't find anything on one row of keys."
}
