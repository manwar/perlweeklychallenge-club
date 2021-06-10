BEGIN {
  FS = ","
}
{
  for (i = 1 ; i <= NF ; i = i + 1 ) {
      if ( length( rows[ i ] ) == 0 ) {
    rows[ i ] =  $i
      }
      else {
    rows[ i ] = rows[ i ] "," $i
      }
  }
}
END {
  for (i = 1 ; i <= NF ; i = i + 1 ) {
      print rows[i]
  }
}
