#!/usr/bin/env perl6

sub MAIN(Int $arg where $arg > 0) {
    1 .. Inf             ==> 
    map   { .fmt("%b") } ==> 
    first { $_ %% $arg } ==>
    say();
}
