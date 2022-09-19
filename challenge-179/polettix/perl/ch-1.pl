#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';

my $n = shift // 99;
say spelled_ordinal($n);

sub spelled_ordinal ($n) {
   state $corrective_for = {
      qw<
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
      >
   };
   my $spelled = spelled_cardinal($n);
   my ($pre, $last) = $spelled =~ m{\A (.*[-\s]) (\w+) \z}mxs;
   ($pre, $last) = ('', $spelled) unless defined $last;

   $last = exists $corrective_for->{$last}
      ? $corrective_for->{$last}
      : $last . 'th';

   return $pre . $last;
}

sub spelled_cardinal ($n) {
   state $name_for = {
      qw<
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
      >
   };
   my @magnitudes = ('', qw<
         thousand million billion trillion quatrillion
         quintillion sextillion septillion octillion
      >
   );

   my @spelling;
   while ($n > 0) {
      my $lower = $n % 100;
      $n = int(($n - $lower) / 100);
      my $hundredths = $n % 10;
      $n = int(($n - $hundredths) / 10);

      my @chunk;

      push @chunk, "$name_for->{$hundredths}-hundred" if $hundredths;

      if ($lower) {
         if (exists $name_for->{$lower}) {
               push @chunk, $name_for->{$lower};
         }
         else {
            my $units = $lower % 10;
            my $decs  = $lower - $units;
            push @chunk, "$name_for->{$decs}-$name_for->{$units}";
         }
      }

      my $magnitude = shift @magnitudes;
      push @chunk, $magnitude if length($magnitude) && @chunk;

      unshift @spelling, join ' ', @chunk if @chunk;
   }

   return join ', ', @spelling;
}
