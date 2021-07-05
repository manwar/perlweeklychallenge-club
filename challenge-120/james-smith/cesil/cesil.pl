#!/bin/perl
use strict;use warnings;my($M,$p,$r,@i,%m,@c,%q)=(1e6,0,0);
my@t=('PROGRAM REQUIRES MORE DATA','UNKNOWN VARIABLE ',
'DIVISION BY ZERO ','UNKNOWN LABEL ');
sub _e{die sprintf "\n*** %s%s *** %s \@ %d\n",$t[$_[0]],@{$c[$p]}[1,0],1+$p}
sub _j{exists$q{$_}?($p=$q{$_}-1):_e 3}
sub _v{/^[+-]?\d+$/?$_:exists$m{$_}?$m{$_}:_e 1}
my%c=('LINE',sub{print"\n"},'OUT',sub{print$r},'STORE',sub{$m{$_}=$r},
'PRINT',sub{print s/^"//r=~s/"$//r},'IN',sub{@i?($r=shift@i):_e 0},
'JINEG',sub{_j if$r<0},'SUBTRACT',sub{$r-=_v},'MULTIPLY',sub{$r*=_v},
'ADD',sub{$r+=_v},'DIVIDE',sub{$_=_v;$r=$_?int($r/$_):_e 2},
'LOAD',sub{$r=_v},'JIZERO',sub{_j if!$r},'JUMP',sub{_j},'HALT',sub{exit});
while(<>){next if/^ *\(/;((@i=map{/^\s+-?\d+\s*$/?0+$_:()}<>),last)if/^ *%/;
($q{$1},$_)=(0+@c,$2)if/^(\S{1,6})\s+(.*)/;
my($x,$y)=split/\s+/,s/^\s+//r=~s/\s+$//r,2;
die"\n# Unk cmd [$x \@ ",1+@c,"]\n"if!exists$c{$x};push@c,[$x,$y//''];}
($c{$c[$p][0]}($_=$c[$p][1]),$p++)while--$M&&$p<@c;
die"\n*** No HALT ***\n"
