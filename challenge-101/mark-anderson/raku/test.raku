#!/usr/bin/env raku

say tightest-factor(99);

sub tightest-factor($n) 
{
    .tail given gather take $n div $_ if $n %% $_ for 1..sqrt($n); 
    
}
