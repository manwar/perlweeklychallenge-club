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

ch-1.pl - Equal Strings

=head1 SYNOPSIS

  perl ch-1.pl abc abb ab
  perl ch-1.pl   # runs the embedded tests

=head1 DESCRIPTION

You may delete the rightmost character from any of the three input strings.
The goal is to make all three strings equal using the minimum number of
deletions. If it is impossible, return C<-1>.

This is equivalent to finding the longest common prefix shared by all three
strings. If that prefix is empty, the answer is C<-1>, otherwise the number of
deletions is the sum of characters removed from each string.

=cut

my $ARGS_CHECK = compile( Str, Str, Str );

sub equal_strings_ops ($s1, $s2, $s3) {
    ( $s1, $s2, $s3 ) = $ARGS_CHECK->( $s1, $s2, $s3 );

    my $min_len = length($s1);
    $min_len = length($s2) if length($s2) < $min_len;
    $min_len = length($s3) if length($s3) < $min_len;

    my $i = 0;
    while ( $i < $min_len ) {
        my $ch = substr( $s1, $i, 1 );
        last if $ch ne substr( $s2, $i, 1 ) || $ch ne substr( $s3, $i, 1 );
        ++$i;
    }

    return -1 if $i == 0;
    return ( length($s1) - $i ) + ( length($s2) - $i ) + ( length($s3) - $i );
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    die "Usage: perl $0 <s1> <s2> <s3>\n" if @args != 3;

    my ( $s1, $s2, $s3 ) = @args;
    my $out = equal_strings_ops( $s1, $s2, $s3 );
    say qq{Input: \$s1 = "$s1", \$s2 = "$s2", \$s3 = "$s3"};
    say "Output: $out";
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { label => 'Example 1', s1 => 'abc', s2 => 'abb', s3 => 'ab',  expected => 2 },
        { label => 'Example 2', s1 => 'ayz', s2 => 'cyz', s3 => 'xyz', expected => -1 },
        { label => 'Example 3', s1 => 'yza', s2 => 'yzb', s3 => 'yzc', expected => 3 },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        Test::More::is(
            equal_strings_ops( $case->{s1}, $case->{s2}, $case->{s3} ),
            $case->{expected},
            $case->{label},
        );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 equal_strings_ops($s1, $s2, $s3)

Returns the minimum number of rightmost deletions required to make the three
strings equal, or C<-1> when no non-empty common prefix exists.

=cut
