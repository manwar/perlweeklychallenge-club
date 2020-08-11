#!/usr/bin/perl
use strict;
use warnings;
use feature 'say';

my @arr  = ( 1, 4, 3, 2, 5, 2 );
my $k    = 3;
my $link = new LinkedList;

#Add items in linked list
for my $i (@arr) {
    $link->add($i);
}

#Declare two linked list for partitions
my $uplink = new LinkedList;
my $dnlink = new LinkedList;

#Print original list
say "Original List:";
while ($link->iter) {
    my $i = $link->value;
    if ($i >= $k) {
        $uplink->add($i) 
    } else {
        $dnlink->add($i);
    }
    print $i;
    print " → " if $link->next
}

#Join dnlink and uplink
$dnlink->join($uplink);


#Print final re-ordered list
say "\n\nPartitioned List:";
while ($dnlink->iter) {
    my $i = $dnlink->value;
    print $i;
    print " → " if $dnlink->next
}


package LinkedList;
my $iter_item;
sub new {
    my $class = shift;
    my $self = {
        value => shift,
        next  => undef,
        
    };

    return bless $self, $class;
}
sub add {
    my ($self,$val) = @_;
    my $curr = $self->last;
    
    $curr->{value} = $val;
    $curr->{next}  = undef;
}
sub last {
    my $self = shift;
    my $curr = $self;
    while (defined $curr->{value}) {
        $curr = \%{$curr->{next}};
    }
    return $curr;
}
sub value {
    my $self = shift;
    $iter_item = $self if (!$iter_item);
    return $iter_item->{value};
} 
sub next {
    return $iter_item->{next};
} 
sub iter {
    my $self = shift;

    if (!$iter_item) {
        $iter_item = $self;
    } else {
        if ($iter_item->{next}) {
            $iter_item = \%{$iter_item->{next}};
        } else {
            $iter_item = undef;
        }
    }
}
sub join {
    my ($self,$val) = @_;
    while ($val->iter) {
        my $i = $val->value;
        $self->add($i)
    }
}
1;

=begin
Original List:
1 → 4 → 3 → 2 → 5 → 2

Partitioned List:
1 → 2 → 2 → 4 → 3 → 5

The setting below was added in VS code internal terminal (PowerShell) 
to properly show the arrow ( → ) character:

    "terminal.integrated.shellArgs.windows": [
        "-NoExit",
        "/c",
        "chcp.com 65001"
    ],
=cut