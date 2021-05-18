#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use lib '.';
use Tree;

my $x = Tree->new(1)->add_child(
          Tree->new(2)->add_child(
            Tree->new(4)->add_child( Tree->new(7) )
          )
        )->add_child(
          Tree->new(3)->add_child( Tree->new(5))->add_child( Tree->new(6) )
        );

my $data  = { 't' => 0 };

## Clone $x into $y
my $clone = { 'tree' => undef };
$x->walk( sub { my( $node, $global, $local ) = @_;
  if($global->{'tree'}) {
    my $child = Tree->new( $node->[0] );
    $local->add_child( $child );
    return $child;
  }
  $global->{'tree'} = Tree->new( $node->[0] );
  return $global->{'tree'};
}, $clone );
my $y = $clone->{'tree'};
say '';
say 'Dump $x';
$x->walk( sub { my( $node, $global, $local ) = @_; say $local||='', '> ', $node->[0]; return $local.='  '; }, $data, '  ' );
say '';
say 'Dump $y (clone of $x)';
$y->walk( sub { my( $node, $global, $local ) = @_; say $local||='', '> ', $node->[0]; return $local.='  '; }, $data, '  ' );
say '';
say 'Now get total value and adjust each node... for $y';
$y->walk( sub { my( $node, $global         ) = @_; $global->{'t'} += $node->[0];                           }, $data );
$y->walk( sub { my( $node, $global         ) = @_; $node->[0] = $global->{'t'} - $node->[0];               }, $data );
say '';
say 'Dump $y (clone of $x)';
$y->walk( sub { my( $node, $global, $local ) = @_; say $local||='', '> ', $node->[0]; return $local.='  '; }, $data, '  ' );
say '';

say 'Running tests';
is( "@{[ $x->flatten ]}", '1 2 4 7 3 5 6' );
is( "@{[ $y->flatten ]}", '27 26 24 21 25 23 22' );
done_testing();
say '';

