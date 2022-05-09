#!/bin/env raku

unit sub MAIN(*@n);

@n = [\+] @n[1..*] while @n > 1;
put @n[0];
