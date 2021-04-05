#! /usr/bin/perl

use strict;
use warnings;

use List::Util;

no strict 'refs';
foreach my $cm (sort keys %List::Util::) {
  if (exists &{"List::Util::$cm"}) {
    print "$cm\n";
  }
}

