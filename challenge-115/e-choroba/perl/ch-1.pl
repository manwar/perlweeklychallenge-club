#!/usr/bin/perl
use warnings;
use strict;

sub can_chain {
    my ($s1, $s2) = @_;
    return substr($s1, -1) eq substr $s2, 0, 1
}

# Depth-first.
sub string_chain_df {
    my ($path, @strings) = @_;

    return can_chain(@$path[-1, 0]) unless @strings;

    my %tried;
    for my $i (0 .. $#strings) {
        my $string = $strings[$i];
        next if $tried{ substr($string, 0 , 1) . substr $string, -1 }++;

        next unless can_chain($path->[-1], $string);

        return 1
            if string_chain_df([@$path, $string],
                               @strings[0 .. $i - 1, $i + 1 .. $#strings]);
    }
    return 0
}

# Breadth-first.
sub string_chain_bf {
    my ($start, @strings) = @_;
    my @paths = ([$start, \@strings]);
    while (@paths) {
        my @next;
        for my $path (@paths) {
            my ($so_far, $remain) = @$path;
            return 1 if ! @$remain && can_chain(@$so_far[-1, 0]);

            my %tried;
            for my $i (0 .. $#$remain) {
                next if $tried{ substr($remain->[$i], 0 , 1)
                                . substr $remain->[$i], -1 }++;

                next unless can_chain($so_far->[-1], $remain->[$i]);

                push @next, [[@$so_far, $remain->[$i]],
                             [@$remain[0 .. $i - 1, $i + 1 .. $#$remain]]];
            }
        }
        @paths = @next;
    }
}

sub string_chain {
    my ($algorithm, @strings) = @_;

    my $first = shift @strings;
    $algorithm->([$first], @strings)
}

use Test::More;

for my $algorithm (\&string_chain_df, \&string_chain_bf) {
    is string_chain($algorithm, qw( abc dea cd )), 1, 'Example 1';
    is string_chain($algorithm, qw( ade cbd fgh )), 0, 'Example 2';

    is string_chain($algorithm, qw( AB BC CD BD DA )), 0, 'Two circles';
    is string_chain($algorithm, qw( AB BC CA AE EF FA )), 1, 'Smaller circle';
    is string_chain($algorithm, qw( AB BC BD DE DF FD EB CA )), 1, 'Branches';
    is string_chain($algorithm, qw( AB BA AB BA AB BA )), 1, 'Repeated';

    is string_chain($algorithm, qw( AB BA CD DE EF FG GH HI IJ JK KL LC ) x 6),
        0, 'Many circles';

    is string_chain($algorithm,
                    map {("!$_#", "#$_%", "%$_^", "^$_&",
                          "&$_*", "*$_(", "($_)", "){$_}!")
                     } 1 .. 3),
        1, 'Many connectable circles';
}

done_testing(16);

=head %tried

This hash is used in both algorithms to optimize their speed. It means all the
nodes A*B are identical to the algorithm: we can freely exchange one for
another; therefore, it's enough to only try one of them in the given position.

To see how slow and memory hungry BF becomes without it, run the last two tests
without it.

=cut
