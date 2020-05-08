use strict;
use warnings;
use File::Basename;
use lib dirname (__FILE__);
use experimental qw(signatures);

use Listy;

sub find_parent ($lst, $node, $start_node=undef) {
    $start_node //= $lst->{head};
    return $start_node if $start_node == $node;
    
    $start_node = $start_node->{next_node} while $start_node->{next_node} != $node;
    return $start_node;
}

sub shift_list ($lst, $i, $j) {
    my $parent_i = find_parent $lst, $i;
    my $parent_j = find_parent $lst, $j, $i;

    $parent_j->{next_node} = $j->{next_node};
    $lst->{last1} = $parent_j if $j == $lst->{last1};
    $j->{next_node} = $i;
    if ($parent_i == $i) {
        $lst->{head} = $j;
    }
    else {
        $parent_i->{next_node} = $j;
    }
}

sub partition_list {
    my ($lst, $k) = @_;
    my $i = $lst->{head};
    $i = $i->{next_node} if defined $i && $i->{val} < $k;
    return $lst unless defined $i;
    
    while (1) {
        my $j = $i->{next_node};
        $j = $j->{next_node} while defined $j && $j->{val} >= $k;
        return $lst unless defined $j;
        shift_list($lst, $i, $j);
    }
}

my $lst = Listy->new ([1, 4, 3, 2, 5, 2]);
partition_list ($lst, 3) -> print_list;
