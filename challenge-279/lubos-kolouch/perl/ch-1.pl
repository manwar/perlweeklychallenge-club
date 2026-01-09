#!/usr/bin/env perl
use v5.38;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';
## no critic (Subroutines::ProhibitSubroutinePrototypes)

use Type::Params    qw(compile);
use Types::Standard qw(ArrayRef Int Str);

=pod

=head1 NAME

ch-1.pl - Sort Letters

=head1 SYNOPSIS

  perl ch-1.pl R E P L -- 3 2 1 4
  perl ch-1.pl   # runs the embedded tests

=head1 DESCRIPTION

Given two arrays C<@letters> and C<@weights>, return the letters sorted by
increasing weight (weight 1 first, then 2, ...), joined as a string.

=cut

my $ARR_CHECK = compile( ArrayRef [Str], ArrayRef [Int] );

sub sort_letters ($letters, $weights) {
    ( $letters, $weights ) = $ARR_CHECK->( $letters, $weights );
    die 'Expected arrays of the same length' if @$letters != @$weights;

    my @idx = sort { $weights->[$a] <=> $weights->[$b] } 0 .. $#$letters;
    return join '', map { $letters->[$_] } @idx;
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
    die "Usage: perl $0 <letters...> -- <weights...>\n" if !defined($sep) || $sep == 0 || $sep == $#args;

    my @letters = @args[ 0 .. $sep - 1 ];
    my @weights = map { 0 + $_ } @args[ $sep + 1 .. $#args ];

    my $out = sort_letters( \@letters, \@weights );
    say 'Input:  @letters = (' . join( ', ', map { "'$_'" } @letters ) . ')';
    say '        @weights = (' . join( ', ', @weights ) . ')';
    say "Output: $out";
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        {
            label   => 'Example 1',
            letters => [qw(R E P L)],
            weights => [ 3, 2, 1, 4 ],
            expected => 'PERL',
        },
        {
            label   => 'Example 2',
            letters => [qw(A U R K)],
            weights => [ 2, 4, 1, 3 ],
            expected => 'RAKU',
        },
        {
            label   => 'Example 3',
            letters => [qw(O H Y N P T)],
            weights => [ 5, 4, 2, 6, 1, 3 ],
            expected => 'PYTHON',
        },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        Test::More::is(
            sort_letters( $case->{letters}, $case->{weights} ),
            $case->{expected},
            $case->{label}
        );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 sort_letters($letters, $weights)

Returns the letters ordered by increasing weight.

=cut

