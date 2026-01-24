#!/usr/bin/env perl
use v5.38;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';

=pod

=head1 NAME

ch-2.pl - Hash Join

=head1 SYNOPSIS

  perl ch-2.pl        # runs the embedded tests
  perl ch-2.pl run    # prints the example join rows

=head1 DESCRIPTION

Implement a classic hash join between two relations (arrays of arrayrefs).
The build input is hashed by a chosen index, then the probe input is scanned to
produce matching joined rows.

=cut

sub hash_join ( $build, $probe, $build_index, $probe_index ) {
    my %build_map;
    for my $row (@$build) {
        push @{ $build_map{ $row->[$build_index] } }, $row;
    }

    my %probe_map;
    my @key_order;
    my %seen;
    for my $row (@$probe) {
        my $key = $row->[$probe_index];
        push @{ $probe_map{$key} }, $row;
        if ( !$seen{$key}++ ) {
            push @key_order, $key;
        }
    }

    my @out;
    for my $key (@key_order) {
        next if !exists $build_map{$key};
        for my $b ( @{ $build_map{$key} } ) {
            for my $p ( @{ $probe_map{$key} } ) {
                push @out, [ @$b, @$p[ 1 .. $#$p ] ];
            }
        }
    }
    return \@out;
}

sub _example_data () {
    my @player_ages = (
        [ 20, "Alex" ],
        [ 28, "Joe" ],
        [ 38, "Mike" ],
        [ 18, "Alex" ],
        [ 25, "David" ],
        [ 18, "Simon" ],
    );

    my @player_names = (
        [ "Alex", "Stewart" ],
        [ "Joe",  "Root" ],
        [ "Mike", "Gatting" ],
        [ "Joe",  "Blog" ],
        [ "Alex", "Jones" ],
        [ "Simon", "Duane" ],
    );

    return ( \@player_ages, \@player_names );
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my ( $ages, $names ) = _example_data();
    my $got = hash_join( $ages, $names, 1, 0 );

    my $expected = [
        [ 20, "Alex",  "Stewart" ],
        [ 20, "Alex",  "Jones" ],
        [ 18, "Alex",  "Stewart" ],
        [ 18, "Alex",  "Jones" ],
        [ 28, "Joe",   "Root" ],
        [ 28, "Joe",   "Blog" ],
        [ 38, "Mike",  "Gatting" ],
        [ 18, "Simon", "Duane" ],
    ];

    Test::More::plan( tests => 1 );
    Test::More::is_deeply( $got, $expected, 'Example' );
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    die "Usage: perl $0 run\n" if @args != 1 || $args[0] ne 'run';

    my ( $ages, $names ) = _example_data();
    my $rows = hash_join( $ages, $names, 1, 0 );
    say qq{Based on index = 1 of \@players_age and index = 0 of \@players_name.};
    say join( ', ', map { qq{"$_"} } @$_ ) for @$rows;
}

_run_cli(@ARGV);
