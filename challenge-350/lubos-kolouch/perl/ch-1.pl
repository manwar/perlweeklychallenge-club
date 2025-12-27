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

ch-1.pl - Good Substrings

=head1 SYNOPSIS

  perl ch-1.pl abcaefg
  perl ch-1.pl   # runs the embedded tests

=head1 DESCRIPTION

Counts the number of substrings of length 3 that contain no repeated
characters.

=cut

my $STR_CHECK = compile(Str);

sub good_substrings ($str) {
    ($str) = $STR_CHECK->($str);
    my $n = length $str;
    return 0 if $n < 3;

    my $count = 0;
    for my $i ( 0 .. $n - 3 ) {
        my $sub = substr( $str, $i, 3 );
        my %seen;
        $seen{$_}++ for split //, $sub;
        ++$count if keys(%seen) == 3;
    }
    return $count;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    die "Usage: perl $0 <string>\n" if @args != 1;
    my $str = $args[0];
    my $out = good_substrings($str);
    say qq{Input:  \$str = "$str"};
    say "Output: $out";
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { label => 'Example 1', str => 'abcaefg', expected => 5 },
        { label => 'Example 2', str => 'xyzzabc', expected => 3 },
        { label => 'Example 3', str => 'aababc',  expected => 1 },
        { label => 'Example 4', str => 'qwerty',  expected => 4 },
        { label => 'Example 5', str => 'zzzaaa',  expected => 0 },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        Test::More::is( good_substrings( $case->{str} ), $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 good_substrings($str)

Returns the number of length-3 substrings in C<$str> that have all distinct
characters.

=cut
