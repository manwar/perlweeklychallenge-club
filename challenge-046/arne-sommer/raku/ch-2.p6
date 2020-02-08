#! /usr/bin/env raku

unit sub MAIN (:$verbose);

my @open;

for 1 .. 500 -> $employee
{
  print "E: $employee | Rooms:" if $verbose;
  
  for ($employee, $employee + $employee ... 500) -> $index
  {
    print " $index" if $verbose;
    @open[$index] = ! @open[$index]; 
  }
  say "" if $verbose;
}

say "Open rooms: { (1..500).grep({@open[$_] }).join(',') }.";
