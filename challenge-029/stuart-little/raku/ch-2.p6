#!/usr/bin/env perl6
use v6;

# run as <script> <string>

use NativeCall;

sub c_strlen(Str $str) returns int32 is native('c') is symbol('strlen') {*}

say c_strlen(@*ARGS[0]);
