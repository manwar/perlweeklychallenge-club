#!/bin/env raku

unit sub MAIN(*@words);

put @words.map({ ~.[1] => ~.[0] with .match(/(\D+)(\d+)/) }).Hash.sort(+*.key)».value.join(' ');
