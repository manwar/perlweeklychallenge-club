use v6 ;

sub myMin( $a , $b ) {
  if ( $a < $b ) {
      return $a ;
  }
  else {
      return $b ;
  }
}

sub myMax( $a , $b ) {
  if ( $a > $b ) {
      return $a ;
  }
  else {
      return $b ;
  }
}

sub createParent( $dividend is copy, $divisor is copy , $bdividend is copy ,
      $bdivisor is copy ) {
  my $product = ( $dividend / $divisor ) * ( $bdividend / $bdivisor ) ;
  my $firstMin = myMin( $dividend, $divisor ) ;
  my $secondMin = myMin( $bdividend, $bdivisor ) ;
  if ( $product > 1 ) {
      return myMax( $firstMin, $secondMin ) ~ "/" ~ myMin( $firstMin ,
        $secondMin) ;
  }
  if ( $product < 1 ) {
      return myMin( $firstMin, $secondMin) ~ "/" ~ myMax( $firstMin ,
        $secondMin ) ;
  }
  if ( $product == 1 ) {
      return "1/1" ;
  }
}

sub createBrother( $dividend is copy, $divisor is copy ) {
  my @result ;
  my $maximum ;
  my $minimum ;
  if ( $dividend > $divisor ) {
      $maximum = $dividend ;
      $minimum = $divisor ;
  }
  else {
      $maximum = $divisor ;
      $minimum = $dividend ;
  }
  my $brotherDividend ;
  my $brotherDivisor ;
  if ( $maximum == $dividend ) {
      $brotherDivisor = $maximum ;
      $brotherDividend = $maximum - $minimum ;
  }
  else {
      $brotherDividend = $maximum ;
      $brotherDivisor = $maximum - $minimum ;
  }
  @result.push( $brotherDividend , $brotherDivisor ) ;
  return @result ;
}

say "Enter a member as as fraction: 'dividend / divisor' !" ;
my $member = $*IN.get ;
while ( $member !~~ /^(\d+) \s* '/' \s* (\d+) $/ ) {
  say "Please enter a fraction as 'dividend / divisor' !" ;
  $member = $*IN.get ;
}
my $dividend = +$0 ;
my $divisor = +$1 ;
if ( $dividend == 1 && $divisor == 1 ) {
  say "parent = " ~ " " ~ " and grandparent =" ~ " " ;
}
elsif ( $dividend / $divisor == 0.5 || $dividend / $divisor == 2 ) {
  say "parent = 1/1 and grandparent =  !" ;
}
else {
  my @brotherFraction = createBrother( $dividend , $divisor ) ;
  my $parent = createParent( $dividend, $divisor , |@brotherFraction ) ;
  my $grandparent ;
  if ( $parent ~~ /^(\d+) '/' (\d+) $/ ) {
      my @uncle = createBrother( +$0 , +$1 ) ;
      $grandparent = createParent( +$0 , +$1 , |@uncle ) ;
  }
  if ( $parent ) {
      print "parent = $parent " ;
  }
  if ( $grandparent ) {
      say " and grandparent = $grandparent" ;
  }
}
