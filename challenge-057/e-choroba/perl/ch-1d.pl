#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

use Marpa::R2;

sub invert {
    my ($tree) = @_;
    return $tree unless ref $tree;

    my ($root) = keys %$tree;
    $tree->{$root} =  [ reverse @{ $tree->{$root} } ];
    invert($_) for @{ $tree->{$root} };
}

sub serialise {
    my ($tree) = @_;
    return $tree unless ref $tree;

    my ($root) = keys %$tree;
    return "$root(" . join(',', map serialise($_), @{ $tree->{$root} }) . ')'
}


my $dsl = << '__DSL__';

lexeme default = latm => 1

Tree ::= node                              action => ::first
       | node ('(') Tree (',') Tree (')')  action => subtree
node ~ [0-9]+

__DSL__

sub subtree { +{ $_[1] => [ $_[2], $_[3] ] } }

my $grammar = 'Marpa::R2::Scanless::G'->new({ source => \$dsl });

chomp( my $input = <DATA> );
my $tree = ${ $grammar->parse(\$input, {semantics_package => 'main'}) };

invert($tree);

say serialise($tree);

__DATA__
1(2(4,5),3(6,7))
