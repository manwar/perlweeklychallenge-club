#! /usr/bin/env raku

unit sub MAIN (UInt :$base = 10);

if $base == any(0,1,2,3,6) || $base > 39
{
  say "Error";
}
elsif $base == 5
{
  say "21200";   # Prevent "11100"
}
else
{
  my $number = "{ ($base -4).base(36) }21" ~ "0" x ($base - 3);
  $number.substr-rw(*-4,1) = 1;
  say $number;
}
