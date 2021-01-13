#! /usr/bin/perl6

my @i;

while (@*ARGS) {
  if (@*ARGS.elems > 1) {
    push @i,sort((shift @*ARGS),(shift @*ARGS));
  }
}

my $dirty=1;
while ($dirty) {
  $dirty=0;
  for (0..@i.end-1) -> $a {
    for ($a+1..@i.end) -> $b {
      if (@i[$a][1] >= @i[$b][0]) {
        @i[$a]=(@i[$a][0],@i[$b][1]);
        splice @i,$b,1;
        $dirty=1;
        last;
      }
    }
    if ($dirty==1) {
      last;
    }
  }
}

my @o;
for @i -> @range {
  push @o,'[' ~ @range[0] ~ ', ' ~ @range[1] ~ ']';
}
say join(', ',@o);
