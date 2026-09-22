#!/usr/bin/env perl
use strict;
use warnings;
use Test::More tests => 5;

sub convert_palindrome{
  my $r = reverse $_[0];
  my $n = length $_[0];
  foreach my $i(0..$n) {
    if(substr($_[0],0,$n-$i) eq substr($r,$i)) {
      return substr($r,0,$i) . $_[0]
    }
  }
}

is convert_palindrome('pinnipeds'),'sdepinnipeds','example 1';
is convert_palindrome('abcd'),'dcbabcd','example 2';
is convert_palindrome('bananas'),'sananabananas','example 3';
is convert_palindrome('dissident'),'tnedissident','example 4';
is convert_palindrome('cailliachs'),'shcailliachs','example 5';

done_testing();

