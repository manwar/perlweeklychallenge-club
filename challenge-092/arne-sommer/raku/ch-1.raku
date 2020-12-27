#! /usr/bin/env raku

unit sub MAIN (Str $A, Str $B, :v($verbose));

my @A2B = (roundrobin($A.comb, $B.comb));

say ": Array: { @A2B.raku }" if $verbose;

my %A;

for @A2B -> @pair
{
  unless @pair[1].defined
  {
     say ": Different length" if $verbose;
     say 0;
     exit;
  }

  say ": Pair: @pair[0] -> @pair[1]" if $verbose;

  if %A{@pair[0]}.defined
  {
    if %A{@pair[0]} eq @pair[1]
    {
      say ": Duplicate of @pair[0] (value: @pair[1])";
      next;
    }
    
    say ": Redeclaration of @pair[0] (values: %A{@pair[0]} and @pair[1])";
    say 0;
    exit;
  }
  %A{@pair[0]} = @pair[1];
}

if %A.keys.elems == %A.values.unique.elems
{
  say 1;
}
else
{
  say ': Redeclaration of value (in $B).';
  say 0;
}
