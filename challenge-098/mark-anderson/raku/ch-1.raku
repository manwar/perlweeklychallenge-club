#!/usr/bin/env raku
use Test;
plan 3;

is readN("input.txt", 4), "1234";
is readN("input.txt", 4), "5678";
is readN("input.txt", 4), "90";

sub readN($FILE, $number) 
{
    state %fh;
    %fh{$FILE} = open $FILE unless %fh{$FILE};
    %fh{$FILE}.readchars: $number;
}
