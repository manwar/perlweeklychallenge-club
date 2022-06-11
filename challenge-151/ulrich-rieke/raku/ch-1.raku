use v6 ;

say "Enter binary tree, denoting every new level with a |" ;
my $tree = $*IN.get ;
my $mindepth = 0 ;
my $len = $tree.chars ;
for (0 .. $len - 1 ) -> $i {
  if ( $tree.substr( $i , 1 ) eq '|' ) {
      $mindepth++ ;
  }
}
say $mindepth ;
