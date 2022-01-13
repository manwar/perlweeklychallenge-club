#!/usr/bin/env raku

# Print the 10001st prime
(1..*).grep(*.is-prime)[10000].say;
