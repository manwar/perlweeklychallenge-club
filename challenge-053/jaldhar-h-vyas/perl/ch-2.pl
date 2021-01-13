#!/usr/bin/perl
use warnings;
use strict;
use 5.010;
use English qw/ -no_match_vars /;

sub usage {
    print <<"-usage-";
Usage:
  $PROGRAM_NAME <n>
  
    <n>    length of vowel string to be generated from 1 to 5
-usage-

    exit(1);
}

sub generate {
    my ($n) = @_;

    my %rules = (
        a => [qw/ e i /],
        e => [qw/ i /],
        i => [qw/ a e o u /],
        o => [qw/ a u /],
        u => [qw/ e o /]
    );

    my @generated;
    for my $i (1 .. $n) {
        if ($i == 1) {
            @generated = sort keys %rules;
        } else {
            @generated = map {
                my $e = $_;
                map {  $e . $_; } @{ $rules{substr $e, -1, 1} };
            } @generated;
        }
    }

    return @generated;
}


my $n = shift // usage();

if ($n < 1 || $n > 5) {
    usage();
}

for my $i (generate($n)) {
    say $i;

}