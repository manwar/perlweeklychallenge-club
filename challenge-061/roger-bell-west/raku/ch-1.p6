#! /usr/bin/perl6

my @list=@*ARGS;
unless (@list) {
  @list=(2,5,-1,3);
}

my ($mxp,$a,$b);

for (0..@list.end) -> $ai {
  for ($ai..@list.end) -> $bi {
    my $p=1;
    map {$p*=$_}, @list[$ai..$bi];
    if (!$mxp.defined || $p > $mxp) {
      ($mxp,$a,$b)=($p,$ai,$bi);
    }
  }
}

say join(' * ',@list[$a..$b]),' = ',$mxp;
