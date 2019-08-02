#!/usr/bin/perl
use strict;
use warnings;
use feature qw/say/;

sub max { $_[0] > $_[1] ? $_[0] : $_[1] }
sub min { $_[0] > $_[1] ? $_[1] : $_[0] }

sub simj {
    my ($str1, $str2) = @_;
    my $len1 = length $str1;
    my $len2 = length $str2;
    my $dmax = int (max($len1, $len2) / 2) -1;
    my @st1 = split //, $str1;
    my $i = 0;
    my @matches;
    for my $letter (split //, $str2) {
        push @matches, $letter if (grep { $letter eq $_ }
            @st1[max(0,$i-$dmax)..min($i+$dmax,$len1-1)]);
        $i++;
    }
    my $nb_matches = scalar @matches;
    return 0 if $nb_matches == 0;
    my %matching_letters = map { $_ => 1} @matches;
    my @matches_str1 = grep exists $matching_letters{$_},
        split //, $str1;
    my $disorder = 0;
    for my $i (0..$nb_matches-1) {
        $disorder++ if $matches[$i] ne $matches_str1[$i];
    }
    my $transposition = $disorder / 2;
    return ($nb_matches / $len1 + $nb_matches / $len2 +
        ($nb_matches - $transposition)/$nb_matches) / 3;
}
sub simw {
    my ($str1, $str2) = @_;
    my $p_constant = 0.1;
    my $length_prefix = 0;
    for my $count (0..3) {
        last if substr $str1, $count, 1 ne substr $str2, $count, 1;
        $length_prefix++;
    }
    my $simj = simj $str1, $str2;
    return $simj + $length_prefix * $p_constant * (1 - $simj);
}

my @tests = ( ["FOO", "BAR"], ["CRATE", "TRACE"],
    ["CRATE", "CRATE"], ["TRACE", "CRATE"],
    ["CREATE", "TRACT"], ["DWAYNE", "DUANE"], );
for my $word_pair (@tests) {
    my ($w1, $w2) = @$word_pair;
    my $simw = simw $w1, $w2;
    say "Jaro-Winkler distance between $w1 and $w2 is: ", 1 - $simw;
}
