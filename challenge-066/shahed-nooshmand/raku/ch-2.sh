raku -e 'say .key ~ .value.comb.map: {(8304, 185, 178, 179, |(8308..8313))».chr[$_]} for (2..$N.sqrt).map({$_ => $N.log: $_}).grep: {.value == .value.floor}'
