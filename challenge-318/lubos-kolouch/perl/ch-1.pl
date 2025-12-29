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

ch-1.pl - Group Position

=head1 SYNOPSIS

  perl ch-1.pl abccccd
  perl ch-1.pl   # runs the embedded tests

=head1 DESCRIPTION

Extracts all groups of three or more identical consecutive lowercase letters.
The task statement mentions positions, but the examples return the group
substrings themselves.

=cut

my $STR_CHECK = compile(Str);

sub group_position ($str) {
    ($str) = $STR_CHECK->($str);
    my @groups = ( $str =~ /((.)\2{2,})/g );
    # The regex with a capturing group produces alternating full-match and inner
    # group captures; keep only the full matches.
    my @result;
    for ( my $i = 0; $i < @groups; $i += 2 ) {
        push @result, $groups[$i];
    }
    return \@result;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    die "Usage: perl $0 <string>\n" if @args != 1;

    my $str    = $args[0];
    my $groups = group_position($str);
    say qq{Input: \$str = "$str"};
    if (@$groups) {
        say 'Output: "' . join( '", "', @$groups ) . '"';
    }
    else {
        say 'Output: ""';
    }
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { label => 'Example 1', str => 'abccccd',        expected => ['cccc'] },
        { label => 'Example 2', str => 'aaabcddddeefff', expected => [ 'aaa', 'dddd', 'fff' ] },
        { label => 'Example 3', str => 'abcdd',          expected => [] },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        my $got = group_position( $case->{str} );
        Test::More::is_deeply( $got, $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 group_position($str)

Returns an array reference of repeated-letter groups of length at least three.

=cut
