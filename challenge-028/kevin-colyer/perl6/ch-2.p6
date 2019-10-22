#!/usr/bin/perl6
use v6;

use Test;

# 28.2 Write a script to display Digital Clock. Feel free to be as creative as you can when displaying digits. We expect bare minimum something like “14:10:11”.

sub MAIN() {
    # bare minimum
    say DateTime.now.hh-mm-ss;
}
