#!/usr/bin/perl

# You are given two strings, $source and $target.  Write a script to find out
# if using the characters (only once) from source, a target string can be
# created.

use 5.036;
use utf8;

sub is_special_note ($source, $target) {
    my %count_for;
    for my $char (split //, $source) {
        $count_for{$char}++;
    }
    for my $char (split //, $target) {
        return 0 if !exists $count_for{$char} || $count_for{$char}-- < 1;
    }
    return 1;
}

say is_special_note('abc',               'xyz');
say is_special_note('scriptinglanguage', 'perl');
say is_special_note('aabbcc',            'abc');
