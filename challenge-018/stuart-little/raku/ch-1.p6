#!/usr/bin/env perl6
use v6;

say (0..( my $minword=@*ARGS.min(*.chars); $minword.chars ).[1]).combinations(2).map({ $minword.substr($_[0]..^$_[1]) }).grep({ @*ARGS.all.contains($_) }).max(*.chars)

# run as <script> <space-separated strings, each enclosed in quotes if it contains spaces>
