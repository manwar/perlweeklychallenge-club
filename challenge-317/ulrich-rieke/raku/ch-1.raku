use v6 ;

say "Enter some words separated by whitespace!" ;
my $line = $*IN.get ;
my @words = $line.words ;
say "Enter another word!" ;
my $otherWord = $*IN.get ;
my $firstLetters ;
@words.map( {$firstLetters ~= $_.substr( 0 , 1 )} ) ;
say $firstLetters eq $otherWord ;
