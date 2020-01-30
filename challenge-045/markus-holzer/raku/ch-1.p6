multi sub MAIN( Str $message )
{
    say encrypt-squarely( $message ).join(' ');
}

multi sub MAIN( "test" )
{
  use Test;
  my $message = “The quick brown fox jumps over the lazy dog”;
  my $encrypt = encrypt-squarely( $message );
  is-deeply( $encrypt, ('tbjrd', 'hruto', 'eomhg', 'qwpe', 'unsl', 'ifoa', 'covz', 'kxey'), "correctly encrypted" );
}

sub encrypt-squarely( $message )
{
    roundrobin( 
      $message
      .subst(' ', '', :g)
      .lc
      .comb(/ . **! {1..8} /)              
      .map({ .split('', :skip-empty) }) 
    )                                   
    .map({ .join })                          
}