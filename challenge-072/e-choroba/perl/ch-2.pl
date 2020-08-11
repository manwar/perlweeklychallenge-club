#!/usr/bin/perl
use warnings;
use strict;

my ($from, $to) = (shift, shift);
while (<>) {
    print if ($. == $from) .. ($. == $to);
}

