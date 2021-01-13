#!/usr/bin/env rakudo
#
# ex. ./ch-2.raku < input.txt # where input is rectangular shaped data block of numbers
#

sub MAIN () {

   my $d = verifyInput();

   "Input:".say;
   $d.join("\n").say;

   my $output;

   while ($d) {
      my $f = $d.shift;

      $output.push($f);
      if ($d) {
         my $l = $d.pop.reverse;

         my $leftCnt = 0;
         my $tmp;
         while ($d) {
            my $t = shift $d;
            if ( $t.elems ) {
               my $tl = pop $t;
               $output.push($tl);
               $tmp.push($t);
            }
            $leftCnt++;
         }
         
         if ( $l ) {
            $output.push($l);
            $l = Nil;
         }

         while ( $leftCnt >0 ) { 
            my $t = pop $tmp;
            if ( $t.elems ) { 
               my $tf = shift $t;
               $output.push($tf);
               if ( $d ) { 
                  $d.unshift( ($t) );
               } else {
                  $d = [$t];
               }
            }
            $leftCnt--;
         }

      }

   }
 
   "".say;
   "Output:".say;
   $output.List.flat.join(", ").say;
}

sub verifyInput() { 

   my $data;
   my $lcnt = 0;
   my $dsz = 0;

   for $*IN.lines() -> $l { 
      my @d = $l.comb(/\d+/);
      if ( $dsz == 0 ) { $dsz = @d.elems; }
      if ( $dsz != @d.elems ) { die "Input must be in rectangular format."; }
      $data.push( @d );
      $lcnt++;
   }

   if ( $lcnt < 2 ) { die "there must be at least 2 lines of input."; }
   if ( $dsz < 2 ) { die "line length must be greater than 1."; }

   return $data;
}
