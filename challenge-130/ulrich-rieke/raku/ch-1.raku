use v6 ;

say "Enter numbers divided by spaces!" ;
my $line = $*IN.get ;
while ( $line !~~ /(\d?)+ % ' '/ ) {
  say "Enter only integers divided by spaces!" ;
  $line = $*IN.get ;
}
my @array = $line.split( /\s/ ) ;
my %numcount ;
@array.map( {%numcount{ $_ }++} ) ;
say %numcount.keys.grep( { not %numcount{$_} %% 2 } )[0] ;
