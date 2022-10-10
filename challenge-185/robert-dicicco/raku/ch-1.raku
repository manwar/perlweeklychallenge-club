use v6;

# AUTHOR: Robert DiCicco
# DATE: 2022-10-03
# Challenge 185  Mac Address ( Raku )

my @inp = ("1ac2.34f0.b1c2", "abc1.20f1.345a");

for ( @inp ) -> $i {

  my ($wrk, $outstr);

  my $x = 0;

  $wrk = join('',split('.', $i));

  while $x < $wrk.chars {

    $outstr ~= (substr($wrk, $x, 2 ) ~ ":");

    $x += 2;

  }

  say $outstr.chop;

}
