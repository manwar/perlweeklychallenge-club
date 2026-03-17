#!/usr/bin/env perl

# Perl Weekly Challenge 247 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-247/

use Modern::Perl;

my @people = @ARGV;

my %to_receive; $to_receive{$_}=1 for @people;

for my $giver (@people) {
    my @receivers = grep {$to_receive{$_} && !same_family($_, $giver)} @people;
    if (!@receivers) {
        @receivers = grep {$to_receive{$_} && $_ ne $giver} @people;
    }
    @receivers or die;
    my $receiver = shift @receivers;
    delete $to_receive{$receiver};

    say $giver," -> ", $receiver;
}

sub same_family {
    my($a, $b) = @_;
    for ($a, $b) {
        s/Mrs?\. //;
    }
    return $a eq $b;
}
