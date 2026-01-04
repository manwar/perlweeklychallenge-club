#!/usr/bin/env perl
use v5.38;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';
## no critic (Subroutines::ProhibitSubroutinePrototypes)

use Type::Params    qw(compile);
use Types::Standard qw(ArrayRef Str);

=pod

=head1 NAME

ch-1.pl - Zip List

=head1 SYNOPSIS

  perl ch-1.pl 1 2 3 -- a b c
  perl ch-1.pl   # runs the embedded tests

=head1 DESCRIPTION

Merge two lists of equal length by alternating elements.

=cut

my $ARR_CHECK = compile( ArrayRef [Str], ArrayRef [Str] );

sub zip_list ($a, $b) {
    ( $a, $b ) = $ARR_CHECK->( $a, $b );
    die 'Expected lists of the same size' if @$a != @$b;

    my @out;
    for my $i ( 0 .. $#$a ) {
        push @out, $a->[$i], $b->[$i];
    }
    return \@out;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }

    my $sep = undef;
    for my $i ( 0 .. $#args ) {
        if ( $args[$i] eq '--' ) { $sep = $i; last }
    }
    die "Usage: perl $0 <a...> -- <b...>\n" if !defined($sep) || $sep == 0 || $sep == $#args;

    my @a = @args[ 0 .. $sep - 1 ];
    my @b = @args[ $sep + 1 .. $#args ];
    my $out = zip_list( \@a, \@b );
    say 'Output: (' . join( ', ', @$out ) . ')';
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    Test::More::plan( tests => 2 );
    Test::More::is_deeply( zip_list( [qw(1 2 3)], [qw(a b c)] ), [qw(1 a 2 b 3 c)], 'Example (a,b)' );
    Test::More::is_deeply( zip_list( [qw(a b c)], [qw(1 2 3)] ), [qw(a 1 b 2 c 3)], 'Example (b,a)' );
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 zip_list($a, $b)

Returns an arrayref with alternating elements from C<$a> and C<$b>.

=cut

