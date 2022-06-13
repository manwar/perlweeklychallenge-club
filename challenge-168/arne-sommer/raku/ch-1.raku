#! /usr/bin/env raku

unit sub MAIN (Int :c(:$count) where $count > 1 = 13);

my $pp := ( 3, 0, 2, ( * + * + * * 0 ) ... Inf).unique.grep( *.is-prime );

say $pp[^$count].sort.join(", ");
