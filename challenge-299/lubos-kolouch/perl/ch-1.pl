#!/usr/bin/env perl
use v5.38;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';
## no critic (Subroutines::ProhibitSubroutinePrototypes)

use List::Util      qw(min);
use Type::Params    qw(compile);
use Types::Standard qw(ArrayRef Str);

=pod

=head1 NAME

ch-1.pl - Replace Words

=head1 SYNOPSIS

  perl ch-1.pl "cat bat rat" "the cattle was rattle by the battery"
  perl ch-1.pl   # runs the embedded tests

=head1 DESCRIPTION

Given a dictionary of words, replace each word in the sentence with the
shortest dictionary word that is a prefix of it (if any).

=cut

my $ARGS_CHECK = compile( ArrayRef [Str], Str );

sub replace_words ($words, $sentence) {
    ( $words, $sentence ) = $ARGS_CHECK->( $words, $sentence );
    my @dict = sort { length($a) <=> length($b) } @$words;

    my @out;
    for my $token ( split /\s+/, $sentence ) {
        my $replacement = $token;
        for my $root (@dict) {
            if ( index( $token, $root ) == 0 ) {
                $replacement = $root;
                last;
            }
        }
        push @out, $replacement;
    }

    return join ' ', @out;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    die "Usage: perl $0 \"word1 word2...\" \"sentence\"\n" if @args != 2;
    my @words = split /\s+/, $args[0];
    my $out = replace_words( \@words, $args[1] );
    say qq{Output: "$out"};
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        {
            label    => 'Example 1',
            words    => [qw(cat bat rat)],
            sentence => 'the cattle was rattle by the battery',
            expected => 'the cat was rat by the bat',
        },
        {
            label    => 'Example 2',
            words    => [qw(a b c)],
            sentence => 'aab aac and cac bab',
            expected => 'a a a c b',
        },
        {
            label    => 'Example 3',
            words    => [qw(man bike)],
            sentence => 'the manager was hit by a biker',
            expected => 'the man was hit by a bike',
        },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        my $got = replace_words( $case->{words}, $case->{sentence} );
        Test::More::is( $got, $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 replace_words($words, $sentence)

Returns the sentence after replacing each word by the shortest matching prefix
from the dictionary.

=cut
