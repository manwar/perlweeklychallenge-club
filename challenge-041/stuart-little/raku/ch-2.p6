#!/usr/bin/env perl6
use v6;

say (1, 1, { $^a + $^b +1} ... *).[^20]

# run as <script>
