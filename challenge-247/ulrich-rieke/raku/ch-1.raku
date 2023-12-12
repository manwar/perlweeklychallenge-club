use v6 ;

say "Enter a list of receivers, separated by a ',' !" ;
my $line = $*IN.get ;
my @receivers_old = $line.split( ',' ) ;
my @receivers ; #who gets gifts ?
for @receivers_old -> $name {
   if ( $name ~~ /^ (\s*) (\S+) (\s+) (\S+) (\s*) $/ ) {
      my $newname = ( ~$1 ~ " " ~ ~$3 ) ; #weed out empty spaces at the 
#beginning and the end of the name
      @receivers.push( $newname ) ;
   }
}
my @givers = @receivers ;
my $strict = True ; #only different family names are allowed
my %frequencies ; #count the occurrences of family names
for @receivers -> $name {
   my @nameparts = $name.split( /\s+/ ) ;
   my $surname = @nameparts[ *-1 ] ;
   %frequencies{$surname}++ ;
}
#if more than a half of all receivers share the same second name we 
#loosen our strictness criteria and allow the same family name
if ( %frequencies.keys.grep( { %frequencies{$_} >= ( @receivers.elems 
	    div 2 ) } ).elems > 0 ) {
   $strict = False ;
}
#keep randomly selecting a giver and a receiver! If we are under 
#"strict" , the second names have to differ, otherwise they can be
#identical. If the conditions are fulfilled, we delete the respective
#giver and receiver from the array.
my $len = @receivers.elems ;
my %christmas_pairs ;
while ( $len > 0 ) {
   my $giver_index = (0..$len - 1 ).pick( 1 )[0] ;
   my $receiver_index = (0..$len - 1 ).pick( 1 )[0] ;
   my $giver = @givers[ $giver_index ] ;
   my $receiver = @receivers[ $receiver_index ] ;
   if ( $strict ) { #second names must differ
      my $giver_surname ;
      my $receiver_surname ;
      my @nameparts = $giver.split( /\s+/ ) ;
      $giver_surname = @nameparts[*-1] ;
      @nameparts = $receiver.split( /\s+/ ) ;
      $receiver_surname = @nameparts[*-1] ;
      while ( $giver_surname eq $receiver_surname ) {
	 $giver_index = (0..$len - 1 ).pick( 1 )[0] ;
	 $receiver_index = (0..$len - 1 ).pick( 1 )[0] ;
	 $giver = @givers[ $giver_index ] ;
	 $receiver = @receivers[ $receiver_index ] ;
	 @nameparts = $giver.split( /\s+/ ) ;
	 $giver_surname = @nameparts[*-1] ;
	 @nameparts = $receiver.split( /\s+/ ) ;
	 $receiver_surname = @nameparts[ *-1] ;
      }
   }
   else { #second names can be the same, but you should not give a present
#to yourself...
      while ( $giver eq $receiver ) {
	 $giver_index = (0..$len - 1 ).pick( 1 )[0] ;
	 $receiver_index = (0..$len - 1).pick( 1 )[0] ;
	 $giver = @givers[ $giver_index ] ;
	 $receiver = @receivers[ $receiver_index ] ;
      }
   }
   %christmas_pairs{ $giver } = $receiver ;
   @givers.splice( $giver_index , 1 ) ;
   @receivers.splice( $receiver_index , 1 ) ;
   $len-- ;
}
for %christmas_pairs.keys -> $aGiver {
   say "$aGiver -> %christmas_pairs{ $aGiver }" ;
}
