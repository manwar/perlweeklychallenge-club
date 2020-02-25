my $target = 200;
my %hit := {1 => 1};
my $steps = 0;
repeat {
  for (%hit.keys) -> $key {
    %hit{$key+1} = $key;
    %hit{$key*2} = $key;
  }
  $steps++;
} until %hit{$target};

say $steps;
