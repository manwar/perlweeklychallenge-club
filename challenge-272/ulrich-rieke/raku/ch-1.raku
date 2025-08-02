use v6 ;

say "Enter a valid IPv4 address!" ;
my $address = $*IN.get ;
$address ~~ s:g['.'] = "[.]" ;
say $address ;
