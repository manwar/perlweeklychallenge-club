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

ch-2.pl - Count Asterisks

=head1 SYNOPSIS

  perl ch-2.pl 'p|*e*rl|w**e|*ekly|'
  perl ch-2.pl   # runs the embedded tests

=head1 DESCRIPTION

Given a string where every two consecutive vertical bars form a pair, count
the number of asterisks C<*> excluding those between each bar pair.

=cut

my $STR_CHECK = compile(Str);

sub count_asterisks ($str) {
    ($str) = $STR_CHECK->($str);

    my $inside = 0;
    my $count  = 0;
    for my $ch ( split //, $str ) {
        if ( $ch eq '|' ) {
            $inside = !$inside;
            next;
        }
        ++$count if !$inside && $ch eq '*';
    }
    return $count;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    die "Usage: perl $0 <str>\n" if @args != 1;
    my $str = $args[0];
    my $out = count_asterisks($str);
    say "Input:  \$str = \"$str\"";
    say "Output: $out";
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { label => 'Example 1', str => 'p|*e*rl|w**e|*ekly|',          expected => 2 },
        { label => 'Example 2', str => 'perl',                        expected => 0 },
        { label => 'Example 3', str => 'th|ewe|e**|k|l***ych|alleng|e', expected => 5 },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        Test::More::is( count_asterisks( $case->{str} ), $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 count_asterisks($str)

Returns the number of asterisks outside paired bar segments.

=cut

