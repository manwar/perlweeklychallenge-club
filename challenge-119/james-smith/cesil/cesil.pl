use strict;
use warnings;

## Initialize state
my($MAX,$ptr,$reg,@in,%mem,@code,%ptrs)=(1e6,0,0);

## Define error messages
my %messages = (
'i','No further input','d','Division by zero ',
'l','Unknown pointer ','m','Unitialized memory at ');

## Support functions
sub _e { die sprintf "\n** %s%s [%s @ %d]\n",
  $messages{$_[0]},@{$code[$ptr]}[1,0],1+$ptr}
sub _j { exists$ptrs{$_}?($ptr=$ptrs{$_}-1):_e 'l'}
sub _v { /^-?\d+$/?$_:exists$mem{$_}?$mem{$_}:_e 'm'}

## Command dispatch table
my %commands = (
'LINE'    ,sub{print "\n"},
'OUT'     ,sub{print $reg},
'PRINT'   ,sub{print s/^"//r=~s/"$//r},
'IN'      ,sub{@in?($reg=shift@in):_e 'i'},
'STORE'   ,sub{$mem{$_}=$reg},
'LOAD'    ,sub{$reg=_v},
'ADD'     ,sub{$reg+=_v},
'SUBTRACT',sub{$reg-=_v},
'MULTIPLY',sub{$reg*=_v},
'DIVIDE'  ,sub{$_=_v;$reg=$_?int($reg/$_):_e 'd'},
'JINEG'   ,sub{_j if $reg<0},
'JIZERO'  ,sub{_j if !$reg},
'JUMP'    ,sub{_j},
'HALT'    ,sub{exit},
);

## Parser loop
while(<>) {
  ((@in=map{/^\s+-?\d+\s*$/?0+$_:()}<>),last)if/^ {8}%/;
  ($ptrs{$1},$_)=(0+@code,$2) if /^(\S{1,7})\s+(.*)/;
  my($cmd,$data) = split/\s+/,s/^\s+//r=~s/\s+$//r, 2;
  die "\n## Unknown command [$cmd @ ",1+@code,"]\n"
    unless exists $commands{$cmd};
  push @code, [$cmd,$data//''];
}
## Execution loop
($commands{$code[$ptr][0]}($_=$code[$ptr][1]),$ptr++)
  while--$MAX&& $ptr<@code;
die "\n** Exited without HALT\n";

