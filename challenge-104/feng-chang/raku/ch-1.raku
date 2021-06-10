#!/bin/env raku

multi fusc(0) { 0 }
multi fusc(1) { 1 }

multi fusc(UInt:D \n where n > 0 && n %% 2)
{ fusc((n/2).UInt) }

multi fusc(UInt:D \n where * > 0)
{ fusc(((n-1)/2).UInt) + fusc(((n+1)/2).UInt) }

put (0..49)».&fusc.join(' ');
