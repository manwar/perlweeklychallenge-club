use strict;
use warnings;

$| = 1;
my( $ptr, $reg, @in, %mem, @code, %ptrs ) = 0;

my %messages = (
  'i' => 'No further input',
  'm' => 'Unitialized memory at ',
  'l' => 'Unknown pointer ',
);

my %commands = (
'LINE'    ,sub{print "\n"},
'OUT'     ,sub{print $reg},
'PRINT'   ,sub{print $_[0]=~s{^"}{}r=~s{"$}{}r},
'IN'      ,sub{_err('i') unless @in;$reg=shift@in},
'STORE'   ,sub{$mem{$_[0]}=$reg},
'LOAD'    ,sub{_err('m') unless exists$mem{$_[0]};$reg=$mem{$_[0]}},
'ADD'     ,sub{$reg+=$_[0]=~m{^-?\d+$}?$_[0]:exists$mem{$_[0]}?$mem{$_[0]}:(_err('m'))},
'SUBTRACT',sub{$reg-=$_[0]=~m{^-?\d+$}?$_[0]:exists$mem{$_[0]}?$mem{$_[0]}:(_err('m'))},
'MULTIPLY',sub{$reg*=$_[0]=~m{^-?\d+$}?$_[0]:exists$mem{$_[0]}?$mem{$_[0]}:(_err('m'))},
'DIVIDE'  ,sub{$reg/=$_[0]=~m{^-?\d+$}?$_[0]:exists$mem{$_[0]}?$mem{$_[0]}:(_err('m'));$reg=int$reg},
'JINEG'   ,sub{_err('l') unless exists $ptrs{$_[0]}; $ptr=$ptrs{$_[0]}-1 if $reg<0},
'JIZERO'  ,sub{_err('l') unless exists $ptrs{$_[0]}; $ptr=$ptrs{$_[0]}-1 if $reg==0},
'JUMP'    ,sub{_err('l') unless exists $ptrs{$_[0]}; $ptr=$ptrs{$_[0]}-1},
'HALT'    ,sub{exit},
);

while(<>) {
  ((@in = map { 0+$_ } <> ),last) if m{^ {8}%};
  ($ptrs{$1},$_)=(scalar @code,$2) if m{^(\S{1,7})\s+(.*)};
  my($cmd,$data) = split m{\s+}, s{^\s+}{}r=~s{\s+$}{}r, 2;
  die "Unknown command [cmd $cmd - line ",1+@code,"]\n" unless exists $commands{$cmd};
  push @code, [$cmd,$data||''];
}

my $MAX_LOOPS = 1e6;
($commands{$code[$ptr][0]}($code[$ptr][1]),$ptr++)
  while --$MAX_LOOPS && $ptr<@code;

sub _err {
  my $flag = shift;
  die sprintf "\n%s%s [cmd %s - line %d]\n", $messages{$flag}, $code[$ptr][1], $code[$ptr][0], 1+$ptr;
}
