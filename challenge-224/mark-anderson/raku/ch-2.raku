#!/usr/bin/raku
use Test;

ok  additive-number("112358"),              "1,2,2,3,5,8";
nok additive-number("12345"),               "No Solution";
ok  additive-number("199100199"),           "1,99,100,199";
ok  additive-number("4588321981458832199"), "458832198,1,458832199";
ok  additive-number("1321517324981130211"), "13,2,15,17,32,49,81,130,211";

# A few notes:

# I wish I knew how to write grammars.

# For some reason I can't get interpolation to work in my regexes 
# so I'm stuck with this hardcoded mess.

# This only works for up to 10 numbers. 

sub additive-number($n)
{
    return True if $n ~~ any 
    / ^ (\d+)(\d+)(\d+) $ <?{ $0 + $1 == $2 }> /,

    / ^ (\d+)(\d+)(\d+)(\d+) $ <?{ all $0 + $1 == $2,
                                       $1 + $2 == $3 }> /,

    / ^ (\d+)(\d+)(\d+)(\d+)(\d+) $ <?{ all $0 + $1 == $2,
                                            $1 + $2 == $3,
                                            $2 + $3 == $4 }> /,

    / ^ (\d+)(\d+)(\d+)(\d+)(\d+)(\d+) $ <?{ all $0 + $1 == $2, 
                                                 $1 + $2 == $3,
                                                 $2 + $3 == $4, 
                                                 $3 + $4 == $5 }> /,

    / ^ (\d+)(\d+)(\d+)(\d+)(\d+)(\d+)(\d+) $ <?{ all $0 + $1 == $2,
                                                      $1 + $2 == $3,
                                                      $2 + $3 == $4, 
                                                      $3 + $4 == $5, 
                                                      $4 + $5 == $6 }> /,

    / ^ (\d+)(\d+)(\d+)(\d+)(\d+)(\d+)(\d+)(\d+) $ <?{ all $0 + $1 == $2,
                                                           $1 + $2 == $3,
                                                           $2 + $3 == $4,
                                                           $3 + $4 == $5,
                                                           $4 + $5 == $6,
                                                           $5 + $6 == $7 }> /,
  
    / ^ (\d+)(\d+)(\d+)(\d+)(\d+)(\d+)(\d+)(\d+)(\d+) $ <?{ all $0 + $1 == $2,
                                                                $1 + $2 == $3, 
                                                                $2 + $3 == $4, 
                                                                $3 + $4 == $5, 
                                                                $4 + $5 == $6,
                                                                $5 + $6 == $7, 
                                                                $6 + $7 == $8 }> /,
 
    / ^ (\d+)(\d+)(\d+)(\d+)(\d+)(\d+)(\d+)(\d+)(\d+)(\d+) $ <?{ all $0 + $1 == $2, 
                                                                     $1 + $2 == $3, 
                                                                     $2 + $3 == $4,
                                                                     $3 + $4 == $5,
                                                                     $4 + $5 == $6,
                                                                     $5 + $6 == $7, 
                                                                     $6 + $7 == $8, 
                                                                     $7 + $8 == $9 }> /;

    return False
}
