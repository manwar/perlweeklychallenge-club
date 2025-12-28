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

ch-1.pl - Upper Lower

=head1 SYNOPSIS

  perl ch-1.pl pERl
  perl ch-1.pl   # runs the embedded tests

=head1 DESCRIPTION

Given a string of English letters, swap the case of each character: lower-case
becomes upper-case and vice versa.

=cut

my $STR_CHECK = compile(Str);

sub upper_lower ($str) {
    ($str) = $STR_CHECK->($str);
    $str =~ tr/a-zA-Z/A-Za-z/;
    return $str;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    die "Usage: perl $0 <string>\n" if @args != 1;

    my $str = $args[0];
    my $out = upper_lower($str);
    say qq{Input: \$str = "$str"};
    say qq{Output: "$out"};
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { label => 'Example 1', str => 'pERl',   expected => 'PerL' },
        { label => 'Example 2', str => 'rakU',   expected => 'RAKu' },
        { label => 'Example 3', str => 'PyThOn', expected => 'pYtHoN' },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        Test::More::is( upper_lower( $case->{str} ), $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 upper_lower($str)

Returns the string with swapped case.

=cut
