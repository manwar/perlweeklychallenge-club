use v6 ;

my $code = "Challenge286.raku".IO.slurp ;
my @words = $code.words ;
say @words.pick ;
