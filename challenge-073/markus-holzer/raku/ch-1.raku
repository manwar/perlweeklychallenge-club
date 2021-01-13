my @A = 1, 5, 0, 2, 9, 3, 7, 6, 4, 8;
my $S = 3;
say join ' ', @A.rotor( $S => -($S - 1) ).map: *.min;
