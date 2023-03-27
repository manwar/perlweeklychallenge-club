#!/usr/local/bin/perl

use strict;
use warnings;
use feature qw(say);
use Test::More;

my @TESTS = (
  [ [2,3,-1] => '2 3' ],
  [ [3,2,-4] => '-4' ],
  [ [1,-1]   => '' ],
);

sub collision {
  my @st;
    $_[0]>0 || !@st || $st[-1] < 0 ? ( push @st, shift )
                   ## +ve no, empty stack or last stack is -ve
                   ## we keep this at the moment so push to stack
  : $st[-1] == -$_[0]              ? ( pop @st, shift  )
                   ## -ve no and equal in absolute value
                   ## remove +ve value from stack and drop
                   ## current value
  : $st[-1] >= -$_[0]              ? ( shift           )
                   ## -ve no and smaller in abs value
                   ## drop current value
  :                                  ( pop @st         )
                   ## -ve no and greater in abs value
                   ## remove previous number from stack
    while @_;
  @st              ## return value
}

is( "@{[ collision( @{$_->[0]} ) ]}", $_->[1] ) for @TESTS;

## Without comments...

sub nc_collision {
  my @st;
    $_[0]>0 || !@st || $st[-1] < 0 ? push @st,   shift
  : $st[-1] == -$_[0]              ? pop  @st && shift
  : $st[-1] >= -$_[0]              ?             shift
  :                                  pop  @st
    while @_;
  @st
}
