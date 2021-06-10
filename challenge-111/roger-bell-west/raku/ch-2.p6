#! /usr/bin/perl6

my $ml=0;
my @r;
for lines() {
  my $l=chars($_);
  if ($l >= $ml) {
    if ($_.comb.sort.join('') eq $_) {
      if ($l > $ml) {
        @r=();
        $ml=$l;
      }
      push @r,$_;
    }
  }
}

say $_ for @r;
