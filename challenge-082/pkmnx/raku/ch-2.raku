#!/usr/bin/env rakudo

sub MAIN( Str $A = "XXY", Str $B = "XXZ", Str $C = "XXXXZY" ) {

   my @a = (0 .. $A.chars -1 ).map(-> $k { $A.substr($k, 1).chomp() } );
   my @b = (0 .. $B.chars -1 ).map(-> $k { $B.substr($k, 1).chomp() } );
   my @c = (0 .. $C.chars -1 ).map(-> $k { $C.substr($k, 1).chomp() } );

   die("bad input!") unless ( @a.elems && @b.elems && @c.elems );

   while ( @a.elems || @b.elems || @c.elems ) {

      if ( @a.elems && @a.head eq @c.head ) {
         @a.shift();
         @c.shift();
      }

      if ( @b.elems && @b.head eq @c.head ) {
         @b.shift();
         @c.shift();
      }

      last if ( (! @a.elems ) && @b.join("") ne @c.join("") );
      last if ( (! @b.elems ) && @a.join("") ne @c.join("") );

   } 

   ( @a.elems + @b.elems + @c.elems >0 ?? "0" !! "1" ).say;

}
