#! /usr/bin/perl6

my %o;

for lines() {
  my $a=lc($_);
  $a ~~ s:g /<-[a .. z]>//;
  map {%o{$_}++}, split '',$a;
}

for sort keys %o -> $k {
  print "$k: %o{$k}\n";
}
