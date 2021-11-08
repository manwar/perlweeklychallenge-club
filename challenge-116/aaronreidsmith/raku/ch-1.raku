#!/usr/bin/env raku

# Raku adaptation of Python's more-itertools.partitions: https://git.io/JZL8Q
sub partitions(Str $S) {
  my @sequence = $S.comb;
  my $n = @sequence.elems;
  my @partitions = gather for (1..^$n).combinations -> @combination {
    my @partition = gather for (0, |@combination) Z (|@combination, $n) -> ($i, $j) {
      take [@sequence[$i..^$j]];
    }
    take @partition;
  }
  gather for @partitions -> @partition {
    # Filter out elements with leading zeros
    my @invalid = @partition.grep(*.head eq '0');
    if @invalid.elems == 0 {
      take @partition.map(*.join.Int);
    }
  }
}

sub challenge(Int $N where $N >= 10) returns Str {
  my $S = $N.Str;
  my $solution = partitions($S).first: -> @partition {
    my @zipped = @partition[0..*-1] Z @partition[1..*];
    my @filtered = @zipped.grep(-> ($a, $b) { $b - $a == 1 });
    @zipped.elems > 0 && @zipped.elems == @filtered.elems;
  }

  with $solution {
    $solution.join(',');
  } else {
    $S
  }
}

multi sub MAIN(Int $N) {
  say challenge($N);
}

multi sub MAIN(Bool :$test) {
  use Test;

  my @tests = (
    (1234, '1,2,3,4'),
    (91011, '9,10,11'),
    (10203, '10203')
  );

  for @tests -> ($N, $expected) {
    is(challenge($N), $expected);
  }

  done-testing;
}
