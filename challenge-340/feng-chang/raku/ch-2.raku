#!/bin/env raku

unit sub MAIN(Str:D $msg);

put so [<] $msg.comb(/\d+/);
