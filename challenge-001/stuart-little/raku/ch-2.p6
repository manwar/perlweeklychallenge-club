#!/usr/bin/env perl6
use v6;

(1..20).map({ (($_ %% 3) && 'fizz' || '') ~ (($_ %% 5) && 'buzz' || '') || $_ }).say

# run as <script>
