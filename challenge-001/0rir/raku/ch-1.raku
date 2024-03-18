#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉ ≡ ≢ «␤ » ∴
use v6;

=begin comment
001-1
Write a script to replace the character ‘e’ with ‘E’ in the string ‘Perl Weekly Challenge’. Also print the number of times the character ‘e’ is found in the string.
=end comment

my @Test =
   'Perl Weekly Challenge', 'PErl WEEkly ChallEngE', 5,
;

plan @Test ÷ 2;

sub func( $a -->Array) {
    my @ret;
    $_ = $a;
    @ret.push:  .subst: 'e', 'E', :g ;
    @ret.push:  + .comb.grep( 'e');
    @ret;
}

my @result = func @Test[0];
say  "Input:  @Test[0]\nXlated: @result[0]\n 'e' count: @result[1]\n";

