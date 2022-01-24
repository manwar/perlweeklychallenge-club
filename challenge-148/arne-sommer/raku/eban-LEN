#! /usr/bin/env raku

use Lingua::EN::Numbers;

unit sub MAIN (Int $limit = 100);

(1 .. $limit).grep( { ! cardinal($_).contains('e') } ).join(", ").say;
