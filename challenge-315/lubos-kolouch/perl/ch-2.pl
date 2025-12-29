#!/usr/bin/env perl
use v5.38;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';
## no critic (Subroutines::ProhibitSubroutinePrototypes)

use Type::Params    qw(compile);
use Types::Standard qw(Str);

=pod

=head1 NAME

ch-2.pl - Find Third

=head1 SYNOPSIS

  perl ch-2.pl "Perl is a my favourite language but Python is my favourite too." my favourite
  perl ch-2.pl   # runs the embedded tests

=head1 DESCRIPTION

Given a sentence and two words, return all words that immediately follow the
sequence C<$first $second> in the sentence.

The examples show punctuation (e.g. trailing dots) should be ignored when
matching and returning words.

=cut

my $ARGS_CHECK = compile( Str, Str, Str );

sub _tokenize ($sentence) {
    my @tokens = split /\s+/, $sentence;
    @tokens = map { s/\A[^A-Za-z0-9_]+//r =~ s/[^A-Za-z0-9_]+\z//r } @tokens;
    return [ grep { $_ ne '' } @tokens ];
}

sub find_third ($sentence, $first, $second) {
    ( $sentence, $first, $second ) = $ARGS_CHECK->( $sentence, $first, $second );

    my $tokens = _tokenize($sentence);
    my @out;
    for my $i ( 0 .. $#$tokens - 2 ) {
        next if $tokens->[$i] ne $first;
        next if $tokens->[ $i + 1 ] ne $second;
        push @out, $tokens->[ $i + 2 ];
    }
    return \@out;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    die "Usage: perl $0 <sentence> <first> <second>\n" if @args != 3;

    my ( $sentence, $first, $second ) = @args;
    my $out = find_third( $sentence, $first, $second );
    say qq{Input: \$sentence = "$sentence"};
    say qq{       \$first = "$first"};
    say qq{       \$second = "$second"};
    say 'Output: ("' . join( '", "', @$out ) . '")';
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        {
            label    => 'Example 1',
            sentence => 'Perl is a my favourite language but Python is my favourite too.',
            first    => 'my',
            second   => 'favourite',
            expected => [qw(language too)],
        },
        {
            label    => 'Example 2',
            sentence => 'Barbie is a beautiful doll also also a beautiful princess.',
            first    => 'a',
            second   => 'beautiful',
            expected => [qw(doll princess)],
        },
        {
            label    => 'Example 3',
            sentence => 'we will we will rock you rock you.',
            first    => 'we',
            second   => 'will',
            expected => [qw(we rock)],
        },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        my $got = find_third( $case->{sentence}, $case->{first}, $case->{second} );
        Test::More::is_deeply( $got, $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 find_third($sentence, $first, $second)

Returns an array reference of words that follow occurrences of the pair
C<$first $second>.

=cut
