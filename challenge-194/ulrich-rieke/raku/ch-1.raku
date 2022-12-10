use v6 ;

say "Enter a time in the format hh::mm , with one missing digit replaced by '?'!" ;
my $time = $*IN.get ;
my $hour_regex = / 0 <[0..9]> || 1 <[0..9]> || 2 <[0..3]> / ;
my $minutes_regex = /<[0..5]> <[0..9]>/ ;
my $pos = $time.index( '?' ) ;
my $digit = 10 ;
repeat {
  $digit-- ;
  if ( $time !~~ /'?'/ ) { #we keep looking for '?', so we must re-insert it
                            #if there was no valid match
      $time.substr-rw( $pos , 1 ) = '?' ;
  }
  $time ~~ s/'?'/$digit/ ;
} until ( $time ~~ /^<$hour_regex> ':' <$minutes_regex> $/ ) ;
say $digit ;
