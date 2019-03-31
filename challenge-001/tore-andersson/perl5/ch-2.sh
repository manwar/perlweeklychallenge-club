perl -E '$,=","; say map { (join " ", grep { $_ } $_ % 3 ? 0 : "fizz", $_ % 5 ? 0 : "buzz") || $_ } 1 .. 20';

perl -E 'say for map { (join " ", grep { $_ } $_ % 3 ? 0 : "fizz", $_ % 5 ? 0 : "buzz") || $_ } 1 .. 20';
