#!/usr/bin/env perl6
use v6;

(100..*).grep({ $_ %% ($_.comb[0] ~ ($_ % 10)).Int }).[0..^20].say

# run as <script>
