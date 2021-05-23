# https://perlweeklychallenge.org/blog/perl-weekly-challenge-113/

sub challenge( @tree_input ) {
  my $sum_nodes = @tree_input».List.flat.sum;
  return @tree_input.deepmap( $sum_nodes - *);
}

multi sub MAIN( @tree_input ) {
  say 'Input Binary Tree  ',@tree_input;
  say 'Output Binary Tree ',challenge(@tree_input);
}

multi sub MAIN( 'challenge' ) {

  my @tree_input = 
    (1,  
      (2,  
          (4,
            (),
            (7)
          ),
      ),  
      (3, 
          (5),
          (6)
       )
     );
  MAIN(@tree_input);
}

multi sub MAIN( 'test' )  is hidden-from-USAGE {
  use Test;

  my @tree_input = 
    (1,  
      (2,  
          (4,
            (),
            (7)
          ),
      ),  
      (3, 
          (5),
          (6)
       )
     );

  my @tree_output = 
    (27, 
      (26, 
        (24,
          (),
          (21)
        )
      ), 
      (25, 
          (23),
          (22)
      )
    );

  is challenge(@tree_input),@tree_output;

  done-testing;

}
