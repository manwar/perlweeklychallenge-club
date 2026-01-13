#!/usr/bin/env perl
use v5.38;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';
## no critic (Subroutines::ProhibitSubroutinePrototypes)

use Type::Params    qw(compile);
use Types::Standard qw(Int);

=pod

=head1 NAME

ch-1.pl - Kolakoski Sequence

=head1 SYNOPSIS

  perl ch-1.pl 8
  perl ch-1.pl   # runs the embedded tests

=head1 DESCRIPTION

Generate the Kolakoski sequence of length n (n > 3) and return the count
of '1' in the generated sequence.

=cut

my $INT_CHECK = compile(Int);

sub kolakoski_ones ($n) {
    ($n) = $INT_CHECK->($n);
    die 'Expected n > 3' if $n <= 3;

    my @seq = ( 1, 2, 2 );
    my $read_idx = 2;
    my $next_val = 1;

    while ( @seq < $n ) {
        my $run = $seq[$read_idx++];
        push @seq, ($next_val) x $run;
        $next_val = $next_val == 1 ? 2 : 1;
    }

    splice @seq, $n if @seq > $n;
    my $count = 0;
    $count++ for grep { $_ == 1 } @seq;
    return $count;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    die "Usage: perl $0 <int>\n" if @args != 1;
    my $n = 0 + $args[0];
    my $out = kolakoski_ones($n);
    say "Input:  \$int = $n";
    say "Output: $out";
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { label => 'Example 1', n => 4, expected => 2 },
        { label => 'Example 2', n => 5, expected => 3 },
        { label => 'Example 3', n => 6, expected => 3 },
        { label => 'Example 4', n => 7, expected => 4 },
        { label => 'Example 5', n => 8, expected => 4 },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        Test::More::is( kolakoski_ones( $case->{n} ), $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 kolakoski_ones($n)

Returns the number of ones in the first C<$n> elements of the Kolakoski sequence.

=cut

