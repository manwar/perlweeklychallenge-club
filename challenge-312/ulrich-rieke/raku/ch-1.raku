use v6 ;

say "Enter an English word with letters a to z!" ;
my $word = $*IN.get ;
my @pairs = ('a'..'z') Z, (1..26) ;
my %letterset ;
for @pairs -> $p {
   %letterset{$p[0]} = $p[1] ;
}
my $seconds = 0 ;
#tag every letter with a number from 1 to 26!
#then the seconds we look for is the sum of the minimum pairwise
#differences ( either clockwise or counterclockwise ) + the length
#of the original word
unless ( $word.substr( 0 , 1 ) eq "a" ) {
   my $number = %letterset{ $word.substr( 0 , 1 ) } ;
   my $onedir_diff = ( $number - 1 ).abs ;
   my $otherdir_diff = 26 - $onedir_diff ;
   my $diff = ($onedir_diff , $otherdir_diff).min ;
   $seconds += $diff ;
}
my $len = $word.chars ;
for ( 0..$len - 2 ) -> $pos {
   my $firstchar = $word.substr( $pos , 1 ) ;
   my $secondchar = $word.substr( $pos + 1 , 1 ) ;
   my $firstnum = %letterset{ $firstchar } ;
   my $secondnum = %letterset{ $secondchar } ;
   my $onedir_diff = ($firstnum - $secondnum).abs ;
   my $otherdir_diff = 26 - $onedir_diff ;
   my $diff = ($onedir_diff , $otherdir_diff).min ;
   $seconds += $diff ;
}
$seconds += $len ;
$seconds.say ;

