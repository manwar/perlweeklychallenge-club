#! /usr/bin/perl6

for @*ARGS -> $i {
  my %f=primefactor($i);
  my @o="$i:";
  for %f.keys.sort({$^a <=> $^b}) -> $ff {
    push @o,($ff) xx %f{$ff};
  }
  say join(' ',@o);
}

sub primefactor ($nn) {
  my $n=$nn;
  my %out;
  while ($n%2 == 0) {
    %out{2}++;
    $n/=2;
  }
  my $k=3;
  while ($k*$k <= $n) {
    while ($n % $k == 0) {
      %out{$k}++;
      $n /= $k;
    }
    $k+=2;
  }
  %out{$n}++;
  return %out;
}
