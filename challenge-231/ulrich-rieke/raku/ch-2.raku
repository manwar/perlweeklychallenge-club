use v6 ;

say "Enter some tickets , separated by blanks!" ;
#we assume all ticket numbers to be in the right format
my $line = $*IN.get ;
my @tickets = $line.words ;
say @tickets.grep( {$_.substr( 11 , 2 ).Int >= 60} ).elems ;
