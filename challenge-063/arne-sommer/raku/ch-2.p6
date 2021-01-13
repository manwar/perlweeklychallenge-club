#! /usr/bin/env raku

subset XY where /^<[xy]>+$/;

sub MAIN (XY $string = 'xyxx', :$verbose)
{
  my $length  = $string.chars;
  my $current = $string;

  my $count = 0;

  loop
  {
    $count++;

    my $rotate = $count % $length;

    if $rotate
    {
      my $a = $current.substr($rotate);
      my $b = $current.substr(0, $rotate);

      $current = $a ~ $b;
    
      say ": Rotation $count: $current (moved '$b' to the end)" if $verbose;
    }
    elsif $verbose
    {
      say ": Rotation $count: $current (moved nothing)";
    }

    last if $current eq $string;
  }

  say "$count Rotations";
}
