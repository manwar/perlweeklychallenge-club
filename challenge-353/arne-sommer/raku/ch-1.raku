#! /usr/bin/env raku

unit sub MAIN (*@sentences where @sentences.elems > 0);

@sentences>>.words>>.elems.max.say

