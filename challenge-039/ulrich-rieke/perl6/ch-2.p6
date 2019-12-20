use v6 ;


sub hasSameOrder( Str $op1 , Str $op2 --> Bool) {
  my @first_order_oper = <* /> ;
  my @second_order_oper = <- +> ;
  return ( ($op1 (elem) @first_order_oper) &&
    ( $op2 (elem) @first_order_oper) ) || ( ($op1 (elem)
          @second_order_oper ) && ( $op2 (elem)
          @second_order_oper ) ) ;
}


sub toRPN( Str $expression --> Str ) {
  my Str $rpn ;
  my @first_order_oper = <* /> ;
  my @second_order_oper = <- +> ;
  my token decimal { \d+ } ;
  my token operand {<[+\-*/]>} ;
  my regex float {
      <decimal>?
      '.'
      <decimal>
  } ;
  my regex number {
      <decimal> || <float>
  } ;
  if ( $expression ~~ /(<number>) \s+ (<operand>) \s+ (<number>) (\s+ ( <operand>)
    \s+ (<number>))?/ ) {
      if ( $3 ) {
    if ((~$3[0] (elem) @first_order_oper) && ( ~$1 (elem)
          @second_order_oper) ) {
        $rpn = ~$2 ~ " " ~ ~$3[1] ~ " " ~ ~$3[0] ~ " " ~ ~$0 ~
          " " ~ ~$1 ;
    }
    if ((~$3[0] (elem) @second_order_oper) && ( ~$1 (elem)
          @first_order_oper)) {
        $rpn = ~$0 ~ " " ~ ~$2 ~ " " ~ ~$1 ~ " " ~ ~$3[1] ~ " "
          ~ ~$3[0] ;
    }
    if ( hasSameOrder( ~$1 , ~$3[0] )) {
        $rpn = ~$0 ~ " " ~ ~$2 ~ " " ~ ~$1 ~ ~ " " ~$3[1] ~ " " ~ ~$3[0] ;
    }
      }
      else { #no second operator of whatever same or different precedence
    $rpn = ~$0 ~ " " ~ ~$2 ~ " " ~ ~$1 ;
      }
  }
  else {
      $rpn = "Not tested in this basic version or wrong format!" ;
  }
  return $rpn ;
}

sub MAIN( Str $expression ) {
  say toRPN( $expression ) ;
}
