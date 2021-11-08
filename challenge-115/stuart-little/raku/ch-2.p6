#!/usr/bin/env perl6
use v6;

# run <script> <space-separated digits>

my $attemptedOut = S/(.)(<[13579]>*)$/$1$0/ with @*ARGS.sort({ $^b leg $^a }).join("");
say(($attemptedOut ~~ m/<[02468]>$/) ?? ($attemptedOut) !! ("No even digits.."));

