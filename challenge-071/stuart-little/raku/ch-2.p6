#!/usr/bin/env perl6
use v6;

class Node {
    has Real $.val;
    has Node $.nxt is rw;
}

class Sll {
    has Node $.head is rw;

    method show() {
	my $node = self.head;
	(! $node) && return;
	while ($node.nxt) {
	    print $node.val, " -> ";
	    $node=$node.nxt;
	}
	say $node.val;
    }
    
    method len() {
	my $node = self.head;
	my $len=0;
	while ($node) {
	    $len++;
	    $node=$node.nxt;
	}
	return $len;	
    }
    
    multi method insert(Real $val) {	
	my $node=self.head;
	(! $node) && do {
	    self.head=Node.new(val => $val);
	    return;
	}
	while ($node.nxt) {
	    $node=$node.nxt;
	}
	$node.nxt=Node.new(val => $val);
    }

    multi method insert(0, Real $val) {
	my $node=Node.new(val => $val, nxt => self.head);
	self.head=$node;
    }
    
    multi method insert(Int $idx where * > 0, Real $val) {
	given self.len {
	    when 0 { self.insert(0,$val) }
	    when 1..$idx { self.insert($val) }
	    default {
		my $cur=self.head;	
		my $node=Node.new(val => $val);
		for (0..^($idx-1)) {
		    $cur=$cur.nxt;
		}
		$node.nxt=$cur.nxt;
		$cur.nxt=$node;
	    }
	}
    }

    method del(Int $idx where * >= 0) {
	given $idx {
	    when self.len..* { warn "Index out of range" }
	    when 0 { self.head=self.head.nxt }
	    default {
		my $cur=self.head;
		for (^($idx-1)) {
		    $cur=$cur.nxt;
		}
		$cur.nxt=$cur.nxt.nxt;
	    }
	}
    }
}

my $ll=Sll.new();
for (@*ARGS[1..*].map(*.Real)) {
    $ll.insert($_);
}

print "Initial list: ";
$ll.show();

my $N=@*ARGS[0].Int;
($N > $ll.len) ?? ($ll.del(0)) !! ($ll.del($ll.len-$N));

print "Chopped list: ";
$ll.show();

# run as <script> <number $N> <space-separated numbers making up the list>
