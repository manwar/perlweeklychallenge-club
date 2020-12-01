#!/usr/bin/env perl6
use v6;

([\*] (2..*).grep(*.is-prime)).map(*+1).first(! *.is-prime).say

# run as <script>
