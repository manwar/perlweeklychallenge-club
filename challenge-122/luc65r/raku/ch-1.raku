#!/usr/bin/env raku

unit sub MAIN(*@n);

.say for ([\+] @n) »/» (1..∞);
