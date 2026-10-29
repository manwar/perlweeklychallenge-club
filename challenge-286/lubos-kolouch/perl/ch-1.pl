#!/usr/bin/env perl
use v5.38;
use warnings;
use Type::Params -sigs;
use Types::Standard qw(Str);
use Test::More;

=pod

=head1 NAME

ch-1.pl - Self Spammer (The Weekly Challenge 286 Task 1)

=head1 SYNOPSIS

  perl ch-1.pl
  perl ch-1.pl --test   # runs the embedded tests

=head1 DESCRIPTION

This script reads its own source code, splits it into words (anything between whitespace), selects one at random, and prints it.

=head1 FUNCTIONS

=head2 get_random_word($filename)

Reads the given source file (defaults to C<$0>) and returns a random word from it.

=cut

signature_for get_random_word => (
    method     => 0,
    positional => [ Str, { default => $0 } ],
);

sub get_random_word ( $filename = $0 ) {
    open my $fh, '<', $filename or die "Cannot open $filename: $!";
    my @words;
    while ( my $line = <$fh> ) {
        push @words, split( /\s+/, $line );
    }
    close $fh;

    # Filter out any empty tokens resulting from leading whitespace
    @words = grep { length $_ } @words;

    my $random_word = $words[ rand @words ];
    return $random_word;
}

sub _run_cli (@args) {
    if ( @args && $args[0] eq '--test' ) {
        _run_tests();
        return;
    }
    my $word = get_random_word();
    say $word;
}

sub _run_tests {
    my $filename = $0;
    open my $fh, '<', $filename or die "Cannot open $filename: $!";
    my $content = do { local $/; <$fh> };
    close $fh;

    my @words = grep { length $_ } split( /\s+/, $content );
    my %word_set = map { $_ => 1 } @words;

    plan( tests => 2 );

    my $word = get_random_word();
    ok( defined $word && length($word) > 0, 'Returned word is non-empty' );
    ok( exists $word_set{$word},           'Returned word exists in source code' );

    done_testing();
}

_run_cli(@ARGV);

=cut
