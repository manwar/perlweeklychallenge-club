#!/usr/bin/env perl
use strict;
use warnings;
use Test::More tests => 5;

sub rational_numbers{
  my ($rat1,$rat2) = @_;
  my @rats;
  foreach my $r($rat1,$rat2) {
    $r .= '.' if -1 == index $r,'.';
    $r =~ /([-+]?\d+)\.(\d*)(?:\((\d+)\))?$/;
    my ($int,$prefix,$repeated) = @{^CAPTURE};
    $repeated //= '';
    $repeated = $1 if $repeated =~ /^(.+?)\1+$/;
    while(length $repeated &&
	  substr($repeated,-1,1) eq substr $prefix,-1,1) {
      substr $repeated,0,0,substr $prefix,-1,1,'';
      substr $repeated,-1,1,'';
      if('9' eq $repeated) {
	$repeated = '';
	if(length $prefix) {
	  if($prefix =~ /9$/) {
	    $prefix =~ s/9+$//;
	    if(length $prefix) {
	      ++$prefix
	    } else {
	      ++$int
	    }
	  } else {
	    ++$prefix
	  }
	} else {
	  ++$int
	}
	last
      }
    }
    $repeated = '' if '0' eq $repeated;
    $prefix = '' if '' eq $repeated && '0' eq $prefix;
    push @rats,"$int|$prefix|$repeated"
  }
  return $rats[0] eq $rats[1]
}

is rational_numbers('0.(12)','0.(121)'),'','Example 1';
is rational_numbers('0.1(23)','0.12(32)'),1, 'Example 2';
is rational_numbers('0.1(234)','0.12(342)'),1,'Example 3';
is rational_numbers('12.99(99)','13.'),1,'Example 4';
is rational_numbers('0.(123)','0.1(231)'),1,'Example 5';

done_testing();

