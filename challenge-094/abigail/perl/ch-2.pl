#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

#
# Run as "perl ch-2.pl < ../t/input-2-X", for suitable X.
#

#
# A bit of a silly exercise to turn a tree into a linked list, then just
# print the linked list. The linked list feels like a pointless detour;
# traversing the tree inorderly leads to the same result.
#

my $T_LEFT  = 0;
my $T_VALUE = 1;
my $T_RIGHT = 2;
my $L_VALUE = 0;
my $L_NEXT  = 1;

#
# Turn the tree into a linked list; returns the head and end of the linked list.
#
sub inorder ($tree) {
    return unless @$tree;   # Leaf, so no list.
    
    #
    # Recurse
    #
    my ($left_head,  $left_tail)  = inorder ($$tree [$T_LEFT]);
    my ($right_head, $right_tail) = inorder ($$tree [$T_RIGHT]);

    #
    # Create head of list; let tail point to this.
    #
    my $head = [];
      $$head [$L_VALUE] = $$tree [$T_VALUE];
    my $tail = $head;

    #
    # If either child is non-empty, add this to the list; update
    # the tail if necessary.
    #
    if ($left_head) {
        $$tail [$L_NEXT] = $left_head;
        $tail            = $left_tail;
    }
    if ($right_head) {
        $$tail [$L_NEXT] = $right_head;
        $tail            = $right_tail;
    }

    #
    # Return head and tail
    #
    ($head, $tail);
}

#
# Flatten a linked list, recursively.
#
sub flatten ($list) {
    $list ? ($$list [$L_VALUE], flatten ($$list [$L_NEXT])) : ();
}

#
# Print the list: first flatten it, then print the result.
#
sub print_ll ($list) {
    say join " -> " => flatten $list;
}

#
# Did not want to parse the input as given in the example, it is not enough
# to deduce how the input looks like in general -- for instance, if we have
# a root with two children, which each has two children, how is it going to
# look? 
#
# So, we're assuming the following grammar for a tree, in pseudo BNF:
#
#     value = [0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9] +
#     tree  = '[' [ <tree> <value> <tree> ] ']'
#
# That is, leaf nodes look like '[]', and regular nodes consist of a tree,
# followed by a value, followed by a tree, all surrounded by brackets.
#

while (<>) {
    chomp;
    my $count = 0;
    my %cache;
    #
    # Parse the input, build a tree bottom to top.
    #
    # As long as we have something of the form:
    #
    #     [] or
    #     [ Tnnn vvv Tmmm],  where Tnnn/Tmmm are a "T" followed by a
    #                        number, and vvv a value
    #
    # we replace it by Tppp, where ppp is the next available number. We also
    # add an entry Tppp to a cache, where $cache {Tppp} = [] in the former case,
    # and $cache {Tppp} = [$cache {Tnnn}, vvv, $cache {Tmmm}] in the latter.
    #
    1 while s {\[ \s* (?:(T[0-9]+) \s+ ([0-9]+) \s+ (T[0-9]+))? \s* \]}
              { $count ++;
                $cache {"T$count"} = $1 ? [$cache {$1}, $2, $cache {$3}] : [];
               "T$count"}ex;
    #
    # Final tree is now in the cache with key "T$count".
    #
    print_ll +(inorder $cache {"T$count"}) [0];  # Inorder returns two values,
                                                 # we need only the first one.
}

__END__
