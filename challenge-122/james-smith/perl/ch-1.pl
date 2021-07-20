#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say state);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

stream( map {$_*10} 1..50 );           ## Push values into stream...
eval {say stream_average();} until $@; ## Use eval/$@ to repeat until stream dies.

sub stream {
  state(@stream);
     @_      ? (push @stream,@_)       ## Parameters passed - push to stream
   : @stream ? shift @stream           ## We have entry in stream return it
   :           die;                    ## exhausted stream die....
}

sub stream_average {
  ## Use state variables for the total & count;
  state($n,$t);

  ## Take next element and add to total
  ## Increment the count, and return the ratio of the true values
  ## Note we need to do pre-increment rather than
  ## post increment so the incremement is done before use.

  return ($t+=stream)/++$n;
}
