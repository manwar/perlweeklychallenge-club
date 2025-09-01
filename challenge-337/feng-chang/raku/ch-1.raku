#!/bin/env raku

unit sub MAIN(*@num1);

put @num1.map({ @num1.sort.first($_, :k) });
