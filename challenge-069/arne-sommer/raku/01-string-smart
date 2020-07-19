#! /usr/bin/env raku

unit sub MAIN ($limit = 30);

sub switch ($string)
{
  return $string.comb.map({ $_ eq "1" ?? 0 !! 1 }).join;
}

my $string01 := gather
{
  my $prev = "";

  loop
  {
    take $prev;
    $prev = $prev ~ “0” ~ switch($prev.flip);
  }
}

say "S$_ = \"{ $string01[$_] }\"" for 0..$limit;
