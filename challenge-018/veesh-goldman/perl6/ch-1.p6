#! /usr/bin/env perl6

sub MAIN ( *@strings where .elems > 1 ) {
  @strings.map( { m:ex/.+/>>.Str } ).reduce( { $^a ∩ $^b } ).keys.max(*.chars).say
}
