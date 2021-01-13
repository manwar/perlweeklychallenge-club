#!/usr/bin/env perl6
use v6;

# run as <script> <binary Polish-notation operation, e.g. '+ 2 3' or '/ 5 6'; escape or quote '*' so it doesn't get captured by the shell>

my %ops=(
    '+' => &[+],
    '-' => &[-],
    '*' => &[*],
    '/' => &[/],
);

say %ops.{@*ARGS[0]}(|@*ARGS[1,2]);
