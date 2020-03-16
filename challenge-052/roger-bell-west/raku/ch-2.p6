#! /usr/bin/perl6

# see eventual blog post for why this is relevant

my $coins=8;

for (0..$coins-1) -> $a {
  my @c=($a,$coins-1-$a);
  while ((@c[0]>2 || @c[1]>2) && @c[0]>0 && @c[1]>0) {
    @c=sort @c;
    @c[1]-=2;
  }
  my $toplay=0;
  while ((@c[0]>1 || @c[1]>1) && @c[0]>0 && @c[1]>0) {
    @c=sort @c;
    @c[1]--;
    $toplay=1-$toplay;
  }
  @c=sort @c;
  unless (@c[0]==0) {
    $toplay=1-$toplay;
  }
  say "$a left: player $toplay wins";
}
