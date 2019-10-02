#! /usr/bin/perl

use strict;
use warnings;

foreach (@ARGV) {
  my $line='';
  if (scalar @ARGV > 1) {
    $line="$_: ";
  }
  $line .= 'The file content is ';
  if (-T $_) {
    $line.='ascii/utf8';
  } else {
    $line.='binary';
  }
  $line.=".\n";
  print $line;
}
