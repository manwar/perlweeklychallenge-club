#! /usr/bin/env raku

subset PositiveInt of Int where * >= 1;

unit sub MAIN (PositiveInt $n, :v(:$verbose));

my $fibonacci := (1, 2, * + * ... *);

my @fibonacci;

for @$fibonacci -> $fib
{
  last if $fib > $n;
  @fibonacci.push: $fib;
}

say ": Fibonacci(<= $n): ", @fibonacci.join(", ") if $verbose;

my $count = 0;

for @fibonacci.combinations(1 .. *) -> @perm
{
  my $sum = @perm.sum;
  
  say ": Candidate: { @perm.join(" + ") } = $sum { $sum == $n ?? "match" !! "" }" if $verbose;
  
  $count++ if $sum == $n;
}

say $count;
