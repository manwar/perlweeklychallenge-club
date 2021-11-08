#!/usr/bin/perl
# The Weekly Challenge 129
# Task 2 Add Linked Lists
# Usage: $ ch-2.pl 

# From the Task description:
#... expecting a class representing linked list. 
# It should have methods to create a linked list 
# given list of single digit positive numbers (I) and 
# a method to add new member. (II) Also have a method 
# that takes 2 linked list objects and returns a 
# new linked list. (III) Finally a method to print the 
# linked list object in a user friendly format. (IV)

# methods in the class LinkedList perform required actions:
#   (I) create_list
#  (II) append_element
# (III) wk129_add_another_linked_list 
#  (IV) print 

use v5.12.0;
use warnings;
use Object::Pad 0.52;
use Object::Pad::SlotAttr::Isa;


class LLNode {
    has $next :reader :writer :param :Isa(LLNode) = undef;
    has $val :reader :writer :param = undef;

    method a_copy {
        return LLNode->new(val=>$self->val);
    }
}



class LinkedList {

    has $head_node :reader :writer :param :Isa(LLNode) = undef;



    method create_list {
        my @digit = @_;
        $head_node = LLNode->new(val => $digit[0]);

        my $p = $head_node;
        for my $t (1..$#digit) {
            $p->set_next(LLNode->new(val=>$digit[$t]));
            $p = $p->next;
        }
    }


    method append_element { 
        # an O(N) operation, seldom used
        my $dgt = $_[0];
        my $p = $head_node;
        while (defined($p->next)) {
            $p = $p->next;
        }
        $p->set_next( LLNode->new(val=>$dgt) );
    }


    method a_reverse_linked_list {
        my $rvrs = LinkedList->new();
        my @stack;
        my $p = $head_node;
        push @stack, $p->a_copy;
        $p = $p->next;
        while (defined($p)) {
            push @stack, $p->a_copy;
            $p = $p->next;
        }

        my $t = pop @stack;
        $rvrs->set_head_node( $t );
        while (scalar @stack > 0) {
            $t->set_next($stack[-1]);
            $t = pop @stack;
        }
        return $rvrs;           
    }



    method a_reverse_linked_list_with_carriers {
        my $rvrs = LinkedList->new();

        my @stack;
        my $p = $head_node;
        my $carrier = 0;
        while (defined($p)) {
            my $temp_val = $p->val+$carrier; 
            if ($temp_val >= 10) {
                $temp_val -= 10;
                $carrier = 1;
            }
            else {
                $carrier = 0;
            }
            push @stack, LLNode->new(val=>$temp_val);
            $p = $p->next;
        }

        my $t = pop @stack;
        $rvrs->set_head_node( $t );
        while (scalar @stack > 0) {
            $t->set_next($stack[-1]);
            $t = pop @stack;
        }

        if ($carrier == 1) {
            warn "WARNING: Should \"1\" be the head node of linked list?\n";
        }

        return $rvrs;           
    }



    method directly_add_another_linked_list {
        my $sum = LinkedList->new();
        my $another = $_[0];
        my $s = $self->head_node;
        my $a = $another->head_node;
        $sum->set_head_node(LLNode->new( val => $s->val + $a->val ));
        my $p = $sum->head_node;
        while (defined($s->next) && defined($a->next)) {
            $s = $s->next;
            $a = $a->next;
            $p->set_next( LLNode->new( val => $s->val + $a->val ) );
            $p = $p->next;
        }
        while (defined($s->next)) {
            $s = $s->next;
            $p->set_next( LLNode->new( val => $s->val ) );
            $p = $p->next;
        }
        while (defined($a->next)) {
            $a = $a->next;
            $p->set_next( LLNode->new( val => $a->val ) );
            $p = $p->next;
        }
        return $sum;
    }



    method wk129_add_another_linked_list {
        return   $self->a_reverse_linked_list
              ->directly_add_another_linked_list(
                  $_[0]->a_reverse_linked_list
                )
              ->a_reverse_linked_list_with_carriers;
    }



    method print {
        my $p = $head_node;
        print $p->val;
        while (defined($p = $p->next)) { 
            print "->", $p->val;
        }
        print "\n";
    }



}

say "Example 1";

my $ex1_L1 = LinkedList->new();
my $ex1_L2 = LinkedList->new();

$ex1_L1->create_list(1,2,3);
$ex1_L2->create_list(3,2,1);
print " L1: "; $ex1_L1->print;
print " L2: "; $ex1_L2->print;
print "sum: ";
$ex1_L1->wk129_add_another_linked_list($ex1_L2)->print;
say "";

say "Example 2";

my $ex2_L1 = LinkedList->new();
my $ex2_L2 = LinkedList->new();

$ex2_L1->create_list(1,2,3,4,5);
$ex2_L2->create_list(6,5,5);

print " L1: "; $ex2_L1->print;
print " L2: "; $ex2_L2->print;
print "sum: ";
$ex2_L1->wk129_add_another_linked_list($ex2_L2)->print;
say "";

say "Test case 1";

my $test1_L1 = LinkedList->new();
my $test1_L2 = LinkedList->new();

$test1_L1->create_list(9, 3);
$test1_L2->create_list(5);
$test1_L2->append_element(5);

print " L1: "; $test1_L1->print;
print " L2: "; $test1_L2->print;
print "sum: ";
$test1_L1->wk129_add_another_linked_list($test1_L2)->print;

say "";

say "Test case 2";

my $test2_L1 = LinkedList->new();
my $test2_L2 = LinkedList->new();

$test2_L1->create_list(1, 4, 2, 8, 5, 7);
$test2_L2->create_list(8, 5, 7, 1, 4, 2);

print " L1: "; $test2_L1->print;
print " L2: "; $test2_L2->print;
print "sum: ";
$test2_L1->wk129_add_another_linked_list($test2_L2)->print;

say "";
