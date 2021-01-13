#!/usr/bin/env perl6
use v6;
use Roman:from<Perl5>;

# run as <script> <number to convert, roman or arabic; the script will detect which conversion to make>

say (@*ARGS[0].&isroman) ?? (arabic(@*ARGS[0])) !! (roman(@*ARGS[0]))
