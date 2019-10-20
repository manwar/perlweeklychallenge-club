#!/usr/bin/perl
use warnings;
use strict;
use 5.010;
use English qw/ -no_match_vars /;

$OUTPUT_AUTOFLUSH = 1;

while(1) {
    print "\b" x 8, sprintf("%02d:%02d:%02d", (localtime)[2,1,0]);
    select undef, undef, undef, 1;
}
