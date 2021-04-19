#!/usr/bin/perl
use warnings;
use strict;

sub four_squares {
    my @numbers = @_;
    my %at;
    undef $at{ $numbers[$_] }{$_} for 0 .. $#numbers;
    for my $A (0 .. $#numbers) {
        for my $C (0 .. $#numbers) {
            next if $A == $C || ! exists $at{ $numbers[$A] - $numbers[$C] };

            for my $D (keys %{ $at{ $numbers[$A] - $numbers[$C] } }) {
                next if grep $D == $_, $C, $A;

                for my $E (0 .. $#numbers) {
                    next if grep $E == $_, $A, $C, $D;

                    for my $G (keys %{ $at{ $numbers[$D] + $numbers[$E] } }) {
                        next if $numbers[$A] + $numbers[$E]
                                 != $numbers[$G] + $numbers[$C]
                             || grep $G == $_, $C, $A, $E, $D;

                        my %_rest;
                        @_rest{0 .. 6} = ();
                        delete @_rest{ $A, $C, $D, $E, $G };
                        my @rest = keys %_rest;

                        for my $r ([@rest], [reverse @rest]) {
                            my ($B, $F) = @$r;
                            return @numbers[$A, $B, $C, $D, $E, $F, $G]
                                if $numbers[$A] + $numbers[$B]
                                    == $numbers[$G] + $numbers[$F];
                        }
                    }
                }

            }
        }
    }
    return
}

use Test::More;

require Algorithm::Permute;
sub slow_fs {
    my @numbers = @_;
    my $p = 'Algorithm::Permute'->new(\@numbers);
    while (my @p = $p->next) {
        return @p if $p[0] + $p[1] == $p[1] + $p[2] + $p[3]
                  && $p[0] + $p[1] == $p[3] + $p[4] + $p[5]
                  && $p[0] + $p[1] == $p[5] + $p[6];
    }
    return
}

sub valid {
    my @r = @_;
    return $r[0] + $r[1] == $r[1] + $r[2] + $r[3]
        && $r[0] + $r[1] == $r[3] + $r[4] + $r[5]
        && $r[0] + $r[1] == $r[5] + $r[6]
}

for (1 .. 100) {
    my @N = map int rand 10, 1 .. 7;
    my @fs = four_squares(@N);
    my @s  = slow_fs(@N);
    is !!@fs, !!@s, "solvability @N";
    ok valid(@fs), "valid result" if @fs;
}

use Benchmark qw{ cmpthese };

my @S = 1 .. 7;
my @U = (0, 1, 2, 5, 6, 8, 9);
ok valid(four_squares(@S));
ok valid(slow_fs(@S));
ok ! four_squares(@U);
ok ! slow_fs(@U);

cmpthese(-3, {
    fast_solvable   => sub { four_squares(@S) },
    slow_solvable   => sub { slow_fs(@S) },
    fast_unsolvable => sub { four_squares(@U) },
    slow_unsolvable => sub { slow_fs(@U) },
});

done_testing();

=head1 Benchmark

                    Rate slow_unsolvable slow_solvable fast_unsolvable fast_solvable
 slow_unsolvable   577/s              --          -85%            -98%          -99%
 slow_solvable    3915/s            578%            --            -87%          -93%
 fast_unsolvable 30817/s           5238%          687%              --          -47%
 fast_solvable   57985/s           9944%         1381%             88%            --

=head1 Interesting cases

For some inputs, there are at least 2 different solutions with different sums.
Examples follow:

=over 2

=item 1 2 3 5 5 7 9


  5 5 3 2 7 1 9  (sum 10)
  3 9 1 2 5 5 7  (sum 12)

=item 1 2 3 4 5 8 9

  9 1 4 5 3 2 8  (sum 10)
  4 9 1 3 2 8 5  (sum 13)

=back

=cut
