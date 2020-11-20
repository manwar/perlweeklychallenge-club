unit module MatInput;

class mat is export {

   has Int $.w;
   has Int $.h;;
   has Array @.rows;
   has Array @.cols;
   has Array @.boxes;

   method dispRows () {
      my $indx = 0;
      "Input:".say;
      for @!rows -> $r {
         "$indx \t\t $r".say;
         $indx++;
      }
      print "\n";
   }

   method dispCols () {
      for @!cols -> $c {
         $c.say;
      }
   }

   method getLargestBoxes() {

      my $errMsg = "no boxes found.";

      if ( @!boxes.elems > 0 ) { 
         my @b = @!boxes.sort( { my %h = %($_); %h{"area"} } ).reverse;
         my %l = %( @b[0] );
         my $largestArea = %l{"area"};

         if ( $largestArea >= 4 ) {

            for (@b) -> $b { 
               my %h = %($b);
               if ( %h{"area"} >= $largestArea ) {

                  "Output:".say;
                  %h.say;
                  for (0 .. $.h) -> $rh { 
                     print "$rh \t\t ";
                     for (0 .. $.w) -> $cw { 
                        my $vl = 0;
                        $vl = 1 if ( 
                           $cw >= %h{"col"} && $cw < %h{"col"} + %h{"width"} &&
                           $rh >= %h{"row"} && $rh < %h{"row"} + %h{"height"}
                        );
                        print "$vl ";
                     }
                     print "\n";
                  }
                  print "\n";
               }
            }

         } else {
            die $errMsg;
         }

      } else {
         die $errMsg;
      }

   }

   method !makeBoxes () {

      my %runs;
      my $indx = 0;
      for ( 0 .. $!h ) -> $r {
         my @row = @( @!rows[$r] );
         @row.join() ~~ m:ex/11+ { ## do this to try to find overlapping rectangles
            my $key = ($/.from, $/.chars).join(':');
            %runs{ $key }{ $indx }++;
         }/;
         $indx++;
      }

      ## find adjacent line runs
      my %adj;
      for %runs.keys -> $k {
         for ( 0 .. $!h ) -> $r {
            if ( %runs{$k}{$r}:exists ) {
               %adj{$k}{$r} = $r;
               if ( %adj{$k}{$r -1}:exists ) { 
                  %adj{$k}{$r} = (%adj{$k}{$r -1}, $r).join(":");
                  %adj{$k}{$r -1}:delete;
               }
            }
         }
      }
 
      ## make boxes
      for %adj.keys -> $ad {
         for %adj{$ad}.keys -> $adj {
            my @lines = %adj{$ad}{$adj}.split(/\:/);
            my $lineC = @lines.elems;
            if ( $lineC >1 ) {
               my ($pos, $len) = $ad.split(/\:/);
               my $area = $len * $lineC;

               @!boxes.push([
                  col => $pos, row => @lines[0],
                  width => $len, height => $lineC,
                  area => $area
               ]);
            }
         }
      }

   }

   method addData ( $in ) { 

      my $ccnt = 0;
      my $kcnt = 0;

      for $in.lines() -> $l {
         my @l = $l.comb.grep(/0|1/).map({ $_ +0});
         next if @l.elems < 2;
         if ( $kcnt == 0 ) {
            $kcnt = @l.elems;
            @!rows.push( (@l) );
            $ccnt++;
         } else {
            if ( @l.elems != $kcnt ) {
              die("Bad Input; input is meant to be rectangular in fashion.");
            }
            @!rows.push( (@l) );
            $ccnt++;
         }
      }

      die("bad input.") if ( $kcnt == 0 || $ccnt == 0 );
      $!w = $kcnt -1;
      $!h = $ccnt -1;

      for ( 0 .. ($!w) ) -> $col {
         for ( 0 .. ($!h) ) -> $row {
         #   @!rows[$row][$col].say;
            @.cols[$col].append( @!rows[$row][$col] );
         }
      }
      self!makeBoxes();
   }

}
