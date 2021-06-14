#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;

say missing( 'test.txt');

done_testing();

sub missing {
  ## We don't need to store all the values of $n. What
  ## we know is - that if all the rows were present the
  ## sum of the line numbers would be ($n+1)$n/2;
  ## So if we count the lines an sum the numbers we get
  ##
  ## Count lines = $n - 1;
  ## Sum lines   = $n * ($n+1)/2 - $missing_line_no
  ##
  ## Ignoring we know $n is 15 - we can just get $n
  ## as the count of the lines + 1
  ## and $s as the sum of the line numbers
  ##
  ## We then get the missing line number by re-arranging
  ## the formulae above to get
  ##
  ## $missing_line_no = $n*($n+1)/2 - $sum_lines
  ##
  my($n,$s) = (1,0);
  open my $fh, '<', shift;
  ++$n && ( $s += substr $_, 0, index $_, ',' ) while <$fh>;
  close $fh;
  return ( $n + 1 ) * $n / 2 - $s;
}

