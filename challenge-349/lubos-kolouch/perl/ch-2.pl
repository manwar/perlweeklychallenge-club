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

ch-2.pl - Meeting Point

=head1 SYNOPSIS

  perl ch-2.pl <path>
  perl ch-2.pl        # runs the embedded tests

=head1 DESCRIPTION

Determines whether repeatedly following the supplied movement instructions ever
returns to the origin C<(0,0)>. The valid instructions are the characters C<U>,
C<D>, C<L>, and C<R>. The core logic resides in L</returns_to_origin>.

=cut

my $PATH_CHECK = compile(Str);

sub returns_to_origin ($path) {
    ($path) = $PATH_CHECK->($path);
    die 'Path must contain only U, D, L, or R'
      if $path =~ /[^UDLR]/;
    my ( $x, $y ) = ( 0, 0 );
    return 1 if $path eq '';

    for my $step ( split //, $path ) {
        if    ( $step eq 'U' ) { ++$y }
        elsif ( $step eq 'D' ) { --$y }
        elsif ( $step eq 'L' ) { --$x }
        elsif ( $step eq 'R' ) { ++$x }
        return 1 if $x == 0 && $y == 0;
    }

    return 0;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }

    die "Usage: perl $0 <path>\n" if @args != 1;
    my $path   = $args[0];
    my $result = returns_to_origin($path) ? 'true' : 'false';
    say qq{Input:  \$path = "$path"};
    say "Output: $result";
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { label => 'Example 1', path => 'ULD',          expected => 0 },
        { label => 'Example 2', path => 'ULDR',         expected => 1 },
        { label => 'Example 3', path => 'UUURRRDDD',    expected => 0 },
        { label => 'Example 4', path => 'UURRRDDLLL',   expected => 1 },
        { label => 'Example 5', path => 'RRUULLDDRRUU', expected => 1 },
    );

    Test::More::plan( tests => scalar @cases );

    for my $case (@cases) {
        my $got = returns_to_origin( $case->{path} ) ? 1 : 0;
        Test::More::is( $got, $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 returns_to_origin($path)

Returns a boolean indicating whether the path ever visits the starting point
while processing the instructions. Dies if an invalid instruction occurs in the
path.

=cut
