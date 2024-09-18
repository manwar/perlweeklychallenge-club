use v6 ;

say "Enter a string!" ;
my $string = $*IN.get ;
my regex sign { <[- +]> } ;
my regex expo { <[e E]> <sign>? \d+ } ;
my regex integer { <sign>? \d+ <expo>?} ;
my regex decimal { <sign>? \d+ \. <expo>? | <sign>? \d+ \. \d+ <expo>? | 
   <sign>? \. \d+ <expo>? } ;
my regex valid {^ <integer> $ | ^ <decimal> $} ;
if ( $string ~~ / <valid> / ) {
   say "true" ;
}
else {
   say "false" ;
}
