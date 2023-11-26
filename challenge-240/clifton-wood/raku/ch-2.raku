sub build-array ($a) {
  $a.keys.map( $a[$a[$_]] )
}
