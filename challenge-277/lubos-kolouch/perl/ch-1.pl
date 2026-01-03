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

ch-1.pl - Count Common

=head1 SYNOPSIS

  perl ch-1.pl Perl is my friend -- Perl and Raku are friend
  perl ch-1.pl   # runs the embedded tests

=head1 DESCRIPTION

Given two arrays of strings, return the count of words that appear in both
arrays exactly once.

=cut

my $ARR_CHECK = compile( ArrayRef [Str], ArrayRef [Str] );

sub count_common ($words1, $words2) {
    ( $words1, $words2 ) = $ARR_CHECK->( $words1, $words2 );

    my %c1;
    $c1{$_}++ for @$words1;
    my %c2;
    $c2{$_}++ for @$words2;

    my $count = 0;
    for my $word ( keys %c1 ) {
        next if $c1{$word} != 1;
        next if ( $c2{$word} // 0 ) != 1;
        ++$count;
    }
    return $count;
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
    die "Usage: perl $0 <words1...> -- <words2...>\n" if !defined($sep) || $sep == 0 || $sep == $#args;

    my @w1 = @args[ 0 .. $sep - 1 ];
    my @w2 = @args[ $sep + 1 .. $#args ];

    my $out = count_common( \@w1, \@w2 );
    say 'Input:  @words1 = (' . join( ', ', map { qq{\"$_\"} } @w1 ) . ')';
    say '        @words2 = (' . join( ', ', map { qq{\"$_\"} } @w2 ) . ')';
    say "Output: $out";
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        {
            label  => 'Example 1',
            words1 => [qw(Perl is my friend)],
            words2 => [qw(Perl and Raku are friend)],
            expected => 2,
        },
        {
            label  => 'Example 2',
            words1 => [qw(Perl and Python are very similar)],
            words2 => [qw(Python is top in guest languages)],
            expected => 1,
        },
        {
            label  => 'Example 3',
            words1 => [ 'Perl', 'is', 'imperative', 'Lisp', 'is', 'functional' ],
            words2 => [qw(Crystal is similar to Ruby)],
            expected => 0,
        },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        Test::More::is(
            count_common( $case->{words1}, $case->{words2} ),
            $case->{expected},
            $case->{label}
        );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 count_common($words1, $words2)

Returns the count of words present exactly once in each array.

=cut

