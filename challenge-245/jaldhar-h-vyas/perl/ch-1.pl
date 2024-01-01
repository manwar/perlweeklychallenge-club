#!/usr/bin/perl
use 5.030;
use warnings;

my @lang1 = qw/ perl c python /;
my @popularity1 = qw/ 2 1 3 /;

my @lang2 = qw/ c++ haskell java /;
my @popularity2 = qw/ 1 3 2 /;

sub sortLanguages {
    my ($lang, $popularity) = @_;
    my %ranking;
    for my $i (0 .. scalar @{$lang} - 1) {
        $ranking{$lang->[$i]} = $popularity->[$i];
    }

    return sort { $ranking{$a} <=> $ranking{$b}} keys %ranking;
}

say join q{, }, sortLanguages(\@lang1, \@popularity1);
say join q{, }, sortLanguages(\@lang2, \@popularity2);
