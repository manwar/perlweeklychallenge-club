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

ch-2.pl - Subsequence

=head1 SYNOPSIS

  perl ch-2.pl uvw bcudvew
  perl ch-2.pl   # runs the embedded tests

=head1 DESCRIPTION

Checks whether C<$str1> is a subsequence of C<$str2>, i.e. whether it can be
obtained by deleting characters from C<$str2> without changing the order of the
remaining characters.

=cut

my $ARGS_CHECK = compile( Str, Str );

sub is_subsequence ($str1, $str2) {
    ( $str1, $str2 ) = $ARGS_CHECK->( $str1, $str2 );
    return 1 if $str1 eq '';

    my $i = 0;
    for my $ch ( split //, $str2 ) {
        my $want = substr( $str1, $i, 1 );
        if ( $ch eq $want ) {
            ++$i;
            return 1 if $i == length($str1);
        }
    }

    return 0;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }

    die "Usage: perl $0 <str1> <str2>\n" if @args != 2;
    my ( $s1, $s2 ) = @args;
    my $out = is_subsequence( $s1, $s2 ) ? 'true' : 'false';
    say qq{Input: \$str1 = "$s1", \$str2 = "$s2"};
    say "Output: $out";
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { label => 'Example 1', str1 => 'uvw', str2 => 'bcudvew',    expected => 1 },
        { label => 'Example 2', str1 => 'aec', str2 => 'abcde',      expected => 0 },
        { label => 'Example 3', str1 => 'sip', str2 => 'javascript', expected => 1 },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        my $got = is_subsequence( $case->{str1}, $case->{str2} ) ? 1 : 0;
        Test::More::is( $got, $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 is_subsequence($str1, $str2)

Returns a boolean indicating whether C<$str1> is a subsequence of C<$str2>.

=cut
