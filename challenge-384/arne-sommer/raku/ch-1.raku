#! /usr/bin/env raku

multi sub MAIN (Int :n(:$num), 
                Int :b(:$base) where $base == 1,
		    :v(:$verbose))
{
  say ( '0' x $num );
}

multi sub MAIN (Int :n(:$num),
                Int :b(:$base) where 2 <= $base <= 16,
		    :v(:$verbose))
{
  say $num.base($base);
}

multi sub MAIN (Int :n(:$num) is copy,
                Int :b(:$base) where 17 <= $base <= 64,
		    :v(:$verbose))
{
  my $result = "";

  while $num
  {
    my $digit   = $num % $base;
    my $new     = $num div $base;

    my $in-base = do given $digit
    {
      when * < 10  { $digit }
      when * < 36  { ($digit - 10 + 'A'.ord).chr }
      when * < 62  { ($digit - 36 + 'a'.ord).chr }
      when * == 62 { "+" }
      when * == 63 { "/" }
    }

    say ": $num / $base = $new + $digit -> $in-base" if $verbose;

    $result ~= $in-base;

    $num = $new;
  }

  say $result.flip;
}
