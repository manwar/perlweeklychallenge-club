#!/usr/bin/perl

use strict;
use warnings;
use autodie;

seek DATA, 0, 0;
while (<DATA>) {
    print;
}

__END__
trailing garbage
