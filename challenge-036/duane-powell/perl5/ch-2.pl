#!/usr/bin/perl
use warnings;
use strict;
use feature qw( say );
use Math::Combinatorics;

# Write a program to solve Knapsack Problem.

# Solution: Create a self packing Knapsack object that fills itself with the best combination of boxes.  
# This code solves for both cases of box availability: use each box once or reuse box types up to count and weight limits.

my $capacity  = shift;
my $box_reuse = shift;
do {
        print <<EOU;
Usage:
$0 capacity reuse-box
	$0 15 1
	$0 15 0
EOU
        exit;
} unless $capacity;


my $BOX = { # Global data structure
	R => { weight => 1, amount => 1 },
	B => { weight => 1, amount => 2 },
	G => { weight => 2, amount => 2 },
	Y => { weight =>12, amount => 4 },
	P => { weight => 4, amount =>10 },
};
my @box = (sort keys %$BOX);

say "Problem:";
say "Box\tWeight\tAmount";
foreach my $box (@box) {
	say "$box\t$BOX->{$box}{weight}\t$BOX->{$box}{amount}";
}

# Create new Knapsack, pack it and say best fit	for all $c combinations: 2, 3, 4 and 5 boxes
my $knapsack;
my $c;
my $out = $box_reuse ? "box types" : "boxes limit";

say "\nSolution: (2 $out)";
$knapsack = Knapsack->new($capacity,2,$box_reuse);
$c = Math::Combinatorics->new(count => 2, data => [@box]);
while (my @combo = $c->next_combination) {
	$knapsack->pack(@combo);
} 
$knapsack->box_list(); 


say "\nSolution: (3 $out)";
$knapsack = Knapsack->new($capacity,3,$box_reuse);
$c = Math::Combinatorics->new(count => 3, data => [@box]);
while (my @combo = $c->next_combination) {
	$knapsack->pack(@combo);
}   
$knapsack->box_list();


say "\nSolution: (4 $out)";
$knapsack = Knapsack->new($capacity,4,$box_reuse);
$c = Math::Combinatorics->new(count => 4, data => [@box]);
while (my @combo = $c->next_combination) {
	$knapsack->pack(@combo);
}   
$knapsack->box_list();


say "\nSolution: (5 $out)";
$knapsack = Knapsack->new($capacity,5,$box_reuse);  
$knapsack->pack(@box);
$knapsack->box_list();
exit;

package Knapsack;
sub new {
        my $class = shift;
        my $self = {
		capacity    => shift,
		box_max     => shift,
		box_reuse   => shift,
		box_list    => '', # current state of the object
		weight      => 0, 
		amount      => 0,
		best_list   => '', # best state reached
		best_weight => 0, 
		best_amount => 0,
	};
	bless $self, $class;
	return $self;
}

sub pack {
	my ($self,@box) = @_;
	if ($self->{box_reuse}) {
		$self->pack_reuse(@box);
	}
	else {
		$self->pack_solo(@box);
	}
}
sub pack_reuse {
	my ($self,@box) = @_;
        foreach my $box (@box) {
		if ($self->box_will_fit($box)) {
			$self->box_add($box);
			$self->pack_reuse(@box);
			$self->box_sub($box);
		}
	}
}
sub pack_solo {
	my ($self,@box) = @_;
        foreach my $box (@box) {
		next if ($self->{box_list} =~ m/$box/); # can not use same box twice
		if ($self->{box_max} > length($self->{box_list})) { # can not exceed number of boxes allowed
			if ($self->box_will_fit($box)) {
				$self->box_add($box);
				$self->pack_solo(@box);
				$self->box_sub($box);
			}
		}
	}
}
sub box_add {
	my ($self,$box) = @_;
	$self->{weight}   += $BOX->{$box}{weight};
	$self->{amount}   += $BOX->{$box}{amount};
	$self->{box_list} .= $box;
	if ($self->{amount} > $self->{best_amount} ) {
		 $self->{best_amount} = $self->{amount};
		 $self->{best_weight} = $self->{weight};
		 $self->{best_list}   = $self->{box_list};
	}
}
sub box_sub {
	my ($self,$box) = @_;
	$self->{weight} -= $BOX->{$box}{weight};
	$self->{amount} -= $BOX->{$box}{amount};
	chop $self->{box_list};
}
sub box_list {
	my $self = shift;
	say "Box list:     $self->{best_list}";
	say "Total weight: $self->{best_weight}";
	say "Total amount: $self->{best_amount}";
}
sub box_will_fit {
	my ($self,$box) = @_;
	return ($self->{capacity} >= $self->{weight} + $BOX->{$box}{weight});
}
1;

__END__

./ch-2.pl
Usage:
./ch-2.pl capacity reuse-box
        ./ch-2.pl 15 1
        ./ch-2.pl 15 0


./ch-2.pl 15 1
Problem:
Box     Weight  Amount
B       1       2
G       2       2
P       4       10
R       1       1
Y       12      4

Solution: (2 box types)
Box list:     BBBPPP
Total weight: 15
Total amount: 36

Solution: (3 box types)
Box list:     BBBPPP
Total weight: 15
Total amount: 36

Solution: (4 box types)
Box list:     PPPBBB
Total weight: 15
Total amount: 36

Solution: (5 box types)
Box list:     BBBPPP
Total weight: 15
Total amount: 36


./ch-2.pl 15 0
Problem:
Box     Weight  Amount
B       1       2
G       2       2
P       4       10
R       1       1
Y       12      4

Solution: (2 boxes limit)
Box list:     BP
Total weight: 5
Total amount: 12

Solution: (3 boxes limit)
Box list:     BGP
Total weight: 7
Total amount: 14

Solution: (4 boxes limit)
Box list:     GRPB
Total weight: 8
Total amount: 15

Solution: (5 boxes limit)
Box list:     BGPR
Total weight: 8
Total amount: 15
