my @dg = (
  ([1, 3], [3, 1], [2, 4], [6, 8]),
  ([1, 2], [2, 1], [1, 1], [1, 2], [2, 2])
);

sub find-similar (@d) {
  my $similars = [];
  my @f = @d.pairs;
  while (my $d = @f.shift) {

    my %c = @f.classify(-> $a is copy {
      ($d.value ~~ $a.value || $d.value ~~ $a.value.reverse) ?? 'similar' !! 'not'
    });

    if %c<similar> {
      $similars.push: $d.key, |%c<similar>.map(*.key);
      for $similars -> $s {
        @f.splice( @f.first({ .key == $s }, :k), 1 )
      }
    }

  }
  $similars;
}

for @dg {
  if find-similar($_) -> $s {
    $s.gist.say;
  }
}
