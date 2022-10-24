#! /usr/bin/env raku

unit sub MAIN (*@n where @n.elems >= 3, :v(:$verbose));

my $max = @n.combinations(3)>>.sum.max;

say ":Max: $max" if $verbose;

# my @candidates = @n.combinations(3)>>.permutations[*;*].unique(:with(&[eqv]));
my @candidates = @n>>.Int.combinations(3)>>.permutations[*;*].unique(:with(&[eqv]));

say ":Permutations: { @candidates.raku }" if $verbose;

my @ok = @candidates.grep( { $_[0] + $_[1] > $_[2] &&
                             $_[1] + $_[2] > $_[0] &&
	                     $_[0] + $_[2] > $_[1] &&
	  		     $_.sum == $max });

say ":Rule 1-4 applied: { @ok.raku }" if $verbose;

if @ok.elems == 0
{
  say "()";
}
elsif @ok.elems == 1
{
  say  "(", @ok[0].join(", "), ")";
}
else
{
  say "(", @ok.grep( { $_[0] >= $_[1] >= $_[2] })[0].join(", "), ")";
}
