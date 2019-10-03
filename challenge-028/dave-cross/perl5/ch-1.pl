#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';

use File::Basename;

@ARGV or die 'Usage: ', basename($0), " [list of filenames]\n";

for (@ARGV) {
  if (-T) {
    say "$_ looks like a text file";
  } elsif (-B) {
    say "$_ looks like a binary file";
  } else {
    say "$_ looks a bit weird";
  }
}
