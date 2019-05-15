sub center(*@a) {
  my $ml = @a.map({$_.chars}).max;
  say ' ' x (($ml - $_.chars)/2), $_ for @a;
}

center( "This", "is", "a test of the", "center function" );
