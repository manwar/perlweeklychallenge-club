#! /usr/bin/perl6

use Test;

plan 5;

is(sc('abc','dea','cd'),1,'example 1');
is(sc('ade','cbd','fgh'),0,'example 2');
is(sc('abc','dea','fgh','hif'),0,'example 3');
is(sc('abc','dec','cfa','cgd'),1,'example 4');
is(sc('abc','def','cd'),0,'example 5');

sub sc(**@n) {
  my @m;
  my %i;
  for @n -> $t {
    push @m,substr($t,*-1,1);
    my $ss=substr($t,0,1);
    if %i{$ss}:exists {
      push @(%i{$ss}),@m.end;
    } else {
      %i{$ss}=[@m.end];
    }
  }
  my @chain=([0]);
  while (@chain) {
    my @stub=pop @chain;
    @stub=@stub».List.flat;
    my $v=SetHash.new(0..@n.end);
    map {$v{$_}:delete}, @stub;
    if ($v) {
      if (%i{@m[@stub[*-1]]}:exists) {
        my @x=grep {$v{$_}:exists}, @(%i{@m[@stub[*-1]]});
        for @x -> $x {
          my @s=@stub».List.flat;
          push @s,$x;
          push @chain,@s;
        }
      }
    } else {
      if (%i{@m[@stub[*-1]]}:exists && %i{@m[@stub[*-1]]}[0]==0) {
        return 1;
      }
    }
  }
  return 0;
}
