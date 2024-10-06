#!/usr/bin/env perl
# Perl weekly challenge 289
# Task 2:  Jumbled Letters
#
# See https://wlmb.github.io/2024/09/29/PWC289/#task-2-jumbled-letters
use v5.36;
$/=undef; # slurp
sub randomize($string){
    my $randomized="";
    $randomized.=substr $string, (rand length $string), 1, "" while length $string;
    $randomized
}
for(<>){
    my $original=$_;
    s/(\w)(\w*)(\w)/$1.(randomize $2).$3/mge;
    say "$original->\n$_";
}
