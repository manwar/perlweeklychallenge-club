# The script prints a new set of intervals, but merges adjacent intervals :(

sub challenge( @S, $N ) {
  my @initial = @S.shift;
  my $final   = (@initial[0][0]...@initial[0][1]);
  for @S -> @s {
    $final = $final ∪ (@s[0]...@s[1]);
  }
  my @items = ( $final ∪ ($N[0]...$N[1]) ).keys.sort;
  my ($item_start, $item_end) = (shift @items, );
  my @final_array = $item_start;
  for @items -> $item {
    if $item eq ++$item_start {
      $item_end = $item;
      next;
    }
    @final_array.push: $item_end, $item;
    $item_start = $item;
  }

  return @final_array.push: $item_end;
}

multi sub MAIN( @S, $N ) {
  print "\nInput \$S = ";
  for @S -> @a { 
    print "(@a[0], @a[1]), ";
  }
  print "; \$N = ($N)";
  print "\nOutput: ";
  my @output = challenge( @S, $N );
  for @output.sort -> $a, $b {
    print "($a, $b), ";
  }
  print "\n";
}

multi sub MAIN( 'challenge' ) {
  say "The script prints a new set of intervals, but merges adjacent intervals :( \n";
  my @S1 = (1,4), (8,10);
  my $N1 = (2,6);

  my @S2 = (1,2), (3,7), (8,10);
  my $N2 = (5,8);

  my @S3 = (1,5), (7,9);
  my $N3 = (10,11);
  
  my @challenges = (
    (@S1, $N1),
    (@S2, $N2),
    (@S3, $N3)
  );

  for @challenges -> @challenge {
    &MAIN(@challenge[0],@challenge[1]);
  }
}

