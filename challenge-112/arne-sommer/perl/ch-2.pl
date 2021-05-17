#! /usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use feature 'signatures';

no warnings "experimental::signatures";

my $n = $ARGV[0] // die "Please specify number of steps";

my $matches = 0;

climb(0);

sub climb ($sum)
{
  return if $sum > $n;
  if ($sum == $n)
  {
    $matches++;
    return;
  }

  climb($sum +1);
  climb($sum +2);
}

say $matches;

__END__
... 100
Deep recursion on subroutine "main::climb" at ./climb-stairs-perl line 26.
^C
arne@arne-ThinkPad-T490:~/Desktop/Timeliste/112 $ ./climb-stairs-perl 10
89
arne@arne-ThinkPad-T490:~/Desktop/Timeliste/112 $ ./climb-stairs-perl 15
987
arne@arne-ThinkPad-T490:~/Desktop/Timeliste/112 $ ./climb-stairs-perl 20
10946
arne@arne-ThinkPad-T490:~/Desktop/Timeliste/112 $ ./climb-stairs-perl 25
121393
arne@arne-ThinkPad-T490:~/Desktop/Timeliste/112 $ 

