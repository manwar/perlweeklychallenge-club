#!/usr/bin/env perl
use v5.38;
use warnings;
use Type::Params -sigs;
use Types::Standard qw(Str);
use Test::More;

=pod

=head1 NAME

ch-1.pl - Uncommon Words (The Weekly Challenge 266 Task 1)

=head1 SYNOPSIS

  perl ch-1.pl "Mango is sweet" "Mango is sour"
  perl ch-1.pl   # runs the embedded tests

=head1 DESCRIPTION

You are given two sentences, C<$line1> and C<$line2>.

Write a script to find all uncommon words in any order in the given two sentences.
Return C<('')> if none found.

A word is uncommon if it appears exactly once in one of the sentences and
does not appear in the other sentence.

=head1 FUNCTIONS

=head2 uncommon_words($line1, $line2)

Finds all words that appear exactly once in either sentence and do not appear
in the other sentence.

=over 4

=item * C<$line1> - First sentence string.

=item * C<$line2> - Second sentence string.

=back

Returns a list of uncommon words, or C<('')> if none found.

=cut

signature_for uncommon_words => (
    method     => 0,
    positional => [ Str, Str ],
);

sub uncommon_words ( $line1, $line2 ) {
    my %count1;
    my @words1 = split ' ', $line1;
    $count1{$_}++ for @words1;

    my %count2;
    my @words2 = split ' ', $line2;
    $count2{$_}++ for @words2;

    my @result;
    for my $word ( grep { $count1{$_} == 1 && !exists $count2{$_} } @words1 ) {
        push @result, $word;
    }
    for my $word ( grep { $count2{$_} == 1 && !exists $count1{$_} } @words2 ) {
        push @result, $word;
    }

    return @result ? @result : ('');
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    my $line1 = shift @args;
    my $line2 = shift @args;
    my @words = uncommon_words( $line1, $line2 );
    say "Output: (" . join( ", ", map { qq('$_') } @words ) . ")";
}

sub _run_tests {
    my @cases = (
        {
            label    => 'Example 1',
            line1    => 'Mango is sweet',
            line2    => 'Mango is sour',
            expected => [ 'sweet', 'sour' ],
        },
        {
            label    => 'Example 2',
            line1    => 'Mango Mango',
            line2    => 'Orange',
            expected => ['Orange'],
        },
        {
            label    => 'Example 3',
            line1    => 'Mango is Mango',
            line2    => 'Orange is Orange',
            expected => [''],
        },
    );

    plan( tests => scalar @cases );
    for my $case (@cases) {
        my @res = uncommon_words( $case->{line1}, $case->{line2} );
        is_deeply( \@res, $case->{expected}, $case->{label} );
    }
    done_testing();
}

_run_cli(@ARGV);

=cut
