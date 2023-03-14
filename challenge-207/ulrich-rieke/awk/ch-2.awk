#!/usr/bin/awk -f
{
  h = 0
  for (i = 1 ; i <= NF ; i++) {
      if ( $i >= i ) {
    if ( i > h ) {
        h = i
    }
      }
  }
  print h
}
