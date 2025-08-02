# The Weekly Challenge 281
# Task 2 Knight's Move

use v5.30.0;
use warnings;
use List::Util qw/min/;

sub small_dist {
    my $pos_a = $_[0];
    my $pos_b = $_[1];
    my $diff0 = abs($pos_a->[0]-$pos_b->[0]);
    my $diff1 = abs($pos_a->[1]-$pos_b->[1]);
    if ($diff0 == 1 && $diff1 == 2 || $diff0 == 2 && $diff1 == 1) 
        {return 1;}
    if ($diff0 == 0 && $diff1 == 2 || $diff0 == 2 && $diff1 == 0)
        {return 2;} 
    if ($diff0 == 0 && $diff1 == 1 || $diff0 == 1 && $diff1 == 0)
        {return 3;}
    if ($diff0 == 1 && $diff1 == 1) { 
        if (is_corner($pos_a)|| is_corner($pos_b)) {
            return 4;
        }
        else {
            return 2;
        }
    }
    if ($diff0 == 2 && $diff1 == 2) {
        return 4;
    }
}

sub km {
    my $targt = $_[0];
    my $begin = $_[1];
    my $pos_a = [ord(substr($begin,0,1))-ord("a"), substr($begin,1,2)-1];
    my $pos_b = [ord(substr($targt,0,1))-ord("a"), substr($targt,1,2)-1];
    return dist($pos_a, $pos_b);
}

sub dist {
    my $pos_a = $_[0];
    my $pos_b = $_[1];
    if ((abs($pos_a->[0]-$pos_b->[0]) <= 2) && (abs($pos_a->[1]-$pos_b->[1]) <= 2)) {
        return small_dist($pos_a, $pos_b);
    }
    my $cur_tc_dist = taxicab_dist($pos_a, $pos_b);
    my @px = (+2, +2, +1, +1, -1, -1, -2, -2);
    my @py = (+1, -1, +2, -2, +2, -2, +1, -1);
    my @nxt;
    for my $k (0..7) {
        my $npx = $pos_b->[0]+$px[$k];
        my $npy = $pos_b->[1]+$py[$k];
        if ($npx < 0 || $npx > 7) {next;}
        if ($npy < 0 || $npy > 7) {next;}
        my $tc_dist = taxicab_dist($pos_a, [$npx, $npy]);
        push @nxt, [$npx, $npy] if $tc_dist < $cur_tc_dist;
    }
    if (scalar @nxt == 1) {
        return ( 1 + dist($pos_a, $nxt[0]) );
    } else {
        my @choice_val;
        for (0..$#nxt) {
            $choice_val[$_] = 1 + dist($pos_a, $nxt[$_]);
        }
        #say(chr(ord('a')+$pos_b->[0]).(1+$pos_b->[1])." ", min(@choice_val));
        return min(@choice_val);
    }
}
sub taxicab_dist {
    my $pos_a = $_[0];
    my $pos_b = $_[1];
    my $taxicab_dist = 
        abs($pos_a->[0]-$pos_b->[0])
                +
        abs($pos_a->[1]-$pos_b->[1]);
    return $taxicab_dist;
}

sub is_corner {
    my $pos = $_[0];
    if (($pos->[0] == 0 || $pos->[0] == 7) 
            &&
       ($pos->[1] == 0 || $pos->[1] == 7)) 
    {
       return 1;
    }
    return 0;
}

