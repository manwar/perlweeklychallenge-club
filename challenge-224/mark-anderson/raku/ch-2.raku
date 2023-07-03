#!/usr/bin/raku
use Test;

ok  additive-number("112358");
nok additive-number("12345");
ok  additive-number("199100199");
ok  additive-number("1458832198458832199");
ok  additive-number("1321517324981130211");

# A few notes:

# I wish I knew how to write grammars.

# For some reason I can't get interpolation to work in my regexes 
# so I'm stuck with this hardcoded mess.

# This only works for up to 10 numbers. 

sub additive-number($n)
{
    return True if $n ~~ 
    / ^ (\d+)(\d+)(\d+) $ <?{ $0 + $1 == $2 }> /;

    return True if $n ~~ 
    / ^ (\d+)(\d+)(\d+)(\d+) $ <?{ $0 + $1 == $2 and
                                   $1 + $2 == $3 }> /;

    return True if $n ~~ 
    / ^ (\d+)(\d+)(\d+)(\d+)(\d+) $ <?{ $0 + $1 == $2 and
                                        $1 + $2 == $3 and
                                        $2 + $3 == $4 }> /;

    return True if $n ~~ 
    / ^ (\d+)(\d+)(\d+)(\d+)(\d+)(\d+) $ <?{ $0 + $1 == $2 and
                                             $1 + $2 == $3 and
                                             $2 + $3 == $4 and
                                             $3 + $4 == $5 }> /;

    return True if $n ~~ 
    / ^ (\d+)(\d+)(\d+)(\d+)(\d+)(\d+)(\d+) $ <?{ $0 + $1 == $2 and
                                                  $1 + $2 == $3 and
                                                  $2 + $3 == $4 and
                                                  $3 + $4 == $5 and
                                                  $4 + $5 == $6 }> /;

    return True if $n ~~ 
    / ^ (\d+)(\d+)(\d+)(\d+)(\d+)(\d+)(\d+)(\d+) $ <?{ $0 + $1 == $2 and
                                                       $1 + $2 == $3 and
                                                       $2 + $3 == $4 and
                                                       $3 + $4 == $5 and
                                                       $4 + $5 == $6 and
                                                       $5 + $6 == $7 }> /;
  
    return True if $n ~~ 
    / ^ (\d+)(\d+)(\d+)(\d+)(\d+)(\d+)(\d+)(\d+)(\d+) $ <?{ $0 + $1 == $2 and
                                                            $1 + $2 == $3 and
                                                            $2 + $3 == $4 and
                                                            $3 + $4 == $5 and
                                                            $4 + $5 == $6 and
                                                            $5 + $6 == $7 and
                                                            $6 + $7 == $8 }> /;
 
    return True if $n ~~ 
    / ^ (\d+)(\d+)(\d+)(\d+)(\d+)(\d+)(\d+)(\d+)(\d+)(\d+) $ 
                                                        <?{ $0 + $1 == $2 and
                                                            $1 + $2 == $3 and
                                                            $2 + $3 == $4 and
                                                            $3 + $4 == $5 and
                                                            $4 + $5 == $6 and
                                                            $5 + $6 == $7 and
                                                            $6 + $7 == $8 and
                                                            $7 + $8 == $9 }> /;

    return False
}
