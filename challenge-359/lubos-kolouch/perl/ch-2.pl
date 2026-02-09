#!/usr/bin/env perl
use v5.38;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';

=pod

=head1 NAME

ch-2.pl - String Reduction

=head1 SYNOPSIS

  perl ch-2.pl               # runs the embedded tests
  perl ch-2.pl mississippi   # prints "m"

=head1 DESCRIPTION

Repeatedly remove adjacent duplicate characters until no such duplicates
remain, and return the final string.

=cut

sub reduce_string ($word) {
    die "Expected a word\n" if !defined $word;

    my @stack;
    for my $ch ( split //, $word ) {
        if ( @stack && $stack[-1] eq $ch ) {
            pop @stack;
        }
        else {
            push @stack, $ch;
        }
    }
    return join '', @stack;
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { word => 'aabbccdd',    out => '',       label => 'Example 1' },
        { word => 'abccba',      out => '',       label => 'Example 2' },
        { word => 'abcdef',      out => 'abcdef', label => 'Example 3' },
        { word => 'aabbaeaccdd', out => 'aea',    label => 'Example 4' },
        { word => 'mississippi', out => 'm',      label => 'Example 5' },
    );

    Test::More::plan( tests => scalar @cases );
    for my $t (@cases) {
        Test::More::is( reduce_string( $t->{word} ), $t->{out}, $t->{label} );
    }
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    die "Usage: perl $0 <word>\n" if @args != 1;
    say reduce_string( $args[0] );
}

_run_cli(@ARGV);

