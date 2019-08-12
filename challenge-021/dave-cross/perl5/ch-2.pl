#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';

use URI;

if (!@ARGV) {
  @ARGV = <DATA>;
  chomp(@ARGV);
}

for (@ARGV) {
  say URI->new($_)->canonical;
}

__DATA__
HTTP://www.Example.com/
http://www.example.com/a%c2%b1b
http://www.example.com/%7Eusername/
http://www.example.com:80/bar.html
