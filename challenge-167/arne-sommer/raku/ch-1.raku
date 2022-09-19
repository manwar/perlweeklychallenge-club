#! /usr/bin/env raku

unit sub MAIN (Int $c where $c > 1 = 10);

my $cp := (100 .. *).grep({ is-circular($_) });

sub is-circular ($number)
{
  state %seen;

  return if %seen{$number}; %seen{$number} = True;

  return unless $number ~~ /^<[1379]>+$/;
  return unless $number.is-prime;

  my @digits = $number.comb;

  for (1 .. @digits.elems -1) -> $skew
  {
    my $rotated = @digits.rotate($skew).join;
    return if %seen{$rotated};
    return unless $rotated.is-prime;
  }

  return True;
}

say $cp[^$c].join(", ");