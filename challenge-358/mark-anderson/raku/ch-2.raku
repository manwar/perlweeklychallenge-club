#!/usr/bin/env raku
use Test;
plan 5;

is encrypt-string('abc',    1), 'bcd';
is encrypt-string('xyz',    2), 'zab';
is encrypt-string('abc',   27), 'bcd';
is encrypt-string('hello',  5), 'mjqqt';
is encrypt-string('perl',  26), 'perl';

sub encrypt-string($str, $int)
{
    my  @a = ['a'..'z'].rotate($int);
    [~] @a[$str.ords >>->> 97]
}
