#!/usr/bin/perl
# Perl Weekly Challenge 071 Task 2
# 
# ref: http://rosettacode.org/wiki/Linked_list#Singly-Linked_List
#
# Usage: ch-2.pl [ITEMS in the list] [$N]

use Data::Dumper;
use strict;
use warnings;

my @input;
my $N;
my @last_np1th_ref = ();

@input = (5,6,3,2);
$N = 3;

if ($ARGV[0] and $ARGV[1]) {
    $N = pop @ARGV;
    @input = @ARGV; 
}

sub insert_after {
    my $node = $_[0];
    my $next = $node->{_next};
    shift;
    while (defined $_[0]) {
        $node->{_next} = $_[0];
        $node = $node->{_next};
        shift;
    }
    $node->{_next} = $next;
}

sub stored_np1th_ref_from_tail {
    push @last_np1th_ref, $_[0];
    if ( $#last_np1th_ref > $N) {
        shift @last_np1th_ref;
    }
}

my $list = {value => 'HEAD'};

sub insert_input {
    for my $v (reverse @input) {          #why need reverse here? 
        insert_after $list, { value=> $v};
    }
}

sub print_linked_list {
#    print "HEAD->";
    my $node = $list->{_next};
    print $node->{value}, "->";
        while ($node = $node->{_next}) {
        print $node->{value};
        print "->"
    }
    print "nil";
    print "\n";
}

insert_input;
print_linked_list;

print "The '$N'-th node counted from the tail will be deleted. \n";

my $size = 0;
my $f = $list;
while (defined(my $x = $f->{_next})) {
    $size++;
    stored_np1th_ref_from_tail( \$x );
    $f = $x;
}

sub remove_ref_as_req {
    if ( $N > 1 ) {
        if ($N < $size) {
            undef ${$last_np1th_ref[1]};
            ${$last_np1th_ref[0]}->{_next} = ${$last_np1th_ref[2]}; 
        }
        else {
            undef $list->{_next};
            $list->{_next} = ${$last_np1th_ref[1]}; 
        }
    }
    else {
        undef ${$last_np1th_ref[1]};
        ${$last_np1th_ref[0]}->{_next} = undef; 
    }
}


remove_ref_as_req;
print_linked_list;    
