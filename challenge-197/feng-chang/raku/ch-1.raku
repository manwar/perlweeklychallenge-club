#!/bin/env raku

unit sub MAIN(*@N);

for +@N ^... 0 -> \j {
    @N.push(@N.splice(j, 1)) if @N[j] == 0;
}
put @N.join(', ');
