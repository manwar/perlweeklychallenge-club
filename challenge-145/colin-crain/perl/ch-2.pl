#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       a-palindrome-grows-in-brooklyn.pl
#
#       I think the result here, of a new tool to find out all things
#       palindromic, is not really the most practical thing. However the
#       algorithm used to get there is quite interesting and novel.
# 
#       I say the algorithm is novel, and I mean it: its only a few years
#       old and represents a new data structure that solves the problem
#       with a remarkably efficient computational complxity.
# 
#       Consider it as two interwoven trees, one containing palidromic
#       segments and the other


#         ref:
#             https://www.geeksforgeeks.org/palindromic-tree-introduction-implementation/
            
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##


package PNode;
use Moo;

    has start       => ( is => 'rw' );
    has end         => ( is => 'rw' );
    has length      => ( is => 'rw' );
    has insert_link => ( is => 'rw',
                         default => sub { 
                            return { map { $_, 0 } ('a'..'z') } } );
    has suffix_link => ( is => 'rw' );


### ### ### main body

use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';

package main;
my $input = shift // 'amanaplanacanalpanama';  ## <-- input here
my @s = split //, $input;

my $root1 = PNode->new( length => -1, suffix_link => 1 );
my $root2 = PNode->new( length =>  0, suffix_link => 1 );

our @tree = ( undef, $root1, $root2 );

our $curr_node = 1;
our $node_ptr  = 2;

## traverse the string and insert each character into the structure
insert( $_ ) for keys @s;
  
## output 
say "all distinct palindromic substrings for ", @s, " : \n";
for my $i (3..$node_ptr) {
    print  $i-2, ") ";
    say substr $input, $tree[$i]->start, $tree[$i]->length;
}

 
  
sub insert( $idx ) {
## FIND MAX PALINDROME AT $idx  
    ## search for a node containing a substring such that the character at
    ## the current index plus the substring defined by the located node,
    ## plus the character again, is the maximum palindrome at idx:
    ## $s[$idx].X.$s[$idx] We iterate down the suffix link chain from
    ## $curr_node to find X 
    my $tmp = $curr_node;
    while (1) {
        my $curr_length = $tree[$tmp]->length;
        last if ($idx - $curr_length >= 1 and $s[$idx] eq $s[$idx - $curr_length - 1]) ;
        $tmp = $tree[$tmp]->suffix_link;
    }
  
    ## check to see whether palindrome string $s[$idx].X.$s[$idx] 
    ## already exists or not 
    if( $tree[$tmp]->insert_link->{ $s[$idx] } != 0 ) {
        ## substring already exists in the tree
        $curr_node = $tree[$tmp]->insert_link->{ $s[$idx] };
        return;
    }
  
  
## ADD NEW NODE AS CHILD OF X:
    ## parent link to new node position, weight as $s[$idx]
    $tree[$tmp]->insert_link->{ $s[$idx] } = ++$node_ptr ;

    ## create new node: start, end, length of substring
    $tree[$node_ptr] = PNode->new(
        length  => $tree[$tmp]->length + 2 ,
        end     => $idx ,
        start   => $idx - ($tree[$tmp]->length + 2)  + 1 ,
    );
  

## SET SUFFIX EDGE FOR NEW NODE
    ## Find some string Y such that
    ## $s[$idx].Y.$s[$idx] is longest possible
    ## palindromic suffix for newly created Node.
  
    $tmp = $tree[$tmp]->suffix_link;
  
    ## making new Node as current Node
    $curr_node = $node_ptr;
    if ($tree[$curr_node]->length == 1) {
        ## if new palindrome's lengthgth is 1
        ## making its suffix link to be null string
        $tree[$curr_node]->suffix_link( 2 );
        return;
    }
    while (1) {
        my $curr_lengthgth = $tree[$tmp]->length;
        last if ($idx - $curr_lengthgth >= 1 and $s[$idx] eq $s[$idx-$curr_lengthgth-1]) ;
        $tmp = $tree[$tmp]->suffix_link;
    }
  
    ## linking current PNode suffix_link with $s[$idx].Y.$s[$idx]
    $tree[$curr_node]->suffix_link( $tree[$tmp]->insert_link->{ $s[$idx] } );
}
  

