#!/usr/bin/perl
use warnings;
use strict;

sub is_palindrome {
    my ($s) = @_;
    $s eq reverse $s
}

my %solved;
sub palindrome_partition {
    my ($string, $from) = @_;
    my @palindromes;
    for my $start ($from // 0.. length($string) - 1) {
        for my $length (2 .. length($string) - $start) {
            my $substr = substr $string, $start, $length;
            my $rest = substr $string, $start + length $substr;
            next unless is_palindrome($substr);

            next if $solved{$start}{$length}++;
            my $recurse = palindrome_partition($string, $start + $length);
            if (@$recurse) {
                push @palindromes, map [ $substr, @$_ ], @$recurse;
            } else {
                push @palindromes, [$substr];
            }
        }
    }
    return \@palindromes
}

use Test::More;
use Test::Deep;

cmp_deeply palindrome_partition('aabaab'),
    bag(['aabaa'], ['aa', 'baab'], ['aba'], ['aa', 'aa']);

cmp_deeply palindrome_partition('abbaba'),
    bag(['abba'], ['bb', 'aba'], ['bab']);

done_testing();
