#!/usr/bin/awk -f

{
  for ( i = 2 ; i <= NF ; i++ ) {
      if ( $(i - 1) == $i ) {
    duplicate = $(i - 1)
    if ( i == NF ) {
        missing = $(i - 1) + 1
    }
      }
      if ($i - $(i - 1) > 1 ) {
    missing = $(i - 1 ) + 1
      }
  }
  print "(" duplicate " " missing ")"
}
