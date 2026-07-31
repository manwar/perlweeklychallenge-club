
  use feature q/say/;
  
  sub nearest_rgb{
      my ($color) = @_;
      
      
  $color =~ tr/#//d;
  return undef if length($color) != 6;

      
      my $r = hex(substr($color, 0, 2));
      my $g = hex(substr($color, 2, 2));
      my $b = hex(substr($color, 4, 2));
  
      
  my $r_safe = int(($r + 25.5) / 51) * 51;
  my $g_safe = int(($g + 25.5) / 51) * 51;
  my $b_safe = int(($b + 25.5) / 51) * 51;

  
      return sprintf(q/#%02X%02X%02X/, $r_safe, $g_safe, $b_safe);
  }

  
MAIN:{
    say nearest_rgb q/#F4B2D1/;
    say nearest_rgb q/#15E6E5/;
    say nearest_rgb q/#191A65/;
    say nearest_rgb q/#2D5A1B/;
    say nearest_rgb q/#00FF66/;
}

