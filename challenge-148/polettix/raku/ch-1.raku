#!/usr/bin/env raku
use v6;
use Lingua::EN::Numbers;
sub MAIN (Int:D $max = 100) { ebans-upto($max)».put }
sub ebans-upto (Int:D $max) { (^$max).grep({cardinal($_) !~~ /:i e/}) }
