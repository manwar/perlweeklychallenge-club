#! /usr/bin/perl6

my @L = (0, 1, 2, 5);
my $X = 2;
my $Y = 21;

my %out;
my @counter=(0) xx $X;
my $d=1;
while ($d) {
  my $c=join('',map {@L[$_]},@counter);
  $c ~~ s/^0+//;
  if (chars($c) == $X && $c < $Y) {
    %out{$c}=1;
  }
  # evaluate
  my $i=0;
  while (1) {
    @counter[$i]++;
    if (@counter[$i] <= @L.end) {
      last;
    }
    @counter[$i]=0;
    $i++;
    if ($i>@counter.end) {
      $d=0;
      last;
    }
  }
}

for %out.keys.sort {
  say $_;
}
