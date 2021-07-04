use strict;
use warnings;

# Set auto-flush...
$| = 1;
## Initialize state
my($MAX_LOOPS, $ptr, $reg, @in, %mem, @code, %ptrs) = (1e6,0,0);

## Define error messages
my %messages = (
  'i' => 'No further input',
  'd' => 'Division by zero ',
  'm' => 'Unitialized memory at ',
  'l' => 'Unknown pointer ',
);

## Support functions
sub _err { die sprintf "\n** %s%s [cmd %s - line %d]\n",
  $messages{$_[0]}, $code[$ptr][1], $code[$ptr][0], 1+$ptr; }
sub _j { exists$ptrs{$_}?($ptr=$ptrs{$_}-1):_err 'l'; }
sub _v { /^-?\d+$/?$_:exists$mem{$_}?$mem{$_}:_err 'm'; }

## Command dispatch table
my %commands = (
'LINE'    ,sub{print "\n"},
'OUT'     ,sub{print $reg},
'PRINT'   ,sub{print s/^"//r=~s/"$//r},
'IN'      ,sub{@in?($reg=shift@in):_err 'i'},
'STORE'   ,sub{$mem{$_}=$reg},
'LOAD'    ,sub{$reg=_v},
'ADD'     ,sub{$reg+=_v},
'SUBTRACT',sub{$reg-=_v},
'MULTIPLY',sub{$reg*=_v},
'DIVIDE'  ,sub{$_=_v;$reg=$_?int($reg/$_):_err 'd'},
'JINEG'   ,sub{_j if $reg<0},
'JIZERO'  ,sub{_j if !$reg},
'JUMP'    ,sub{_j},
'HALT'    ,sub{exit},
);

## Parser loop
while(<>) {
  ((@in = map {/^\s+-?\d+\s*$/?0+$_:()} <> ),last) if m{^ {8}%};
  ($ptrs{$1},$_)=(scalar @code,$2) if m{^(\S{1,7})\s+(.*)};
  my($cmd,$data) = split m{\s+}, s{^\s+}{}r=~s{\s+$}{}r, 2;
  die "\n** Unknown command [cmd $cmd - line ",1+@code,"]\n"
    unless exists $commands{$cmd};
  push @code, [$cmd,$data||''];
}

## Execution loop
($commands{$code[$ptr][0]}($_=$code[$ptr][1]),$ptr++)
  while --$MAX_LOOPS && $ptr<@code;
die "\n** Exited without HALT\n" if $ptr >= @code;
