#!/home/chuck/rakudo/bin/perl6

use strict;

my @C = (0..9,"a".."z").flat;
print "ch-2.p6, PWC #43 Task #2: Self-descriptive Numbers\n";

loop ( my $b = 4; $b <= 24; $b++ ) {

  my $m = ($b - 4) * $b**($b-1) + 2 * $b**($b-2) + $b**($b-3) + $b**3;
  my @r;
  convert($b,$m,@r);

  my $base   = join("",@r);
  my $is_sdn;
  $is_sdn = verify($base);

  if ($is_sdn) { $is_sdn = "self-descriptive"; } 
  else { $is_sdn = "NOT self-descriptive"; }

  printf("Base: %2d, Nmbr: %30s, %25s = %s\n", $b, $m, $base, $is_sdn);
}

sub convert($b,$n,@erg) {
  my $d = Int( $n/$b );
  my $r = $n % $b;
  if ($r > 15) { $r = @C[$r]; }
  elsif ($r > 9) { $r = sprintf("%x", $r); }
  unshift(@erg,$r);
  convert($b,$d,@erg) if $d;
}

sub verify($sdn) {
  my $i = 0;
  my $is_sdn = 1;
  my @a = $sdn.split("",:skip-empty);
  for @a -> $v {
    my $search = @C[$i];
    my $nr = $sdn ~~ m:g/$search/;
    $nr = @C[$nr];
    if ( $v ne $nr ) {
      $is_sdn = 0;
      return $is_sdn;
    }
    $i++; 
  }
  return $is_sdn;
}

