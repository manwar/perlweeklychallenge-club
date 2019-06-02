#!/usr/bin/env/perl6

#| Jaro similarity
sub sim-j (Str $a, Str $b) {
  # It's just easier to operate on arrays.
  my @si = $a.comb;
  my @sj = $b.comb;

  # Maximum matching character distance.
  my $lim = max(@si, @sj) / 2 - 1;

  # Sparse hash of matching characters, keyed by index.
  my %m;

  # Loop through the first array.
  # This should possibly be the longest array instead.
  for @si.pairs -> $i {
    # Set the limits for searching the second string.
    my $jf = max(0, $i.key - $lim);
    my $jt = min($i.key + $lim, @sj-1);

    # Loop through the indices of the second array that are within
    # limit of the first array,
    for @sj[$jf..$jt] -> $j {
      if $j eq $i.value && !(%m{$i.key}) {
        # and add the first matching character in the first array to
        # map of matches where that index is not already present.
        %m{$i.key} = $i.value;
        last;
      }
    }
  }

  # Were there any matching characters? Bag them.
  if my $m = %m.values.Bag {
    # Number of transpositions starts at zero.
    my $t = 0;

    # Disposable iterator of matching characters, in the order they
    # appear in the second string.
    my @sij = @sj.grep(* ∈ $m);

    # Try to match up the sequences of matching characters in si and
    # sj; any out of sequence characters increment $t
    for @si.grep(* ∈ $m).pairs {
      $t++ while @sij && @sij.shift ne .value;
    }

    $t /= 2; # Jaro formula takes into account that transpositions are doubled.

    # Apply the formula
    ($m / @si + $m / @sj + 1 - $t / $m) / 3 
  } else { 0 }
}

#| Jaro-Winkler similarity
sub sim-w (Str $a, Str $b, Rat :$p = 1/10) {
  # Only proceed if the Jaro similarity ≠ 0;
  if my $simj = sim-j($a,$b) {
    # Determine the matching prefix length.  I wanted to use
    # Array:D.reduce for this, but it did not like last.
    my $l = 0;
    for ($a.comb Z $b.comb)[^4] -> [$ai, $bi] {
      $ai eq $bi or last;
      $l++;
    }

    # Apply the Winkler forumla;
    $simj + $l * $p * (1 - $simj);
  } else { 0 }
}

# Jaro-Winkler distance is the 1 minus the Jaro-Winkler similarity.
say 1 - sim-w(|@*ARGS[^2]);
