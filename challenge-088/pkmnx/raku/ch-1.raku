#!/usr/bin/env rakudo

#
# ex: ./ch-1.raku 5 2 1 4 3
#

sub MAIN ( *@N where @N.elems >2 && all(@N) ~~ Int ) {

   my %h;
   ( (^@N.elems) X (^@N.elems) ).grep(-> ($x,$y) { $x != $y }).map( -> ($x, $y) { %h{$x}.push( @N[$y] ) });

   "Input: ".say;
   print "@N = (";
   print @N.join(", ");
   print ")\n";

   my @output = %h.keys.sort.map(-> $k {
      my @v = @(%h{$k}); my $prd = ([*] @v);  ('$M[' ~ $k ~ '] = ' ~ @v.join(' x ') ~ ' = ' ~ $prd, $prd )
   });

   "Output: ".say;
   print "@M = (";
   print @output.map( -> ($k,$v) { $v }).join(", ");
   print ")\n\n";

   @output.map( -> ($k,$v) {
     $k.say;
   });
}
