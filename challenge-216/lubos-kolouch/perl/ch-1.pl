#!/usr/bin/perl
use strict;
use warnings;

sub matching_words {
    my ($words, $reg) = @_;
    $reg = uc($reg);
    my %letters;
    for my $letter (grep {/[A-Z]/} split //, $reg) {
        $letters{$letter} = 1;
    }
    my @matches;
    for my $word (@$words) {
        my $upper_word = uc($word);
        my $matched = 1;
        for my $letter (keys %letters) {
            unless (index($upper_word, $letter) != -1) {
                $matched = 0;
                last;
            }
        }
        push @matches, $word if $matched;
    }
    return \@matches;
}

my @words = ('job', 'james', 'bjorg');
my $reg = '007 JB';
my $matches = matching_words(\@words, $reg);
print "(", join(", ", map { "'$_'" } @$matches), ")\n";

