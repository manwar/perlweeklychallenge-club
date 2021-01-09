#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use lib '.';
use Tree;

my $x = Tree->new(1)->add_child(
          Tree->new(2)->add_child(
            Tree->new(4)->add_child(
              Tree->new(5)->add_child(
                Tree->new(6)
              )->add_child(
                Tree->new(7)
              )
            )
          )
        )->add_child(
          Tree->new(3)
        );
is( (join ' -> ', $x->flatten ), '1 -> 2 -> 4 -> 5 -> 6 -> 7 -> 3' );
is( (join ' -> ', $x->to_ll->flatten ), '1 -> 2 -> 4 -> 5 -> 6 -> 7 -> 3' );

done_testing();

