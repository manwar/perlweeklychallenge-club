#! /usr/bin/env raku

unit sub MAIN (Int $count where $count > 0 = 20, :v(:$verbose));

my $ptm := (1 .. Inf).grep( *.&is-ptm );

say $ptm[^$count].join(", ");

sub is-ptm ($number)
{
  my @totients;
  my $c = $number;

  while $c > 1
  {
    $c = totient($c);
    @totients.push: $c;
  }

say ":: $number [@totients[]] sum:{ @totients.sum } { $number == @totients.sum ?? "match" !! "" }" if $verbose;

  return @totients.sum == $number;
}

sub totient ($number)
{
  my $count = 0;

  for 1 .. $number -1 -> $candidate
  {
    $count++ if $number gcd $candidate == 1;
  }

  return $count;
}

