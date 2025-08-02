#! /usr/bin/env raku

subset PosInt of Int where * > 0;

unit sub MAIN (*@str where @str.elems > 1 && all(@str) ~~ /^<[01]>+$/,
               :a(:$all)            = 0,
               PosInt :o(:$ones)    = 0,
               PosInt :z(:$zeroes)  = 0,
               :v(:$verbose)        = $all);

my $output = 0;

for @str.combinations(1 .. *).reverse -> @combo
{
  my %freq = @combo.join.comb.Bag;
  %freq<0> //= 0;
  %freq<1> //= 0;

  if %freq<0> <= $zeroes && %freq<1> <= $ones
  {
    say ": + { @combo.join(",") } -> 0:%freq<0> 1:%freq<1> [{ @combo.elems }]" if $verbose;
    $output = @combo.elems unless $output;
    last unless $all;
  }
  elsif $verbose
  {
    say ": - { @combo.join(",") } -> 0:%freq<0> 1:%freq<1>";
  }
}

say $output;

