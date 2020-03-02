#! /usr/bin/perl6

my @l=(2,6,1,3);

print join(' ',noble(@l)),"\n";

sub noble(@li) {
  my @l=sort @li;
  my @r;
  for (0..@l.end) -> $m {
    if (@l[$m] == @l.end-$m) {
      push @r,@l[$m];
    }
  }
  return @r;
}
