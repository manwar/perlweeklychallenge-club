#!/usr/bin/env perl
use strict;
use warnings;

=head1 NAME

ch-1.pl - The Weekly Challenge 335 Task 1: Common Characters

=head1 DESCRIPTION

Given an array of lowercase words, return every character that appears in each
word, preserving multiplicity. The solution builds frequency maps for every
word and keeps the minimum occurrence count per character. The final list
repeats each character according to that minimum count.

=head1 AUTHOR

Lubos Kolouch

=cut

use List::Util qw(min);
use Test::More tests => 5;

use constant WordList => 'ARRAY';

sub common_characters {
    my (@words) = @_;
    return () if !@words;

    my %common;
    $common{$_}++ for split //, $words[0];

    for my $word ( @words[ 1 .. $#words ] ) {
        my %freq;
        $freq{$_}++ for split //, $word;
        for my $char ( keys %common ) {
            $common{$char} = exists $freq{$char} ? min( $common{$char}, $freq{$char} ) : 0;
        }
        delete @common{ grep { $common{$_} == 0 } keys %common };
    }

    my @result;
    for my $char ( sort keys %common ) {
        push @result, ($char) x $common{$char};
    }
    return @result;
}

subtest 'Example 1' => sub {
    my @words = qw(bella label roller);
    is_deeply( [ common_characters(@words) ], [qw(e l l)], 'Common characters e, l, l' );
};

subtest 'Example 2' => sub {
    my @words = qw(cool lock cook);
    is_deeply( [ common_characters(@words) ], [qw(c o)], 'Common characters c, o' );
};

subtest 'Example 3' => sub {
    my @words = qw(hello world pole);
    is_deeply( [ common_characters(@words) ], [qw(l o)], 'Common characters l, o' );
};

subtest 'Example 4' => sub {
    my @words = qw(abc def ghi);
    is_deeply( [ common_characters(@words) ], [], 'No common characters' );
};

subtest 'Example 5' => sub {
    my @words = qw(aab aac aaa);
    is_deeply( [ common_characters(@words) ], [qw(a a)], 'Two common a characters' );
};
