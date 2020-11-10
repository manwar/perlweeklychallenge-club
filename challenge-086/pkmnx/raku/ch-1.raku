#!/usr/bin/env rakudo

sub MAIN( *@args where @args.all ~~ Int ) {

   my $A = @args.pop();
   my @N = @args;

   my @res = (gather {
      my %h;
      for @N.permutations {
         %h{ $_[0] }{ $_[1] }++;
      }
      for %h.keys -> $k {
         for %h{$k}.keys -> $kk {
            take [ $k, $kk ] if $k - $kk == $A;
         }
      }
   });

   ( "Input: @N = (" ~ @N ~ ') and $A = ' ~ $A ).say;

   if ( @res.elems > 0 ) {
      "Output: 1 as".say;
      for (@res) -> ($f, $s) {
         "   $f - $s = $A".say;
      }
      exit(0);
   } else {
      "Output: 0".say;
      exit(1);
   }
    
}
