#!/bin/env raku

unit sub MAIN(*@people);

my %plan;
repeat {
    %plan = @people Z=> @people.pick(*);
} until %plan.map({ family-name(.key) ne family-name(.value) }).all;
put "{.key.fmt('%-10s')} -> {.value}" for %plan;

sub family-name(\name_) { name_.words.tail }
