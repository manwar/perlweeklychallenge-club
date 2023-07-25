#!/usr/bin env raku
=begin comment
-------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-07-24
Challenge 227 Task 1 Fridat 13th ( Raku )
-------------------------------------
=end comment
use v6;

my $year = 0;

if @*ARGS == 0 {
   say "Please supply a year between 1753 and 9999";
   exit(1);
}

for @*ARGS -> $arg {
  if (( $arg < 1753 ) || ( $arg > 9999 )) {
    say "Please supply a year between 1753 and 9999";
    exit(1);
  }
  $year = $arg;
}

my $month = 1;
while $month <= 12 {
    my $d = Date.new($year, $month, 13);
    if $d.day-of-week == 5 {
        say "$year $month 13 : was a Friday";
    }
    $month++;
}

=begin comment
-------------------------------------
SAMPLE OUTPUT

raku .\Friday13.rk 2023

2023 1 13 : was a Friday
2023 10 13 : was a Friday

raku .\Friday13.rk 1753

1753 4 13 : was a Friday
1753 7 13 : was a Friday

-------------------------------------
=end comment


