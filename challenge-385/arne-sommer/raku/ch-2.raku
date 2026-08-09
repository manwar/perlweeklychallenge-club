#! /usr/bin/env raku

unit sub MAIN ($str where $str ~~ /^ <[\(\)]>+ $/,
               :v($verbose));

my @primitives = gather
{
  my $depth     = 0;
  my $primitive = '';

  for $str.comb -> $char {
    $primitive ~= $char;
    $char eq '(' ?? $depth++ !! $depth--;

    die "Encountered ')' without a preciding '('" if $depth < 0;
    
    if $depth == 0
    {
      take $primitive;
      say ": Primitive: $primitive" if $verbose;
      $primitive = '';
    }
  }

  die "Missing ')'" if $depth > 0;
};

say @primitives.map({ .substr(1, .chars - 2) }).join;
