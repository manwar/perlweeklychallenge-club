use v6 ;

sub MAIN( Int $from , Int $to, Str $file ) {
  my @playtimes ;
  my @titles ;
  for $file.IO.lines -> $line {
      my ($playtime, $title ) = $line.split( /','/ ) ;
      @playtimes.push( $playtime ) ;
      @titles.push( $title ) ;
  }
  my $timediff = ($to - $from) * 1000 ; #in milliseconds
  my $totalplaytime = [+] @playtimes ;
  my $playcycles = $timediff div $totalplaytime ;
  my $remainder = $timediff - $playcycles * $totalplaytime ;
  my $sumtime = 0 ;
  my $i = 0 ;
  $sumtime += @playtimes[ $i ] ;
  while ( $sumtime < $remainder ) {
      $i++ ;
      $sumtime += @playtimes[ $i ] ;
  }
  say @titles[ $i ] ;
}
