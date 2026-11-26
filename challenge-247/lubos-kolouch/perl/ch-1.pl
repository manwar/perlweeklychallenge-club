#!/usr/bin/env perl
use v5.38;
use warnings;
use List::Util qw(shuffle);
use Type::Params -sigs;
use Types::Standard qw(ArrayRef Str);
use Test::More;

=head1 NAME

ch-1.pl - Secret Santa

=head1 SYNOPSIS

    perl ch-1.pl

=head1 DESCRIPTION

Solution for The Weekly Challenge 247, Task 1: Secret Santa.
Randomly pairs participants into a gift-giving cycle while minimizing
assignments between members of the same family.

=head1 FUNCTIONS

=head2 family_name($name)

Extracts the family name (trailing word) from a participant's full name.

=head2 secret_santa($names)

Takes an array reference of participant names and returns a hash reference
mapping each giver to a receiver, avoiding same-family pairs whenever
possible.

=cut

signature_for family_name => (
    method     => 0,
    positional => [Str],
);

sub family_name ($name) {
    my ($family) = $name =~ m/(\w+)\z/msx;
    return $family // $name;
}

signature_for secret_santa => (
    method     => 0,
    positional => [ ArrayRef [Str] ],
);

sub secret_santa ($names) {
    my $n = scalar @{$names};
    return {} if $n == 0;

    my @shuffled = shuffle @{$names};
    my %by_family;
    for my $name (@shuffled) {
        push @{ $by_family{ family_name($name) } }, $name;
    }

    my @families = sort {
        scalar @{ $by_family{$b} } <=> scalar @{ $by_family{$a} }
            || $a cmp $b
    } keys %by_family;

    my @ordered = map { @{ $by_family{$_} } } @families;
    my @circle;
    my $idx = 0;
    for my $pos ( grep { $_ % 2 == 0 } 0 .. $n - 1 ) {
        $circle[$pos] = $ordered[ $idx++ ];
    }
    for my $pos ( grep { $_ % 2 == 1 } 0 .. $n - 1 ) {
        $circle[$pos] = $ordered[ $idx++ ];
    }

    my %assignments;
    for my $i ( 0 .. $n - 1 ) {
        $assignments{ $circle[$i] } = $circle[ ( $i + 1 ) % $n ];
    }

    return \%assignments;
}

sub _same_family_count ($assignments) {
    my $count = 0;
    for my $giver ( keys %{$assignments} ) {
        my $receiver = $assignments->{$giver};
        $count++ if family_name($giver) eq family_name($receiver);
    }
    return $count;
}

my @ex1  = ( 'Mr. Wall', 'Mrs. Wall', 'Mr. Anwar', 'Mrs. Anwar', 'Mr. Conway', 'Mr. Cross' );
my $res1 = secret_santa( \@ex1 );
is( scalar keys %{$res1}, 6, 'Example 1: all 6 participants are givers' );
is_deeply( [ sort values %{$res1} ], [ sort @ex1 ], 'Example 1: all 6 participants are receivers' );
is( ( grep { $_ eq $res1->{$_} } keys %{$res1} ), 0, 'Example 1: no self-assignments' );
is( _same_family_count($res1), 0, 'Example 1: no same-family pairs' );

my @ex2  = ( 'Mr. Wall', 'Mrs. Wall', 'Mr. Anwar' );
my $res2 = secret_santa( \@ex2 );
is( scalar keys %{$res2}, 3, 'Example 2: all 3 participants are givers' );
is_deeply( [ sort values %{$res2} ], [ sort @ex2 ], 'Example 2: all 3 participants are receivers' );
is( ( grep { $_ eq $res2->{$_} } keys %{$res2} ), 0, 'Example 2: no self-assignments' );
is( _same_family_count($res2), 1, 'Example 2: exactly 1 unavoidable same-family pair' );

done_testing();
