#!/usr/bin/env rakudo

# input is an 81 len string that rep's a puzzle like:
#
#  000260701680070090190004500820100040004602900050003028009300074040050036703018000
#    takes my box about 1 sec.
#  306508400520000000087000031003010080900863005050090600130000250000000074005206300
#    takes my box about 10 secs.
#  002000500000003072001000004080090700006740000107030400005008900060400158920560300
#    takes my box about 1 min.
#  063000008908500000000070000000004500830050090009610000050030460000000000200100030
#    takes my box about 25 mins.

sub MAIN() {

   my @pz = ( lines[0].chomp().comb ).grep({ /\d/ });
   die( "input should be 81 numbers, representing sudoku puzzle." ) if @pz.elems != 81;

   my $absCnt = 0;
   my %seen = ();
   my %nonpresumshash = ();
   my %rciHash = ();
   my @stack = ();
   @stack.append( makeSdkuObj(@pz) );

   while ( @stack && my %h = @stack.pop() ) {

      ## sort groups by 0 cnt;
      my @srtgr = %h{'g'}.kv.map(-> $k, $v {[ $k, @($v).grep({/0/}).elems ]} ).sort({$^a[1] <=> $^b[1]});

      ## take non zero ones;
      my @nsrtgr = @srtgr.grep({$_[1] > 0});

      next if @nsrtgr.elems == 0;

      ## find head group w/ small num of 0s
      my $hdg = @nsrtgr.head.[0];
      my @gr = @(%h{'g'}{$hdg});

      ## find nums not present in group
      my %gr = %( @gr.grep({!/0/}).map({$_ => 1}) );
      my @nonpresnums = (1 .. 9).grep( { %gr{$_}:!exists });
      my $nonpresums = @nonpresnums.join("");

      ## match all permutations into zeroes into group
      my @allperms = ();

      ## cache
      if ( %nonpresumshash{$nonpresums}:exists ) {
         @allperms = @( %nonpresumshash{$nonpresums} )[0];
      } else {
         for ( @nonpresnums.permutations ) -> $p {
            my @p = @($p);
            my @np;
            for ( @gr ) -> $it {
               my $vl = $it;
               if ( $it == 0 ) {
                  $vl = @p.shift 
               } else {
                  $vl = 0;
               }
               @np.append($vl +0);
            }
            push @allperms, item @np;
         }
         %nonpresumshash{$nonpresums} = \(@allperms);
      }

      ## for all permutations check which ones are valid
      for ( @allperms ) -> $p {

         my @newD = %h{'d'}.clone;

         my @p = @($p);

         my $existCnt = 0;
         for ( 0 .. 8 ) -> $ji {
            my $n = @p[$ji];
            if ( $n != 0 ) {

               my $roww;
               my $coll;
               my $indx;
 
               ## cache
               if ( %rciHash{$hdg}{$ji} ) {
                  ($roww, $coll, $indx ) = @( %rciHash{$hdg}{$ji} );
               } else {
                  $roww = (floor(Int($hdg)/3)*3) + floor(Int($ji)/3);
                  $coll = (($hdg%3) *3)          + ($ji%3);
                  $indx = ($roww * 9)            + $coll;
                  %rciHash{$hdg}{$ji} =          [ $roww, $coll, $indx ];
               }

               $existCnt++ if ( %h{'rh'}{$roww}{$n}:exists );
               $existCnt++ if ( %h{'ch'}{$coll}{$n}:exists );
               last if $existCnt >0;
               @newD[$indx] = $n;
            }
         }

         if ( $existCnt >0 ) {
            ## nothing
         } else {
            if ( @newD.grep(/0/) ) {
            #  display(@newD);
               my $newD = @newD.join("");
               if ( %seen{$newD}:!exists ) {
                  @stack.append( makeSdkuObj(@newD) );
                  %seen{$newD}++;
                  $absCnt++;
               }
            } else {
               display(@newD);
               exit(0);
            }
         }

         @newD = Nil;

      } ## end for @allperms
   }
}

sub display( @pz ) {
   for 0 .. (@pz.elems -1) -> $in {
      say "" if $in %% 9 && $in > 0;
      print @pz[$in];
   }
   print "\n\n";
}

sub makeSdkuObj( @pz ) {

   my %h;

   my $r = 0;
   my $cl = 0;
   my $g = 0;
   my $gr = 0;

   ## manips to get sdku vals into rows, cols & groups
   for ( 0 .. @pz.elems -1 ) -> $i {

      my $c = @pz[$i];

      if ( $i %% 9 ) {
         $r++;
         $cl = 0;
         $g = 0;
      }

      if ( $i %% 27 ) { $gr++; }
      if ( $i %% 3  ) { $g++; }

      %h{'r'}{ $r -1                     }.append($c);
      %h{'c'}{ $cl                       }.append($c);

      if ( $c != 0 ) {
         %h{'rh'}{ $r -1 }{ $c +0 }++;
         %h{'ch'}{ $cl   }{ $c +0 }++;
      }

      $cl++;

      %h{'g'}{ (($gr -1) *3) + ($g -1)   }.append($c);
      %h{'d'}.append($c);
  }

  return \(%h);

}
