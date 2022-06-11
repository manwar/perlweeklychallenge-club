#!raku.exe

use v6;
use Prime::Factor;

# Author: Robert DiCicco
# Date: 01-FEB-2022
# Challenge 150 Square-Free Integer (Raku)

sub SquareFree {
  my %dvals = ();
  for @_ -> $num {
    if %dvals{$num}:exists {
      return False;
    } else {
      %dvals{$num} = 1;
    }
  }

  return True;
}

my $range = 1 .. 500;
for $range.list -> $elem {
    my @arr = prime-factors($elem);
    my $retval = SquareFree(@arr);
    if $retval { print("$elem ") };
}

say " ";
