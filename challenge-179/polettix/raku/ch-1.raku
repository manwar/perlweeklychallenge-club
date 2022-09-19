#!/usr/bin/env raku
use v6;
sub MAIN (Int:D $n where * > 0 = 99) {
   put spelled-ordinal($n);
}

sub spelled-ordinal (Int:D $n where * > 0) {
   state %corrective-for = <
      one first
      two second
      three third
      five fifth
      eight eighth
      nine ninth
      twelve twelfth
      twenty twentieth
      thirty thirtieth
      forty fortieth
      fifty fiftieth
      sixty sixtieth
      seventy seventieth
      eighty eightieth
      ninety ninetieth
   >;
   my $spelled = spelled-cardinal($n);
   if my $match = $spelled ~~ / ^ (.*) (<[ - \s ]>) (\w+) $ / {
      my @parts = $match[0..*]».Str;
      my $last := @parts[*-1];
      $last = %corrective-for{$last}:exists
         ?? %corrective-for{$last}
         !! $last ~ 'th';
      $spelled = @parts.join('');
   }
   else {
      $spelled = %corrective-for{$spelled}:exists
         ?? %corrective-for{$spelled}
         !! $spelled ~ 'th';
   }

   return $spelled;
}

sub spelled-cardinal (Int:D $n is copy where * > 0) {
   state %name-for = <
      1 one
      2 two
      3 three
      4 four
      5 five
      6 six
      7 seven
      8 eight
      9 nine
      10 ten
      11 eleven
      12 twelve
      13 thirteen
      14 fourteen
      15 fiftheen
      16 sixteen
      17 seventeen
      18 eighteen
      19 nineteen
      20 twenty
      30 thirty
      40 forty
      50 fifty
      60 sixty
      70 seventy
      80 eighty
      90 ninety
   >;
   my @magnitudes = '', <
      thousand million billion trillion quatrillion
      quintillion sextillion septillion octillion
   >.Slip;

   my @spelling;
   while $n > 0 {
      my $lower = $n % 100;
      $n = (($n - $lower) / 100).Int;
      my $hundredths = $n % 10;
      $n = (($n - $hundredths) / 10).Int;

      my @chunk;

      @chunk.push: "%name-for{$hundredths}-hundred" if $hundredths;

      if $lower {
         if %name-for{$lower}:exists {
            @chunk.push: %name-for{$lower};
         }
         else {
            my $units = $lower % 10;
            my $decs  = $lower - $units;
            @chunk.push: "%name-for{$decs}-%name-for{$units}";
         }
      }

      my $magnitude = @magnitudes.shift;
      @chunk.push: $magnitude if $magnitude.chars && @chunk.elems;

      @spelling.unshift: @chunk if @chunk;
   }

   return @spelling.join(', ');
}
