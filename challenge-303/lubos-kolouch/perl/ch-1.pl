#!/usr/bin/env perl
use v5.38;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';
## no critic (Subroutines::ProhibitSubroutinePrototypes)

use List::Util      qw(uniq);
use Type::Params    qw(compile);
use Types::Standard qw(ArrayRef Int);

=pod

=head1 NAME

ch-1.pl - 3-digits Even

=head1 SYNOPSIS

  perl ch-1.pl 2 1 3 0
  perl ch-1.pl   # runs the embedded tests

=head1 DESCRIPTION

Return all distinct even 3-digit integers that can be formed using the digits
from the input list. Each input element can be used at most as many times as it
appears in the list.

=cut

my $LIST_CHECK = compile( ArrayRef [Int] );

sub three_digits_even ($ints) {
    ($ints) = $LIST_CHECK->($ints);
    die 'Need at least 3 digits' if @$ints < 3;
    die 'Expected digits 0..9' if grep { $_ < 0 || $_ > 9 } @$ints;

    my %count;
    $count{$_}++ for @$ints;

    my @out;
    for my $a ( 1 .. 9 ) {    # hundreds place cannot be 0
        next if !$count{$a};
        $count{$a}--;
        for my $b ( 0 .. 9 ) {
            next if !$count{$b};
            $count{$b}--;
            for my $c ( 0, 2, 4, 6, 8 ) {
                next if !$count{$c};
                push @out, 100 * $a + 10 * $b + $c;
            }
            $count{$b}++;
        }
        $count{$a}++;
    }

    @out = sort { $a <=> $b } uniq(@out);
    return \@out;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    my @ints = map { 0 + $_ } @args;
    my $out  = three_digits_even( \@ints );
    say 'Input:  @ints = (' . join( ', ', @ints ) . ')';
    say 'Output: (' . join( ', ', @$out ) . ')';
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        {
            label    => 'Example 1',
            ints     => [ 2, 1, 3, 0 ],
            expected => [ 102, 120, 130, 132, 210, 230, 302, 310, 312, 320 ],
        },
        {
            label    => 'Example 2',
            ints     => [ 2, 2, 8, 8, 2 ],
            expected => [ 222, 228, 282, 288, 822, 828, 882 ],
        },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        my $got = three_digits_even( $case->{ints} );
        Test::More::is_deeply( $got, $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 three_digits_even($ints)

Returns an array reference of all distinct even 3-digit integers constructible
from the given digits.

=cut
