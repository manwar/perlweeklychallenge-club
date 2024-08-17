use v6 ;

say "Enter a string!" ;
my $line = $*IN.get ;
my @vowels = "aeiouAEIOU".comb ;
say $line.comb.grep( {$_ (elem) @vowels} ).elems %% 2 ;
