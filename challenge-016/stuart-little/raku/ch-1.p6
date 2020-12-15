#!/usr/bin/env perl6
use v6;

say ((my $top=(1..*).first({ ($_+1)*($_+2) div 2 > 100})) > 100-$top*($top+1)/2 ) ?? $top !! $top-1

# run as <script>
