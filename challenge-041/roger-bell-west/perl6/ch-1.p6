#! /usr/bin/perl6

my $top=50;

my @factors=grep {is-prime($_)}, (1..$top);
my %pc=map {$_ => 1}, @factors;

for (1..$top) -> $c {
  my $cc=$c;
  my $cn=0;
  my @ff=@factors;
  while ($cc != 1 && !(%pc{$c}:exists)) {
    my $l=@ff[0];
    while ($cc % @ff[0] == 0) {
      $cn++;
      $cc /= @ff[0];
    }
    shift @ff;
  }
  if (%pc{$c}:exists) {
    $cn++;
  }
  if (%pc{$cn}:exists) {
    say $c;
  }
}