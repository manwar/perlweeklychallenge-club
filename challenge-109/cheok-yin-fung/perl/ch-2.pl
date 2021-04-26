#!/usr/bin/perl
=pod


              (1)                    (3)
        ╔══════════════╗      ╔══════════════╗
        ║              ║      ║              ║
        ║      a       ║      ║      e       ║
        ║              ║ (2)  ║              ║  (4)
        ║          ┌───╫──────╫───┐      ┌───╫─────────┐
        ║          │   ║      ║   │      │   ║         │
        ║          │ b ║      ║ d │      │ f ║         │
        ║          │   ║      ║   │      │   ║         │
        ║          │   ║      ║   │      │   ║         │
        ╚══════════╪═══╝      ╚═══╪══════╪═══╝         │
                   │       c      │      │      g      │
                   │              │      │             │
                   │              │      │             │
                   └──────────────┘      └─────────────┘

=cut
# The Weekly Challenge 109
# Task 2 Boxes
# ---

use strict;
use warnings;
use Algorithm::Combinatorics qw/permutations/;

{ 
    package Point;
    use strict;

    sub new {
        my ($class) = @_;
        bless {
            _x => $_[1],
            _y => $_[2],
        }, $class;
    }

    sub x { $_[0]->{_x} }
    sub y { $_[0]->{_y} }

}

{
    package Box;
    use strict;

    sub new {
        my ($class) = @_;
        bless {
            _tl => $_[1],  #top left
            _br => $_[2],  #bottem right
        }, $class;
    }

    sub tl { $_[0]->{_tl} }
    sub br { $_[0]->{_br} }

}


# ================= BEGIN: Parameters input ==============

my @boxes = (
     Box->new( Point->new(9,6), Point->new(24,15) ), 
     Box->new( Point->new(20,10), Point->new(35,19) ), 
     Box->new( Point->new(31,6), Point->new(46,15) ), 
     Box->new( Point->new(42,10), Point->new(56,19) ), 
);

my @var = (
    Point->new(16,8),  #a
    Point->new(22,12), #b
    Point->new(28,16), #c
    Point->new(33,12), #d
    Point->new(38,8),  #e
    Point->new(44,12), #f
    Point->new(49,16), #g
);

my @possible_val = (1,2,3,4,5,6,7);


# ================= END: Parameters input ==============

my $M = scalar @possible_val;
my $N = scalar @boxes;

my @container;

for my $i_b (0..$N-1) {
    my $b = $boxes[$i_b];
    $container[$i_b] = [];
    for my $v_ind (0..$M-1) {
        if (   $var[$v_ind]->x < $b->br->x  
           && $var[$v_ind]->x > $b->tl->x  
           && $var[$v_ind]->y > $b->tl->y  
           && $var[$v_ind]->y < $b->br->y) {
            push @{$container[$i_b]}, $v_ind;
        }
    }
}

my $trial = permutations(\@possible_val);

my @possible_soln;

while (my $p = $trial->next) {
    # attempt_soln --->    @{$p};
    my $invariant = 0;
    for (@{$container[ 0 ]}) {
        $invariant += $p->[$_]; }
    my $consistency = 1;
    for my $i_b (1..$N-1) {
        my $this_sum = 0;
        for (@{$container[ $i_b ]}) {
            $this_sum += $p->[$_]; }
        $consistency = ($this_sum == $invariant);
        last if !$consistency;
    }
    push @possible_soln, $p if $consistency;
}

my $NUM_ANS = scalar @possible_soln;
print "Number of solutions: ", $NUM_ANS, "\n";

if ($NUM_ANS != 0) {
    print "  ",chr(ord('a')+$_) for (0..$M-1);
    print "\n";
    for my $temp (0..$#possible_soln) {
        for my $number (@{$possible_soln[$temp]}) {
            printf("%3d", $number);
        }
        print "\n";
    }
    print "\n";
}



sub printing {
    my @soln = @_;
    my $max_x = 0;
    my $max_y = 0; 
    for my $b (@boxes) {
        $max_x = $max_x > $b->br->x ? $max_x : $b->br->x;
        $max_y = $max_y > $b->br->y ? $max_y : $b->br->y;
    }
    my @row;
    $row[$_] = [(' ') x $max_x] for (0..$max_y-1);
    for my $i_b (0..$N-1) {
        my $b = $boxes[$i_b];
        for my $i ($b->tl->x-1..$b->br->x-1) {$row[$b->tl->y-1][$i] = '*';}
        for my $i ($b->tl->x-1..$b->br->x-1) {$row[$b->br->y-1][$i] = '*';}
        for my $i ($b->tl->y-1..$b->br->y-1) {$row[$i][$b->tl->x-1] = '*';}
        for my $i ($b->tl->y-1..$b->br->y-1) {$row[$i][$b->br->x-1] = '*';}
    }
    for my $i_v (0..$M-1) {
        $row[$var[$i_v]->y-1]->[$var[$i_v]->x-1] = $soln[$i_v];
    }

    print "One of the possible solution(s):\n";

    for my $j (0..$max_y-1) {
        for my $i (0..$max_x-1) {
            print $row[$j]->[$i];
        }
        print "\n";
    }

    print "\n" x 3;
}

printing(@{$possible_soln[ int(rand($NUM_ANS))]})
    if (scalar (map {length $_ == 1} @possible_val) == $M) && $NUM_ANS != 0;
