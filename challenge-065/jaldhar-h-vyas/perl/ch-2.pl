#!/usr/bin/perl
use warnings;
use strict;
use 5.010;
use English qw/ -no_match_vars /;

sub usage() {
    print<<"-USAGE-";
Usage:
  $PROGRAM_NAME <S>
  
    <S>    string to search for palindromes
-USAGE-

    exit(1);
}

sub is_palindrome {
    my ($s) = @_;

    return $s eq reverse $s;
}

sub get_palindromes {
    my ($s) = @_;
    my @palindromes;

    for my $l (2 .. length $s ) {
        my $possible = substr $s, 0, $l;
        if (is_palindrome($possible)) {
            push @palindromes, $possible;
            push @palindromes, get_palindromes(substr $s, $l);
        }
    }

    return @palindromes;
}

if (scalar @ARGV < 1) {
    usage();
}

my $S = $ARGV[0];
my %results;

for my $n (0 .. (length $S) - 1) {
    for my $palindrome (get_palindromes(substr $S, $n)) {
        $results{$palindrome}++;
    }
}

say scalar keys %results ? join q{, }, keys %results : '-1';
