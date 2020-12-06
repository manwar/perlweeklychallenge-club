#!/usr/bin/env perl6
use v6;

# run as <script> <space-separated items of the initial list>

class Node is export {
    has Real $.data;
    has Node $.next is rw;
}

class Sll is export {
    has Node $.head is rw;

    method show() {
	my $node = self.head;
	(! $node) && do {say ""; return};
	while ($node.next) {
	    print $node.data, " -> ";
	    $node=$node.next;
	}
	say $node.data;	
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
    
    multi method insert(Real $data) {	
	my $node=self.head;
	(! $node) && do {
	    self.head=Node.new(data => $data);
	    return;
	}
	while ($node.next) {
	    $node=$node.next;
	}
	$node.next=Node.new(data => $data);
    }

    multi method insert(0, Real $data) {
	my $node=Node.new(data => $data, next => self.head);
	self.head=$node;
    }
    
    multi method insert(Int $idx where * > 0, Real $data) {
	given self.len {
	    when 0 { self.insert(0,$data) }
	    when 1..$idx { self.insert($data) }
	    default {
		my $cur=self.head;	
		my $node=Node.new(data => $data);
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

sub foldback(Sll $ll) {
    my $len=$ll.len;

    my $curr=$ll.head;
    for (1..($len div 2)) { $curr = $curr.next }
    for (1..(($len-1) div 2)) -> $offset {
	my $data=$curr.next.data;
	$ll.del(($len div 2)+$offset);
	$ll.insert((($len-1) div 2)-($offset-1),$data); 
    }
    return $ll;
}

my $ll=Sll.new();
for (@*ARGS.map(*.Real)) {
    $ll.insert($_);
}

print "Initial list: ";
$ll.show();

print "Folded list: ";
foldback($ll).show();
