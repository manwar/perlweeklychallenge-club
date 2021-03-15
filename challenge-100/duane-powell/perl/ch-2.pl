#!/usr/bin/perl
use warnings;
use strict;
use feature 'say';

# Problem: https://perlweeklychallenge.org/blog/perl-weekly-challenge-100/ TASK #2

# Let user select triangle array, 1,2, or 3. 
# 0 for random triangle array.
my $number = shift;
$number ||= 0;

do {
        print <<EOU;
Usage:
$0 [ 0|1|2 ]
    $0 0 # random generate triangle array
    $0 1 # use task example 1 triangle
    $0 2 # use task example 2 triangle
    $0 3 # total is zero triangle array
EOU
        exit;
} unless ($number >= 0 and $number <= 3);



# Construct new Triangle Array and init to user selected number
my $t = Triangle_Array->new();
$t->init($number);

# Find the best path using recursion
# The three positional params are: index, path, total
$t->min_path_find( [0,0], [], 0 ); 

# Explain solution
$t->total();
$t->explain();
$t->solution();
exit;



package Triangle_Array;
sub r {
    # return random number between 0 and 9
    return int(rand(10));
}

sub new {
    my $class = shift;
    my $self = {
        array => [],    # the triangl array
        path  => [],    # best path found
        total => 99999, # best total found, init to big magic number
        size  => 3,     # hard coded for triangle with 4 rows, 0 indexed
    };
    bless $self, $class;
    return $self;
}

sub init {
    my ($self,$number) = @_;

    # task examples 
    $self->{array} = [ [1], [2,4], [6,4,9], [5,1,7,2] ] if ( $number == 1 );
    $self->{array} = [ [3], [3,1], [5,2,3], [4,3,1,3] ] if ( $number == 2 );

    # test array, best path is 0 + 0 + 0 + 0 = 0
    $self->{array} = [ [0], [1,0], [1,1,0], [1,1,1,0] ] if ( $number == 3 ); 

    # generate randome triangle array
    $self->{array} = [  
                            [ r() ], 
                            [ r(),r() ], 
                            [ r(),r(),r() ], 
                            [ r(),r(),r(),r() ], 
                     ] if ( $number == 0 );
}

sub total {
    my ($self) = @_;
    say "Output: " . $self->{total};
}

sub explain {
    my ($self) = @_;
    say "\nExplanation: The given triangle\n";

    # Print triangle, need $x to determine leading pad 
    my $x = 0;
    foreach my $row ( @{$self->{array}} ) {
       print " " x ($self->{size} - $x);
       foreach my $col ( @{$row} ) {
            print " $col ";
       } 
       print "\n";
       $x++;
    }
}

sub min_path_find {
    my ($self, $index, $path, $total) = @_;

    # Total along the currect path
    # Note: we're making a copy of $path because perl is pass-by-ref. 
    # Each instance of min_path_find() needs its own path, $this_path.
    my $this_path = [ @{$path} ]; 
    push @{$this_path}, $index;
    my ($row,$col) = @{$index};
    $total += $self->{array}[$row][$col];

    # Recurse left and right down the triangle
    if ( $row < $self->{size} ) {
        $self->min_path_find( [$row+1,$col  ], $this_path, $total ); 
        $self->min_path_find( [$row+1,$col+1], $this_path, $total );
    }   

    # Terminal node reached, is this the best path so far?
    else {
        if ($total < $self->{total}) {
            $self->{total} = $total;
            $self->{path}  = $this_path;
        }
    }
}

sub solution {
    my ($self) = @_;

    # Print out solution total
    my $out = "The minimum path sum from top to bottom: ";
    foreach my $index ( @{$self->{path}} ) {
        my ($row,$col) = @{$index};
        $out .= $self->{array}[$row][$col] . " + ";
    }
    $out .= " = $self->{total}";
    $out =~ s/ \+  =/ =/;
    say "\n$out\n";

    # Print out solution path
    # Iterate over array refs and print square brackets around
    # the element if solution path index [r,c] equals [x,y]
    my $x = 0;
    foreach my $row ( @{$self->{array}} ) {
       my ($r, $c) = @{ $self->{path}[$x] };
       print " " x ($self->{size} - $x);
       my $y = 0; 
       foreach my $col ( @{$row} ) {
            $out = ($x == $r and $y == $c) ? "[$col]" : " $col ";
            print $out;
            $y++;
       }
       $x++;
       print "\n";
    }
}

1;

__END__

./ch-2.pl 1
Output: 8

Explanation: The given triangle

    1 
   2  4 
  6  4  9 
 5  1  7  2 

The minimum path sum from top to bottom: 1 + 2 + 4 + 1 = 8

   [1]
  [2] 4 
  6 [4] 9 
 5 [1] 7  2 

./ch-2.pl 2
Output: 7

Explanation: The given triangle

    3 
   3  1 
  5  2  3 
 4  3  1  3 

The minimum path sum from top to bottom: 3 + 1 + 2 + 1 = 7

   [3]
   3 [1]
  5 [2] 3 
 4  3 [1] 3 

./ch-2.pl 3
Output: 0

Explanation: The given triangle

    0 
   1  0 
  1  1  0 
 1  1  1  0 

The minimum path sum from top to bottom: 0 + 0 + 0 + 0 = 0

   [0]
   1 [0]
  1  1 [0]
 1  1  1 [0]

(hist:2226 jobs:0) >>> ./ch-2.pl 
Output: 10

Explanation: The given triangle

    0 
   8  7 
  4  3  7 
 2  0  0  4 

The minimum path sum from top to bottom: 0 + 7 + 3 + 0 = 10

   [0]
   8 [7]
  4 [3] 7 
 2 [0] 0  4 

