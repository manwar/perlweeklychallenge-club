#!/usr/bin/env raku
use Test;

is valid-times("?2:34"),  3;
is valid-times("?4:?0"),  12;
is valid-times("??:??"),  1440;
is valid-times("?3:45"),  3;
is valid-times("2?:15"),  4;

sub valid-times($time)
{
    grammar G
    {
        token TOP {  <HH> ':' <MM>  }
        token HH  {
                      || \d      \d       { make 1  }
                      || <[01]>  '?'      { make 10 }
                      ||  2      '?'      { make 4  }
                      || '?'     <[4..9]> { make 2  }
                      || '?'     <[0..3]> { make 3  }
                      || '?'     '?'      { make 24 }
                  }
        token MM  {  
                      || \d      \d       { make 1  }
                      || \d      '?'      { make 10 } 
                      || '?'     \d       { make 6  }
                      || '?'     '?'      { make 60 }
                  }
    } 

    [*] G.parse($time)<HH MM>>>.made
}
