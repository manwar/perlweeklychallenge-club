#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';

say join ' ', all_sorted_abecedarian_in(shift);

sub all_sorted_abecedarian_in ($dictionary) {
   sort { length($a) <=> length($b) } all_abecedarian_in($dictionary);
}

sub all_abecedarian_in ($dictionary) {
   open my $fh, '<:encoding(utf-8)', $dictionary or die "open(): $!\n";
   grep { is_abecedarian($_) } map { s{\s+\z}{}rmxs } readline $fh;
}

sub is_abecedarian ($word) {
   fc $word eq join '', sort split m{}mxs, fc $word;
}
