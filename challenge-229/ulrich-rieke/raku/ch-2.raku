use v6 ;

say "Enter 3 lines of numbers, separated by blanks!" ;
say "First line!" ;
my $line = $*IN.get ;
my $set1 = set( $line.words.map( {.Int} )) ;
say "Second line!" ;
$line = $*IN.get ;
my $set2 = set( $line.words.map( {.Int} ) ) ;
say "Third line!" ;
$line = $*IN.get ;
my $set3 = set( $line.words.map( {.Int} ) ) ;
my $first_intersect = $set1 (&) $set2 ;
my $second_intersect = $set2 (&) $set3 ;
my $third_intersect = $set1 (&) $set3 ;
my $union = $first_intersect (|) $second_intersect ;
$union = $union (|) $third_intersect ;
say $union.keys.sort ;
