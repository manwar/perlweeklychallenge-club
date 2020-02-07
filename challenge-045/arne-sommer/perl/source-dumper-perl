#! /usr/bin/env perl

use strict;
use warnings;

my $file = $0;

if (open(my $fh, $file))
{
  while (my $row = <$fh>)
  {
    print $row;
  }
  close $fh;
}
