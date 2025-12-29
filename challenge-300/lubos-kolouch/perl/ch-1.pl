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

ch-1.pl - Beautiful Arrangement

=head1 SYNOPSIS

  perl ch-1.pl 2
  perl ch-1.pl   # runs the embedded tests

=head1 DESCRIPTION

Counts the number of permutations of 1..n such that for every position i
(1-indexed), either perm[i] is divisible by i or i is divisible by perm[i].

Uses backtracking with a bitmask and precomputed allowed values per position.

=cut

my $INT_CHECK = compile(Int);

sub beautiful_arrangements ($n) {
    ($n) = $INT_CHECK->($n);
    die 'Expected a positive integer' if $n <= 0;

    my @allowed;
    for my $pos ( 1 .. $n ) {
        $allowed[$pos] = [ grep { $_ % $pos == 0 || $pos % $_ == 0 } 1 .. $n ];
    }

    my %memo;
    my $full_mask = ( 1 << $n ) - 1;

    my $dfs;
    $dfs = sub ($pos, $mask) {
        return 1 if $pos > $n;
        my $key = "$pos:$mask";
        return $memo{$key} if exists $memo{$key};

        my $count = 0;
        for my $val ( @{ $allowed[$pos] } ) {
            my $bit = 1 << ( $val - 1 );
            next if ( $mask & $bit ) == 0;
            $count += $dfs->( $pos + 1, $mask ^ $bit );
        }

        return $memo{$key} = $count;
    };

    return $dfs->( 1, $full_mask );
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    die "Usage: perl $0 <n>\n" if @args != 1;
    my $n = 0 + $args[0];
    my $out = beautiful_arrangements($n);
    say "Input: \$n = $n";
    say "Output: $out";
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { label => 'Example 1', n => 2,  expected => 2 },
        { label => 'Example 2', n => 1,  expected => 1 },
        { label => 'Example 3', n => 10, expected => 700 },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        Test::More::is( beautiful_arrangements( $case->{n} ), $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 beautiful_arrangements($n)

Returns the number of beautiful arrangements for size C<$n>.

=cut
