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

ch-2.pl - B After A

=head1 SYNOPSIS

  perl ch-2.pl aabb
  perl ch-2.pl   # runs the embedded tests

=head1 DESCRIPTION

Return C<true> if there is at least one 'b', and no 'a' appears after the first
'b'. Otherwise return C<false>.

=cut

my $STR_CHECK = compile(Str);

sub b_after_a ($str) {
    ($str) = $STR_CHECK->($str);
    my $pos = index( $str, 'b' );
    return 0 if $pos < 0;
    return index( substr( $str, $pos + 1 ), 'a' ) < 0 ? 1 : 0;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    die "Usage: perl $0 <str>\n" if @args != 1;
    my $str = $args[0];
    my $out = b_after_a($str) ? 'true' : 'false';
    say "Input:  \$str = \"$str\"";
    say "Output: $out";
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { label => 'Example 1', str => 'aabb', expected => 1 },
        { label => 'Example 2', str => 'abab', expected => 0 },
        { label => 'Example 3', str => 'aaa',  expected => 0 },
        { label => 'Example 4', str => 'bbb',  expected => 1 },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        Test::More::is( b_after_a( $case->{str} ), $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 b_after_a($str)

Returns 1 if the condition holds, otherwise 0.

=cut

