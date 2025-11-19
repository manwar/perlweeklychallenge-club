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

ch-1.pl - String Alike

=head1 SYNOPSIS

  perl ch-1.pl <even_length_string>
  perl ch-1.pl          # runs the embedded tests

=head1 DESCRIPTION

Checks whether a provided even-length string can be split into two halves that
share the same non-zero number of vowels. The implementation keeps the logic in
L</string_alike> so it may be reused both by the command line interface and the
unit tests bundled at the end of the file.

=cut

my $STRING_CHECK = compile(Str);

sub string_alike ($text) {
    ($text) = $STRING_CHECK->($text);
    my $length = length $text;
    die 'Expected an even-length string' if $length % 2;

    my $half         = $length / 2;
    my $first_half   = substr $text, 0, $half;
    my $second_half  = substr $text, $half;
    my $first_count  = ( $first_half  =~ tr/AEIOUaeiou// );
    my $second_count = ( $second_half =~ tr/AEIOUaeiou// );

    return $first_count > 0 && $first_count == $second_count;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }

    die "Usage: perl $0 <even_length_string>\n" if @args != 1;
    my $input = $args[0];
    say qq{Input:  \$str = "$input"};
    my $result = string_alike($input) ? 'true' : 'false';
    say "Output: $result";
}

sub _run_tests {
    require Test::More;
    Test::More->import();

    my @cases = (
        { label => 'Example 1', str => 'textbook',     expected => 0 },
        { label => 'Example 2', str => 'book',         expected => 1 },
        { label => 'Example 3', str => 'AbCdEfGh',     expected => 1 },
        { label => 'Example 4', str => 'rhythmmyth',   expected => 0 },
        { label => 'Example 5', str => 'UmpireeAudio', expected => 0 },
    );

    Test::More::plan( tests => scalar @cases );

    for my $case (@cases) {
        my $got = string_alike( $case->{str} ) ? 1 : 0;
        Test::More::is( $got, $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 string_alike($text)

Returns a boolean indicating whether the halves of C<$text> have the same
positive count of vowels. Throws an exception when the input does not meet the
problem specification (e.g. odd length).

=cut
