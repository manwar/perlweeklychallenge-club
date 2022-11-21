#! /usr/bin/env raku

unit sub MAIN (UInt $n where 0 < $n <= 15, :v(:$verbose));

my @list = (1 .. $n);

say ":List: [{ @list.join(",") }]" if $verbose;

my @permutations = @list.permutations;

say ":Permutations: ", @permutations if $verbose;

my $cute;

for @permutations -> @permutation
{
  $cute++ if is-cute(@permutation);
}

say $cute;

sub is-cute (@list)
{
  for 1 .. @list.elems -> $i
  {
    return 0 unless @list[$i -1] %% $i || $i %% @list[$i -1];
  }

  return 1;
}