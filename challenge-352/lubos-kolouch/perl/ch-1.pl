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

ch-1.pl - Match String

=head1 SYNOPSIS

  perl ch-1.pl cat cats dog dogcat dogcat rat ratcatdogcat
  perl ch-1.pl   # runs the embedded tests

=head1 DESCRIPTION

Given a list of words, the task is to return all words that appear as a
substring of another word in the list, preserving the order of their first
occurrence.

The examples indicate duplicates should be returned only once, so the function
de-duplicates matched words while keeping the original order.

=cut

my $WORDS_CHECK = compile( ArrayRef [Str] );

sub match_string ($words) {
    ($words) = $WORDS_CHECK->($words);

    my %seen;
    my @result;

    for my $i ( 0 .. $#$words ) {
        my $word = $words->[$i];
        next if $seen{$word}++;

        for my $j ( 0 .. $#$words ) {
            next if $i == $j;
            if ( index( $words->[$j], $word ) >= 0 ) {
                push @result, $word;
                last;
            }
        }
    }

    return \@result;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }

    my $result = match_string( \@args );
    say 'Input:  @words = ("' . join( '", "', @args ) . '")';
    say 'Output: ("' . join( '", "', @$result ) . '")';
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        {
            label    => 'Example 1',
            words    => [qw(cat cats dog dogcat dogcat rat ratcatdogcat)],
            expected => [qw(cat dog dogcat rat)],
        },
        {
            label    => 'Example 2',
            words    => [qw(hello hell world wor ellow elloworld)],
            expected => [qw(hell world wor ellow)],
        },
        {
            label    => 'Example 3',
            words    => [qw(a aa aaa aaaa)],
            expected => [qw(a aa aaa)],
        },
        {
            label    => 'Example 4',
            words    => [qw(flower flow flight fl fli ig ght)],
            expected => [qw(flow fl fli ig ght)],
        },
        {
            label    => 'Example 5',
            words    => [qw(car carpet carpenter pet enter pen pent)],
            expected => [qw(car pet enter pen pent)],
        },
    );

    Test::More::plan( tests => scalar @cases );

    for my $case (@cases) {
        my $got = match_string( $case->{words} );
        Test::More::is_deeply( $got, $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 match_string($words)

Accepts an array reference of strings and returns an array reference of the
words that occur as substrings of any other word in the list, preserving the
order of first occurrence.

=cut
