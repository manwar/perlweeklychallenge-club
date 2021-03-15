#!/usr/bin/env perl6
use v6;

# run <script> <space-separated strings>

use Text::Levenshtein;

say distance(|@*ARGS[0,1]);
