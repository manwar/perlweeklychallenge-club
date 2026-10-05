#!/usr/bin/env perl
use v5.38;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';
## no critic (Subroutines::ProhibitSubroutinePrototypes)

use Type::Params    qw(compile);
use Types::Standard qw(ArrayRef Str);

=pod

=head1 NAME

ch-2.pl - Alternating Vowels Consonants (WWC 394 Task 2)

=head1 SYNOPSIS

  perl ch-2.pl relocate delocate allocate
  perl ch-2.pl   # runs the embedded tests

=head1 DESCRIPTION

You are given three strings containing English alphabetic characters.
Find all the longest contiguous substrings common to all three strings that strictly
alternate between vowels and consonants.

=cut

my $STRS_CHECK = compile( ArrayRef [Str] );

sub is_vowel ($c) {
    return $c =~ /^[aeiouAEIOU]\z/ ? 1 : 0;
}

sub is_alternating ($sub) {
    return 0 if length($sub) == 0;
    my @chars = split //, $sub;
    for my $i ( 1 .. $#chars ) {
        return 0 if is_vowel( $chars[$i] ) == is_vowel( $chars[ $i - 1 ] );
    }
    return 1;
}

sub longest_alternating_common_substrings ($strs) {
    ($strs) = $STRS_CHECK->($strs);
    die 'Exactly three strings are required' if @$strs != 3;

    my ( $s1, $s2, $s3 ) = @$strs;
    my $len1 = length($s1);

    my %valid_candidates;

    for my $i ( 0 .. $len1 - 1 ) {
        for my $len ( 1 .. $len1 - $i ) {
            my $candidate = substr( $s1, $i, $len );
            if ( !is_alternating($candidate) ) {
                last;
            }
            if ( index( $s2, $candidate ) != -1 && index( $s3, $candidate ) != -1 ) {
                $valid_candidates{$candidate} = length($candidate);
            }
        }
    }

    return () if !%valid_candidates;

    my $max_len = 0;
    for my $len ( values %valid_candidates ) {
        $max_len = $len if $len > $max_len;
    }

    # Extract all candidates of max_len in order of first appearance in s1
    my @result;
    my %seen;
    for my $i ( 0 .. $len1 - $max_len ) {
        my $sub = substr( $s1, $i, $max_len );
        if ( exists $valid_candidates{$sub} && $valid_candidates{$sub} == $max_len && !$seen{$sub} ) {
            push @result, $sub;
            $seen{$sub} = 1;
        }
    }

    return @result;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    die "Usage: perl $0 str1 str2 str3\n" if @args != 3;
    my @out = longest_alternating_common_substrings( \@args );
    say 'Output: (' . join( ', ', map { qq{"$_"} } @out ) . ')';
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    # Note: In Example 1, "locate" has length 6 ('l'-C, 'o'-V, 'c'-C, 'a'-V, 't'-C, 'e'-V)
    # which alternates and appears in all three words ("relocate", "delocate", "allocate").
    # The official blog output shows ("locate").
    my @cases = (
        {
            label    => 'Example 1',
            strs     => [ 'relocate', 'delocate', 'allocate' ],
            expected => ['locate'],
        },
        {
            label    => 'Example 2',
            strs     => [ 'apple', 'banana', 'cherry' ],
            expected => [],
        },
        {
            label    => 'Example 3',
            strs     => [ 'navigate', 'cavity', 'gravity' ],
            expected => ['avi'],
        },
        {
            label    => 'Example 4',
            strs     => [ 'pedalgia', 'pedalboard', 'pedantic' ],
            expected => ['peda'],
        },
        {
            label    => 'Example 5',
            strs     => [ 'schoolmaster', 'schoolhouse', 'schooling' ],
            expected => [ 'ho', 'ol' ],
        },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        my @got = longest_alternating_common_substrings( $case->{strs} );
        Test::More::is_deeply( \@got, $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 is_vowel($c)

Returns 1 if the character is an English vowel (a, e, i, o, u, case-insensitive), 0 otherwise.

=head2 is_alternating($sub)

Returns 1 if the string strictly alternates between vowels and consonants, 0 otherwise.

=head2 longest_alternating_common_substrings($strs)

Returns the longest contiguous substrings common to all three strings that alternate vowels and consonants.

=cut
