#! /usr/bin/env raku

subset PosInt of Int where * > 0;

unit sub MAIN (PosInt $n, :v(:$verbose));

my @pairs = divisor-pairs($n);

say ": Divisor pairs: { @pairs.raku }" if $verbose;

if @pairs.elems > 1
{
  for @pairs.combinations(2) -> $pair
  {
    my $a = $pair[0][0];
    my $b = $pair[0][1];
    my $c = $pair[1][0];
    my $d = $pair[1][1];

    if ($a * $b == $c * $d == $n && $a + $b == $c + $d + 1)
    {
      say ": a:$a b:$b c:$c d:$d" if $verbose;
      say 1;
      exit;
    }
  }
}

say 0;

sub divisor-pairs ($number)
{
  my @divisors;
  my %seen;

  # return ((1,1),) if $number == 1;

  for (1 .. $number/2) -> $candidate
  {
    if $number %% $candidate
    {
      my $b = $number div $candidate;

      next if %seen{$candidate};

      %seen{$b} = True;
      
      @divisors.push: ($candidate, $b);
    }
  }

  return @divisors;
}
