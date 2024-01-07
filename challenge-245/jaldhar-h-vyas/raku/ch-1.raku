#!/usr/bin/raku

my @lang1 = <perl c python>;
my @popularity1 = <2 1 3>;

my @lang2 = <c++ haskell java>;
my @popularity2 = <1 3 2>;

sub sortLanguages(@lang, @popularity) {
    my %ranking = @lang Z=> @popularity;
    return %ranking.keys.sort({ %ranking{$^a} <=> %ranking{$^b}});
}

sub MAIN() {
    sortLanguages(@lang1, @popularity1).join(q{, }).say;
    sortLanguages(@lang2, @popularity2).join(q{, }).say;
}