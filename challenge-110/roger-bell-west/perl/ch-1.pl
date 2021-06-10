#! /usr/bin/perl

use strict;
use warnings;

while (<>) {
  print if /^\s*(\+[0-9]{2}|\([0-9]{2}\)|[0-9]{4}) [0-9]{10}\s*$/;
}
