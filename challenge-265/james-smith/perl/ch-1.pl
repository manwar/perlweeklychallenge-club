sub appearance_33 {
  my( $threshold, $lowest, %counts ) = 0.33 * @_;

     ( ! defined $lowest || $_<=$lowest )
  && ( ++$counts{$_} > $threshold       )
  && ( $lowest = $_                     )
    for @_;

  $lowest
}


