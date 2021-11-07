#! /usr/bin/env raku

unit sub MAIN (Int $n where 10 <= $n <= 1000);

say + is-lychrel($n);

sub is-lychrel ($current is copy)
{
  my $i = 0;
  
  loop
  {
    $current = $current + $current.flip;

    return False if $current == $current.flip;

    return True if $i++ == 500 || $current >= 10_000_000;
  } 
}
