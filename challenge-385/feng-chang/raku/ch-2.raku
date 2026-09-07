#!/bin/env raku

unit sub MAIN(Str:D $str);

grammar Parens { rule TOP { '(' ~ ')' <TOP>* } }

put $str.subst(/<Parens::TOP>/, { .Str.substr(1, .chars-2) }, :g);
