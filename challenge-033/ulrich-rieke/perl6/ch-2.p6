use v6 ;

sprintf("%4s" , "x|" ).print ;
for (1..11) -> $num {
  sprintf("%4d" , $num ).print ;
}
print "\n" ;
say "-" x 48 ;
for (1..11) -> $num {
  sprintf("%4s" , "$num|" ).print ;
  if ( $num > 1 ) {
      print " " x ( ($num - 1 ) * 4 ) ;
  }
  for ( $num..11 ) -> $mult {
      sprintf("%4d", $num * $mult ).print ;
  }
  print "\n" ;
}
