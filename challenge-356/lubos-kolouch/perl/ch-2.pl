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

ch-2.pl - Who Wins

=head1 SYNOPSIS

  perl ch-2.pl HAHAHH
  perl ch-2.pl   # runs the embedded tests

=head1 DESCRIPTION

Given a 6-character string of 'H'/'A' representing winners of each playoff game,
determine which two teams played in the conference final (game 6) and who won.

=cut

my $STR_CHECK = compile(Str);

sub who_wins ($results) {
    ($results) = $STR_CHECK->($results);
    die 'Expected a 6-character string of H/A' if $results !~ /\A[HA]{6}\z/;

    my @r = split //, $results;

    # Week 1
    my $w1 = $r[0] eq 'H' ? 2 : 7;
    my $w2 = $r[1] eq 'H' ? 3 : 6;
    my $w3 = $r[2] eq 'H' ? 4 : 5;
    my @w = sort { $a <=> $b } ( $w1, $w2, $w3 );

    # Week 2 game 4: Team 1 hosts the third seeded winner => max seed number
    my $t4_away = $w[2];
    my $w4 = $r[3] eq 'H' ? 1 : $t4_away;
    my @rem = ( $w[0], $w[1] );

    # Week 2 game 5: highest seeded winner hosts the second seeded winner
    my ($host5, $away5) = $rem[0] < $rem[1] ? ( $rem[0], $rem[1] ) : ( $rem[1], $rem[0] );
    my $w5 = $r[4] eq 'H' ? $host5 : $away5;

    # Week 3 game 6: highest seeded winner hosts the other winner
    my ($host6, $away6) = $w4 < $w5 ? ( $w4, $w5 ) : ( $w5, $w4 );
    my $w6 = $r[5] eq 'H' ? $host6 : $away6;

    return ( $host6, $away6, $w6 );
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    die "Usage: perl $0 <results>\n" if @args != 1;
    my $results = $args[0];
    my ( $host6, $away6, $winner ) = who_wins($results);
    my $loser = $winner == $host6 ? $away6 : $host6;
    say sprintf 'Team %d defeated Team %d', $winner, $loser;
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { label => 'Example 1', results => 'HAHAHH', expected => 'Team 2 defeated Team 6' },
        { label => 'Example 2', results => 'HHHHHH', expected => 'Team 1 defeated Team 2' },
        { label => 'Example 3', results => 'HHHAHA', expected => 'Team 4 defeated Team 2' },
        { label => 'Example 4', results => 'HAHAAH', expected => 'Team 4 defeated Team 6' },
        { label => 'Example 5', results => 'HAAHAA', expected => 'Team 5 defeated Team 1' },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        my ( $host6, $away6, $winner ) = who_wins( $case->{results} );
        my $loser = $winner == $host6 ? $away6 : $host6;
        my $got = sprintf 'Team %d defeated Team %d', $winner, $loser;
        Test::More::is( $got, $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 who_wins($results)

Returns (home_team, away_team, winner_team) for the conference final.

=cut

