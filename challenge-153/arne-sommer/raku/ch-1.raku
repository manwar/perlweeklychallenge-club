#! /usr/bin/env raku

unit sub MAIN (:c(:$count) = 10);

my $lf := ( $ = 1, ( * + ([*] 1 .. ++$) ) ... Inf );

say $lf[^$count].join(", ");
