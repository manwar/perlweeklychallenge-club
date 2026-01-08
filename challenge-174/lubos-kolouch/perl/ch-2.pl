#!/usr/bin/env perl
use v5.38;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';
## no critic (Subroutines::ProhibitSubroutinePrototypes)

use Type::Params    qw(compile);
use Types::Standard qw(ArrayRef Int);

=pod

=head1 NAME

ch-2.pl - Permutation Ranking

=head1 SYNOPSIS

  perl ch-2.pl 1 0 2
  perl ch-2.pl   # runs the embedded tests

=head1 DESCRIPTION

Implement:

- permutation2rank(list): rank of the permutation in lexicographic order,
  starting at 0.
- rank2permutation(alphabet, rank): permutation at a given rank.

=cut

my $ARR_CHECK = compile( ArrayRef [Int] );
my $RANK_CHECK = compile( ArrayRef [Int], Int );

sub _factorials ($n) {
    my @f = (1);
    for my $i ( 1 .. $n ) {
        $f[$i] = $f[ $i - 1 ] * $i;
    }
    return \@f;
}

sub permutation2rank ($perm) {
    ($perm) = $ARR_CHECK->($perm);
    my @items = sort { $a <=> $b } @$perm;
    my %pos;
    @pos{@items} = ( 0 .. $#items );

    my $n = scalar @items;
    my $fact = _factorials($n);
    my @avail = @items;
    my $rank = 0;

    for my $i ( 0 .. $n - 1 ) {
        my $x = $perm->[$i];
        my ($idx) = grep { $avail[$_] == $x } 0 .. $#avail;
        $rank += $idx * $fact->[ $n - 1 - $i ];
        splice @avail, $idx, 1;
    }
    return $rank;
}

sub rank2permutation ($alphabet, $rank) {
    ( $alphabet, $rank ) = $RANK_CHECK->( $alphabet, $rank );
    my @avail = sort { $a <=> $b } @$alphabet;
    my $n = scalar @avail;
    my $fact = _factorials($n);
    my $max_rank = $fact->[$n] - 1;
    die "Rank out of range" if $rank < 0 || $rank > $max_rank;

    my @out;
    my $r = $rank;
    for my $i ( reverse 1 .. $n ) {
        my $f = $fact->[ $i - 1 ];
        my $idx = int( $r / $f );
        $r = $r % $f;
        push @out, splice @avail, $idx, 1;
    }
    return \@out;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    my @perm = map { 0 + $_ } @args;
    my $rank = permutation2rank( \@perm );
    say "Input:  [" . join( ', ', @perm ) . "]";
    say "Output: $rank";
}

sub _run_tests {
    require Test::More;
    Test::More->import;
    Test::More::plan( tests => 2 );

    Test::More::is( permutation2rank( [ 1, 0, 2 ] ), 2, 'Example: permutation2rank([1,0,2])' );
    Test::More::is_deeply( rank2permutation( [ 0, 1, 2 ], 1 ), [ 0, 2, 1 ], 'Example: rank2permutation([0,1,2],1)' );
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 permutation2rank($perm)

Returns the lexicographic rank (0-based).

=head2 rank2permutation($alphabet, $rank)

Returns the permutation at the given rank.

=cut

