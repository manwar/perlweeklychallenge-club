#!/usr/bin/perl

use strict;
use warnings;
use Time::Piece;

STDOUT->autoflush(1);

while (1) {
  print localtime->strftime('%H:%M:%S');
  sleep 1;
  print "\b\b\b\b\b\b\b\b";
}  
