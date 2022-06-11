#! /usr/bin/env raku

unit sub MAIN ($limit = 1000);

(1 ..^ $limit).grep( *.is-prime ).grep({ $_ eq $_.flip }).join(", ").say;
