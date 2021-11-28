#!/bin/env raku

put (1900..2100)
    .grep({ Date("$_-12-31").week[1] == 53 })
    .rotor(5, :partial)
    .map({ $_.join(', ') })
    .join(",\n");
