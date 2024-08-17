#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

=head1 Two Interpretations

There are two interpretations that both fit to the examples given:

=over 4

=item 1.

The first character that appears for the second time is the answer.


=item 2.

The first character that appears for the second time B<and> doesn't appear any
more times is the answer.

=back

=cut

sub twice_appearance_1($str) {
    my %tally;
    for my $char (split //, $str) {
        return $char if 2 == ++$tally{$char};
    }
    return ""
}

sub twice_appearance_2($str) {
    my %tally;
    my @order;
    for my $char (split //, $str) {
        push @order, $char if 2 == ++$tally{$char};
    }
    for my $char (@order) {
        return $char if 2 == $tally{$char};
    }
    return ""
}

use Test::More tests => 2 * (3 + 2);

my @interpretation = qw( a d );

my $i = 0;
for my $twice_appearance(*twice_appearance_1{CODE}, *twice_appearance_2{CODE}) {
    is $twice_appearance->('acbddbca'), 'd', 'Example 1';
    is $twice_appearance->('abccd'), 'c', 'Example 2';
    is $twice_appearance->('abcdabbb'), 'a', 'Example 3';

    is $twice_appearance->('abcd'), "", 'Naught';
    is $twice_appearance->('abcdabcdabce'), $interpretation[$i++],
        "Interpretation $i";
}
