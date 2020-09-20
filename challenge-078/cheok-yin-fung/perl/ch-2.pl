#!/usr/bin/perl
# The Weekly Challenge - Perl & Raku #078 Task 2
# learn the usage of Struct::Dumb to create a linked list 
# use Struct to make the circular list
# ref: by Wanderdoc, ch-2.pl for challenge #071
# (A nested hash was used by me for 
# solving the singly linked list in #071
# but this method cannot port as a circular linked list )
# Usage ch-2.pl [size of @A] [@A] [size of @B] [@B]

use strict;
use warnings;
use Struct::Dumb qw( -named_constructors );
use Scalar::Util qw(refaddr);

struct Node => [ qw( val next ) ];


my @A, my @B, my $sizea, my $sizeb;

sub getinput {
    $sizea = $ARGV[0];
    @A = @ARGV[1..$sizea];
    $sizeb = $ARGV[$sizea+1];
    @B = @ARGV[($sizea+2)..($sizea+$sizeb+1)];
}


if ($ARGV[0]) { 
    getinput; } else {
    @A = (10, 20, 30, 40, 50); 
    @B = (3, 4)  ;
    $sizea = scalar @A;
}


sub create_circ_list {
    
    my @v = @_; 
    my $sizev = scalar @v;

    my $head = Node( val => $v[0], next => undef );
    my $coming = \($head->next);
    my $node;

    for (1..$sizev-2) {
        $node = Node( val => $v[$_], next => undef );
        $$coming = $node;
        $coming = \($node->next);
    }

    my $endnode = Node( val => $v[$sizev-1], next => undef);
    $$coming = $endnode;
    $coming = \($endnode->next);
    $$coming = $head;

    return \$head;
}


my $door = create_circ_list( @A );


=pod
sub print_original_list {
    my $d = $_[0];
    while ($d->next) {
        print $d->val;
        $d = $d->next;
    }
}
print_original_list(${$door});  #get into an infinite loop 
=cut

sub print_circular_list {
    my $d = $_[0];

    for (0..($sizea-1)) {
        print $d->val;
        print " ";
        $d = $d->next;
    }
}


print "original list: \n";
print_circular_list(${$door});
print "\n -------------- \n";
print "\@B: " , join " ", @B;
print "\n";

sub rotated {    
    my $start_index = $_[0];

    my $d = $$door;
    for (1..$start_index-1) {
        $d = $d->next;
    }

    for (0..($sizea-1)) {
        $d = $d->next;
        print $d->val, " ";
    }
}

for my $s (@B) {
    rotated($s);
    print "\n";
}
