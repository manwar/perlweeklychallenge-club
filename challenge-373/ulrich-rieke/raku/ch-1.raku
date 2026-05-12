use v6 ;

say "Enter some strings separated by blanks!" ;
my $firstline = $*IN.get ;
say "Enter some more strings separated by blanks!" ;
my $secondline = $*IN.get ;
$firstline ~~ s:g/\s// ;
$secondline ~~ s:g/\s// ;
say $firstline eq $secondline ;
