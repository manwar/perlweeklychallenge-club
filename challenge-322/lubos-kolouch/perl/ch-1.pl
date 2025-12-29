#!/usr/bin/env perl
use v5.38;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';
## no critic (Subroutines::ProhibitSubroutinePrototypes)

use Type::Params    qw(compile);
use Types::Standard qw(Int Str);

=pod

=head1 NAME

ch-1.pl - String Format

=head1 SYNOPSIS

  perl ch-1.pl "ABC-D-E-F" 3
  perl ch-1.pl   # runs the embedded tests

=head1 DESCRIPTION

Removes dashes from the input string and re-groups the characters into chunks
of size C<$i> from the end. The first group may be shorter but must contain at
least one character. Groups are joined using dashes.

=cut

my $ARGS_CHECK = compile( Str, Int );

sub string_format ($str, $i) {
    ( $str, $i ) = $ARGS_CHECK->( $str, $i );
    die 'Expected a positive integer group size' if $i <= 0;

    $str =~ s/-//g;
    return '' if $str eq '';

    my @groups;
    while ( length($str) > $i ) {
        my $chunk = substr( $str, -$i, $i, '' );
        push @groups, $chunk;
    }
    push @groups, $str if $str ne '';

    return join '-', reverse @groups;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }

    die "Usage: perl $0 <string> <i>\n" if @args != 2;
    my ( $str, $i ) = @args;
    my $out = string_format( $str, 0 + $i );
    say qq{Input: \$str = "$str", \$i = $i};
    say qq{Output: "$out"};
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { label => 'Example 1', str => 'ABC-D-E-F',  i => 3, expected => 'ABC-DEF' },
        { label => 'Example 2', str => 'A-BC-D-E',   i => 2, expected => 'A-BC-DE' },
        { label => 'Example 3', str => '-A-B-CD-E',  i => 4, expected => 'A-BCDE' },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        my $got = string_format( $case->{str}, $case->{i} );
        Test::More::is( $got, $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 string_format($str, $i)

Returns the re-formatted string after removing dashes and regrouping the
remaining characters into groups of size C<$i> from the end.

=cut
