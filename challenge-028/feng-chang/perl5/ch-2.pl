#!/bin/env perl

use Modern::Perl;
use Date::Manip;

use sigtrap 'handler' => \&quit_handler, 'INT';

BEGIN { $| = 1 }

while (1) {
    print "\r", UnixDate(ParseDate('now'), '%H:%M:%S');
}

sub quit_handler {
    say "\r", UnixDate(ParseDate('now'), '%H:%M:%S'), '  ';
    exit 0;
}
