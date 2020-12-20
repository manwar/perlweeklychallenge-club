#! /usr/bin/env raku

subset PositiveInt of Int where * > 0;

unit sub MAIN (PositiveInt $N);

say look-and-say($N);

sub look-and-say ($input)
{
  my $return = "";
  
  for $input.comb: / (.) $0* / -> $batch
  {
    $return ~= $batch.chars ~ $batch.substr(0,1);
  }
  
  return $return;
}

