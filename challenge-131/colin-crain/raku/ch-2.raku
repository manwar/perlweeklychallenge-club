#!/usr/bin/env perl6
#
#
#       .raku
#
#
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN ( $delimiters = q|**//<>|, 
                $input      = q|/* This is a comment (in some languages) */ <could be a tag>|
               ) ;

my  (%delim, %chars);

for $delimiters.comb.rotor(2) -> ($o, $c) {    
    %delim<o>{$o} = %delim<c>{$c} = True;
}

for  "o", "c" -> $dtype {
    %chars{$dtype} = $input.comb
                           .grep( {%delim{$dtype}{$_}:exists} )
                           .join ;
}

say qq:to/END/;
    input       $input
    delimiters  $delimiters
    
    opens   {%chars<o>}
    closes  {%chars<c>}
    END





