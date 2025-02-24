
sub co { #check order
    my @s = sort { $a <=> $b } @_;
    grep $_[$_] != $s[$_], 0 .. $#_
}


use Test::More tests => 2;
is_deeply [co( @{ $$_{input} } )], $$_{output} for
  {input=>[5, 2, 4, 3, 1],output=>[0, 2, 3, 4]},
  {input=>[1, 2, 1, 1, 3],output=>[1, 3]};
