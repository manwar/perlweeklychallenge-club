sub read-n( $filename, $characters ) {
  state %handles;
  .readchars( $characters )
    given %handles{ $filename.IO.absolute } //= $filename.IO.open( :r ) }
