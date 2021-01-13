#! /usr/bin/perl6

my @a=@*ARGS;

for min(@*ARGS)..max(@*ARGS) -> $c {
  my @d=$c.comb(/./);
  my $v=1;
  for 0..@d.end-1 -> $i {
    if (@d[$i]+1 != @d[$i+1]) {
      $v=0;
      last;
    }
  }
  if ($v) {
    say $c;
  }
}
