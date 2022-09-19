#!/usr/bin/perl
use strict; use warnings; use v5.10;
use Math::Prime::Util 'forpart', 'is_prime';
use List::Util 'any', 'uniq';

my($m, $n) = @ARGV;
say "@$_" for pp($m, $n);

sub pp {
    my($m, $n)=@_;
    my @pp;
    forpart { any {not is_prime($_)} @_ or @_==&uniq and push @pp,\@_ } $m, {n=>$n};
    @pp;
}
