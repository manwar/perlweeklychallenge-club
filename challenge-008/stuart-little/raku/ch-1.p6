#!/usr/bin/env perl6
use v6;

say (1,2,4,8 ... *).grep({ ($_-1).is-prime }).head(5).map({ ($_ div 2)*($_-1) })

# run as <script>
