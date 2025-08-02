use v6 ;

say "Enter some integers, separated by blanks!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
my $element_sum = [+] @numbers ;
my $digit_sum = [+] @numbers.map( {[+] $_.Str.comb.map( {.Int} )} ) ;
say abs( $element_sum - $digit_sum ) ;
