#!/usr/bin/env raku
use Test;

is ASCII-Art(200), chomp q:to/END/;
                    -----   -----   ----- 
                         | |     | |     |
                         | |     | |     |
                    -----  |     | |     |
                   |       |     | |     |
                   |       |     | |     |
                    -----   -----   ----- 
                   END

is ASCII-Art(5280), chomp q:to/END/;
                     -----   -----   -----   ----- 
                    |             | |     | |     |
                    |             | |     | |     |
                     -----   -----   -----  |     |
                          | |       |     | |     |
                          | |       |     | |     |
                     -----   -----   -----   ----- 
                    END

sub ASCII-Art($n)
{
    my @digits = 
    [
       (chomp q:to/END/).split("\n").Array,
         ----- 
        |     |
        |     |
        |     |
        |     |
        |     |
         ----- 
        END
         
       (chomp q:to/END/).split("\n").Array,
              -
              |
              |
              |
              |
              |
              -
        END
    
       (chomp q:to/END/).split("\n").Array,
         ----- 
              |
              |
         ----- 
        |      
        |      
         ----- 
        END
    
       (chomp q:to/END/).split("\n").Array,
         ----- 
              |
              |
         ----- 
              |
              |
         ----- 
        END
    
       (chomp q:to/END/).split("\n").Array,
        -     -
        |     |
        |     |
         ----- 
              |
              |
              -
        END
    
       (chomp q:to/END/).split("\n").Array,
         ----- 
        |      
        |      
         ----- 
              |
              |
         ----- 
        END
    
       (chomp q:to/END/).split("\n").Array,
         ----- 
        |      
        |      
         ----- 
        |     |
        |     |
         ----- 
        END
    
       (chomp q:to/END/).split("\n").Array,
         ----- 
              |
              |
              |
              |
              |
              -
        END
    
       (chomp q:to/END/).split("\n").Array,
         ----- 
        |     |
        |     |
         ----- 
        |     |
        |     |
         ----- 
        END
    
       (chomp q:to/END/).split("\n").Array
         ----- 
        |     |
        |     |
         ----- 
              |
              |
         ----- 
        END
    ];

    ([Z] @digits[$n.comb]).join("\n")
}
