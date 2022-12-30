#!/usr/local/bin/perl

use strict;
use warnings;
use feature qw(say);
use Test::More;

my @TESTS = (
  [ [],                  1        ],
  [ [1,1,2,2],           1        ],
  [ [1,1,2,2,2,3],       'Middle' ],
  [ [1,1,1,2,2,3],       1        ],
  [ [1,1,1,2,2,2],       1        ],
  [ [1,2,2,3,3,3],       1        ],
  [ [1,1,2,2,3,3,3],     1        ],
  [ [1,1,2],             1        ],
  [ [2,1,2],             'Top'    ],
  [ [1,1,1,2],           'Bottom' ],
  [ [1,1,1,1,2,2,2],     1        ],
  [ [1,1,1,2,2,2,2],     'Top'    ],
  [ [1,1,2,2,2,2,3],     'Middle' ],
  [ [1,1,2,2,2,2,2,3,3], 'Middle' ],
  [ [1,2,2,2,2,3,3],     'Middle' ],
  [ [2,2,2,2,3,3,3],     1        ],
  [ [2,2,2,3,3,3,3],     'Top'    ],
  [ [1,1,2,2,2,2],       'Top'    ],
  [ [1,2,2,2,2,3],       'Middle' ],
  [ [2,2,2,2,3,3],       'Bottom' ],
  [ [1,2,1,3,1,5],       1        ],
  [ [1,2,1,3,1],         1        ],
  [ [1,2],               1        ],
  [ [2,1],               1        ],
  [ [1],                 1        ],
  [ [1,5,1,1,6,4],       1        ],
  [ [1,3,2,2,3,1],       1        ],
  [ [1,3,2,2,2,3,1],     1        ],
  [ [2,3,1,3,1,2,1],     1        ],
);


is( ch_strict( ws_strict( @{$_->[0]} ) ), $_->[1] ) for @TESTS;
is( ch_lax(    ws_lax(    @{$_->[0]} ) ), 1       ) for @TESTS;
done_testing();

sub _ws {
## Does wiggle sort by splicing and interleaving sorted list...
  my@q=splice @_,(@_+1)/2;map{$_,@q?shift@q:()}@_
  my@q=splice @_,0,$#_/2+1;map{$_,@_?shift:()}@q
}
sub ws_lax {
## Return "wiggle sorted list" - note we are using the lax <= => check here
  @_<2?@_:_ws(sort{$a<=>$b}@_)
}

sub ws_strict {
## Return "wiggle sorted list" or error message indicating if
## the problem number is the first number, last number or one
## of the other numbers...

  return @_ if @_<2;
  @_=sort{$a<=>$b} @_;
  return $_[0]  == $_[$#_/2+1] ?                 'Bottom' # We can't have more than ceil(n/2) of the first number
       : $_[0]  == $_[$#_/2  ] ?                 _ws(@_)  # But we can have ceil(n/2) of the first number
       : $_[-1] == $_[$#_/2  ] ?                 'Top'    # We can't have more than floor(n/2) of the last number
       : $_[-1] == $_[$#_/2+1] ?                 _ws(@_)  # But we can have floor(n/2) of it
       : (grep{$_[$_]==$_[$_+$#_/2]}0..@_/2-1) ? 'Middle' # We can't have equal or more than floor(n/2) of any other number
       :                                         _ws(@_)
       ;
}

sub ch_strict {
  return 1 unless @_;              ## Empty array OK!
  return $_[0] if $_[0]=~m/\D/;    ## String - i.e. error - just return
  my($t,$d) = (shift,1);           ## Now checking list...
  ($_<=>$t) != $d ? return 0:($t=$_,$d*=-1) for @_;
  1
}

sub ch_lax {
  return 0 unless @_;
  my($t,$d)=(shift,1);             ## Check list...
  ($d?($t>$_):($t<$_))?return 0:($t=$_,$d=1-$d) for @_;
  1
}


