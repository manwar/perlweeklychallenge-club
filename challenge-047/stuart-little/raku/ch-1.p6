#!/usr/bin/env perl6
use v6;
use MONKEY-SEE-NO-EVAL;
use Roman:from<Perl5>;

say EVAL @*ARGS.map({ (isroman($_)) ?? (arabic($_)) !! ($_) }).join(" ")
