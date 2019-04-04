use strict;
use v5.26;

sub r35 {$_[0]?r35(substr $_[0],0,-1)*35+z(substr $_[0],-1):0}
sub b35 {$_[0]?b35(int$_[0]/35).x($_[0]%35):''}
sub x   {chr$_[0]+($_[0]<10?48:55)}
sub z   {(ord$_[0])-($_[0]=~/\d/?48:55)}

say b35 $_     for @ARGV;
say r35 b35 $_ for @ARGV;

