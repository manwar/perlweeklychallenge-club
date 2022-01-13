#!/usr/bin/perl
use warnings;
use strict;

sub calculator {
    my ($expression) = @_;
    while ($expression =~ m{[ ()]}) {
        $expression =~ s/(-?\d+) (\*) (-?\d+)/$1 * $3/e;
        $expression =~ s/(-?\d+) ([-+]) (-?\d+)/"$1 $2 $3"/ee;
        $expression =~ s/\((-?\d+)\)/$1/g;
    }
    return $expression
}

use Marpa::R2;
my $dsl = << '__DSL__';

    lexeme default = latm => 1
    :default ::= action => ::first

    Expression ::= Number
                 | ('(') Expression (')')   assoc => group
                || Expression (ws asterisk ws) Expression  action => multiply
                || Expression (ws plus ws) Expression      action => add
                 | Expression (ws minus ws) Expression     action => subtract
    Number     ::= Negative | positive
    Negative   ::= minus positive                          action => neg

    ws       ~ [\s]+
    asterisk ~ '*'
    plus     ~ '+'
    positive ~ [\d]+
    minus    ~ '-'

__DSL__

sub add      { $_[1] + $_[2] }
sub subtract { $_[1] - $_[2] }
sub multiply { $_[1] * $_[2] }
sub neg      { -$_[2] }
sub second   { $_[2] }

my $grammar = 'Marpa::R2::Scanless::G'->new({source => \$dsl});

sub calculate {
    my ($input) = @_;
    return ${ $grammar->parse(\$input, 'main') }
}

use Test2::V0;
plan 8;

my %tests = (
    'Example 1' => ['10 + 20 - 5', 25],
    'Example 2' => ['(10 + 20 - 5) * 2', 50],
    Negative    => ['(1 + 2) - (1 * 12)', -9],
    Precedence  => ['((-1 - -2 - -3 * -4 + -5))', -16]);

for my $t (sort keys %tests) {
    is calculator($tests{$t}[0]), $tests{$t}[1], "regex $t";
    is calculate($tests{$t}[0]), $tests{$t}[1], "marpa $t";
}
