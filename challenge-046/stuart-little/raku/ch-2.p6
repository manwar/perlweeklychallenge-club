#!/usr/bin/env perl6
use v6;

# run as <script>

say (1..500).grep({ $_.sqrt.floor ** 2 == $_ })
