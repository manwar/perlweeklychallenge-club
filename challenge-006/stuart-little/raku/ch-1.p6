#!/usr/bin/env perl6
use v6;

# run as <script> <space-separated list entries>

sub compactify(@a) {
    S:g/\D*\-\D*/-/ with @a.sort.unique.map({ (($_-1,$_,$_+1).all == @a.any) ?? '-' !! $_ }).join(',')
}

say @*ARGS.map(*.Int).&compactify
