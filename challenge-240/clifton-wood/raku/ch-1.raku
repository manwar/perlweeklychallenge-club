sub acronyms ($str, $chk) {
  $str.map( *.comb.head.lc ).join eq $chk
}
