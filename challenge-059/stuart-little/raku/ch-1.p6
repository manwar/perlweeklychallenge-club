#!/usr/bin/env perl6
use v6;

class Node {
    has Real $.val;
    has Node $.next is rw;
}

class Sll {
    has Node $.head is rw;

    method show() {
	my $node = self.head;
	(! $node) && return;
	while ($node.next) {
	    print $node.val, " -> ";
	    $node=$node.next;
	}
	say $node.val;	
    }
    
    method len() {
	my $node = self.head;
	my $len=0;
	while ($node) {
	    $len++;
	    $node=$node.next;
	}
	return $len;	
    }
    
    multi method insert(Real $val) {	
	my $node=self.head;
	(! $node) && do {
	    self.head=Node.new(val => $val);
	    return;
	}
	while ($node.next) {
	    $node=$node.next;
	}
	$node.next=Node.new(val => $val);
    }

    multi method insert(0, Real $val) {
	my $node=Node.new(val => $val, next => self.head);
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
		    $cur=$cur.next;
		}
		$node.next=$cur.next;
		$cur.next=$node;
	    }
	}
    }

    method del(Int $idx where * >= 0) {
	given $idx {
	    when self.len..* { warn "Index out of range" }
	    when 0 { self.head=self.head.next }
	    default {
		my $cur=self.head;
		for (^($idx-1)) {
		    $cur=$cur.next;
		}
		$cur.next=$cur.next.next;
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

my $k=@*ARGS[0].Real;
my $cur=Node.new(next => $ll.head);
my ($ins_idx,$cur_idx)=(0,0);

while ($cur.next && $cur.next.val < $k) {
    $ins_idx++;
    $cur_idx++;
    $cur.next=$cur.next.next;
}

while ($cur.next && $cur.next.next) {
    my $val=$cur.next.next.val;
    ($val < $k) && do {
	$ll.del(++$cur_idx);
	$ll.insert($ins_idx,$val);
	$ins_idx++;
    }
    $cur_idx++;
    $cur.next=$cur.next.next;
}

print "Final list: ";
$ll.show();

# run as <script> <number $k> <space-separated numbers making up the list>
