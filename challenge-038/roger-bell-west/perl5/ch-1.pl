#! /usr/bin/perl

use strict;
use warnings;

use Time::Local;
use POSIX qw(strftime);

foreach my $dc (@ARGV) {
  unless (length($dc)==7) {
    warn "$dc is wrong length\n";
    next;
  }
  unless ($dc =~ /^[0-9]+$/) {
    warn "$dc has non-digit characters\n";
    next;
  }
  $dc =~ /^(.)(..)(..)(..)$/;
  my ($cen,$year,$month,$day)=($1,$2,$3,$4);
  if ($cen==2) {
    $year+=1900;
  } elsif ($cen==1) {
    $year+=2000;
  } else {
    warn "$dc has invalid century digit $cen\n";
    next;
  }
  if ($month<1 || $month>12) {
    warn "$dc has invalid month $month\n";
    next;
  }
  my $d;
  eval {
    $d=timelocal(0,0,12,$day,$month-1,$year);
  };
  unless (defined $d) {
    warn "$dc has invalid day $day\n";
    next;
  }
  print strftime('%Y-%m-%d',localtime($d)),"\n";
}
