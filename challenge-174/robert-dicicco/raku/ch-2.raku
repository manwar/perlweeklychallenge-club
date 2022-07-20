use v6;

# AUTHOR: Robert DiCicco
# DATE: 2022-07-20
# Challenge 174 Permutation Ranking (Raku )

my @p;

sub printArray() {

  my $count = 0;

  for @p -> $x {

    print("$count: $x\n");

    $count++;

  }

}

sub rank2permutation( $lst, $x ) {

  createPermList( $lst );

  printArray();

  return @p[$x];

}

sub permutation2rank( $lst) {

  for 0 .. (@p.elems - 1) -> $i {

    return $i if ( @p[$i] eq $lst );

  }

  return -1;

}

sub createPermList( $lst ) {

  @p = $lst.permutations;

}

my @seq1 = [0,1,2];

createPermList(@seq1);

printArray();

my @seq2 = [1,0,2];

my $retval = permutation2rank(@seq2);

#print("\nretval = $retval\n\n");

print("permutation2rank\([" ~ @seq2 ~ "]\) = $retval\n\n");

$retval = rank2permutation(@seq1, 1);

print("rank2permutation\([" ~ @seq2 ~ "], 1 \) = \[$retval\]\n");
