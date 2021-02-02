#!/usr/bin/env raku
use Test;
plan 3;

is readN("input.txt", 4), "1234";
is readN("input.txt", 4), "5678";
is readN("input.txt", 4), "90";

sub readN($FILE, $number) 
{
    my $fh = open $FILE, :r;
    my $head = $fh.readchars: $number;
    my $tail = $fh.slurp;
    $fh.close;
    $FILE.IO.spurt: $tail;
    return $head;
}
