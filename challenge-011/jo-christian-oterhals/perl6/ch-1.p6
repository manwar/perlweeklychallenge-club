#!/usr/bin/env perl6

multi MAIN( #= Compares the C. scale to any scale you dream up
  Real $f, #= freezing point in custom scale
  Real $b  #= boiling point in custom scale
) {
  say "There is no equal point for this scale." and exit if $b - $f == 100;
  my $equal-point = $f / (1 - (($b - $f) / 100));
  say "The calculated equal point is only theoretical as it is below absolute zero." if $equal-point < -273.15;
  say "Equal point: $equal-point";
}

multi MAIN( #= Compares the C. scale to a named temperature scale
  Str $scale where { $_ ~~ m:i/^(fahrenheit|kelvin|rankin)$/ } #= Name of scale (Fahrenheit, Kelvin or Rankin)
) {
  given $scale.fc {
    when "fahrenheit" { MAIN( 32   , 212   ); }
    when "kelvin"     { MAIN(273.15, 373.15); }
    when "rankin"     { MAIN(491.67, 671.67); }
  }
}
