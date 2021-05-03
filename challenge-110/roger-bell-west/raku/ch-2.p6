#! /usr/bin/perl6

my @a;
my $ri=0;

for lines() {
  my @r=split ',',$_;
  for 0..@r.elems-1 -> $ci {
    @a[$ci][$ri]=@r[$ci];
  }
  $ri++;
}

for @a -> @r {
  say join(',',@r);
}