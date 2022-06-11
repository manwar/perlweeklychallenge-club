#! /usr/bin/env raku

unit sub MAIN (:c(:$count) = 10);

my $pp := ( 1, 1, 1, ( * + * + * * 0 ) ... Inf).squish.map({ .is-prime ?? $_ !! next; });

say $pp[^$count].join(", ");
