#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

#
# See ../README.md
#

#
# Run as: perl ch-2.pl < input-file
#

package Tree {
    use Hash::Util::FieldHash qw [fieldhash];
    use List::Util            qw [max];

    fieldhash my %left;
    fieldhash my %right;
    
    sub new ($class) {bless do {\my $var} => $class}

    sub init ($self, $input) {
        #
        # Initialize a tree given the input following the
        # specification of how we're given a tree.
        #

        ...;   # <-- This is the yada, yada, yada operator, typically
               #     a placeholder for code which still needs to be written.
               #     Perfect! Once we have a specification of how the
               #     the input is structured (other than a single example
               #     of which anyone can instantly see it doesn't scale
               #     beyond trivial sizes), we can replace this piece of code.
               #
               # This does mean though, that rest of the code is largely
               # untested. "It compiles" is the best we can do.
               #

        $self;
    }

    #
    # Get the left and right child of a tree. Leaves obviously
    # don't have children.
    #
    sub left  ($self) {$self && $left  {$self}}
    sub right ($self) {$self && $right {$self}}

    sub diameter ($self) {
        ($self -> _diameter ($self)) [1]
    }

    sub _diameter ($self) {
        #
        # Given a tree, return a tuple ($depth, $diameter), where
        # first element is the depth of a tree (longest path to a leaf),
        # and second the diameter (longest path in the tree).
        #
        # Depth of a tree is 1 + max (depth left child, depth right child)
        # Diameter of a tree is max (diameter left child,
        # diameter right child, depth left child + depth right child).
        #
        return (0, 0) unless $self;  # Leaves have no depth nor diameter.
        my ($ldp, $ldm) = $self -> left  -> _diameter;
        my ($rdp, $rdm) = $self -> right -> _diameter;
        (max ($ldp, $rdp), max ($ldm, $rdm, $ldp + $rdp))
    }
}


say Tree:: -> new -> init (do {local $/; <>}) -> diameter;
