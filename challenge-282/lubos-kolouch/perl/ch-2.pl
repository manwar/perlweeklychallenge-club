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

ch-2.pl - Changing Keys

=head1 SYNOPSIS

  perl ch-2.pl pPeERrLl
  perl ch-2.pl   # runs the embedded tests

=head1 DESCRIPTION

Counts how many times the user changed keys while typing a string, ignoring
case (i.e. shift/caps is not considered a key change).

This is the number of transitions between adjacent characters in the
lowercased string.

=cut

my $STR_CHECK = compile(Str);

sub changing_keys ($str) {
    ($str) = $STR_CHECK->($str);
    my $s = lc $str;
    my @chars = split //, $s;
    return 0 if @chars <= 1;

    my $changes = 0;
    my $prev    = shift @chars;
    for my $ch (@chars) {
        ++$changes if $ch ne $prev;
        $prev = $ch;
    }
    return $changes;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    die "Usage: perl $0 <str>\n" if @args != 1;
    my $str = $args[0];
    my $out = changing_keys($str);
    say "Input:  \$str = \"$str\"";
    say "Output: $out";
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { label => 'Example 1', str => 'pPeERrLl', expected => 3 },
        { label => 'Example 2', str => 'rRr',      expected => 0 },
        { label => 'Example 3', str => 'GoO',      expected => 1 },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        Test::More::is( changing_keys( $case->{str} ), $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 changing_keys($str)

Returns the number of key changes while typing C<$str> (case-insensitive).

=cut

