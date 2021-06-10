# https://perlweeklychallenge.org/blog/perl-weekly-challenge-112/

sub challenge( $top ) {
  my $steps = 1 x $top;
  my $number_steps = 1;
  while $steps ~~ /11/ {
    $steps = $steps.subst('11','2');
    $number_steps += $steps.split('', :skip-empty).permutations.unique(:with(&[eqv])).elems;
  }
  return $number_steps;
}

sub write_steps( $top ) {
  my $steps = 1 x $top;
  my @options;
  @options.push: $steps.split('', :skip-empty);
  while $steps ~~ /11/ {
    $steps = $steps.subst('11','2');
    @options.append: $steps.split('', :skip-empty).permutations.unique(:with(&[eqv]));
  }
  return @options;
}

multi sub MAIN( $top ) {
  say "\nInput: \$n = ",$top;
  say 'Output:     ',challenge($top);
  my $i;
  for write_steps($top) -> @steps {
    say '    Option ',++$i,': ',@steps.join('').subst('1','1 step  + ', :g).subst('2','2 steps + ', :g).chop(3);
  }
}

multi sub MAIN( 'challenge' ) {
  MAIN(3);
  MAIN(4);
}

multi sub MAIN( 'test' )  is hidden-from-USAGE {
  use Test;

  is challenge(3),3;
  is challenge(4),5;
  is challenge(10),89;

  done-testing;

}
