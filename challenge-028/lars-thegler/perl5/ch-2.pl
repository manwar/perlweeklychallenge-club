#!/usr/bin/env perl

# Write a script to display Digital Clock. Feel free to be as creative as you
# can when displaying digits. We expect bare minimum something like “14:10:11”.

use Modern::Perl;
use Time::Piece;

$|++;

while (1) {
    print "\r",localtime->datetime;
    sleep 1;
}