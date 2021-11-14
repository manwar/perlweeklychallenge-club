#! /usr/bin/env raku

unit sub MAIN (Int $N where $N > 0);

say int-sqare-root($N);

sub int-sqare-root ($number)
{
  my $x0 = lrs($number);

  if $x0
  {
    my $x1 = lrs( $x0 + $number / $x0 );
		
    while $x1 < $x0			
    {
      $x0 = $x1;
      $x1 = lrs( $x0 + $number / $x0 );
    }
    return $x0;
  }
  else
  {
    return $number;
  }
}

sub lrs ($value)
{
  my $binary = $value.Int.base(2);
  my $new    = '0' ~ $binary.substr(0, $binary.chars -1);
  return $new.parse-base(2);
}
