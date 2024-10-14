use v5.38;
use List::Util qw( sum );
## ## ## (By Hand) ## ## ## 
## 1. 52c5 = 2598960
## 2. high card : pair : two-pair : 3 : straight : flush : fh : 4 : sf : rf
# no pair: 13c5 * 4^5 - 10200 - 5108 - 40 = 1302540
# one pair : 13 * 4c2 * 12c3 * 4^3 = 1098240
# two pair : 13c2 * 4c2 * 4c2 * 44 = 123552
# 3 ofkind : 13 * 12c2 * 4c3 * 4 * 4 = 54912
# straight : 10 * 4^5 - 40 = 10200
#    flush : 13c5 * 4 - 40 = 5108
# fullhouse: 13 * 4c3 * 12 * 4c2 = 3744
# 4 of kind: 13 * 12 * 4 = 624
# sf : 9 * 4 = 36
# rf : 4
# my @n = (4, 36, 624, 3744, 5108, 10200, 54912, 123552, 1098240, 1302540);
# sum(@n);	# 2598960
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## 

sub is_straight($k) {
    return ($k eq "2345A" || $k eq "0AJKQ" || $k eq "09JKQ" || $k eq "089JQ" || $k eq "0789J" || $k eq "06789" || $k eq "56789" || $k eq "45678" || $k eq "34567" || $k eq "23456");
}
sub is_flush(@suits) {my $n=0; for my $i (0 .. $#suits - 1) { $n++ if ($suits[$i] eq $suits[$i+1]);} return ($n == $#suits);}
sub is_pair($hand) {return ($hand eq "1112");}
sub is_twopair($hand) {return ($hand eq "122");}
sub is_3kind($hand) {return ($hand eq "113");}
sub is_4kind($hand) {return ($hand eq "14");}
sub is_fh($hand) {return ($hand eq "23");}
sub is_sf($k, @l) {my @suits = splice @l, 0, 5; my @ranks = @l; return ($ranks[0] ne "0" && is_straight($k) && is_flush(@suits));}
sub is_rf($k, @l) {my @suits = splice @l, 0, 5; my @ranks = @l; return ($ranks[0] eq "0" && is_straight($k) && is_flush(@suits));}

my @suit = sort qw( H D C S );
my @rank = (2 .. 9);
push @rank, qw( 0 J Q K A );
# C2C3D3D5D0 is one example of a hand. (0 means rank 10)
# The smallest card is C2, the largest is SA.
my @card;
for my $s (@suit) {
    for my $r (@rank) {
	push @card, $s.$r;
    }
}

my $tot_cnt = 0;
my ($rf, $sf, $fh, $k4, $k3, $tp, $op, $fl, $st, $no);
for my $i1 (0 .. 47) {
    for my $i2 ($i1 + 1 .. 48) {
	for my $i3 ($i2 + 1 .. 49) {
	    for my $i4 ($i3 + 1 .. 50) {
		for my $i5 ($i4 + 1 .. 51) {
		    $tot_cnt++;
		    my @suits;
		    my @ranks;
		    #my $hand;
		    for my $i ($i1, $i2, $i3, $i4, $i5) {
			#$hand .= $card[$i];
			my ($s, $r) = split "", $card[$i];
			push @suits, $s;
			push @ranks, $r;
		    }
		    my %freq;
		    $freq{$_}++ for (@ranks);
		    my $f = join "", sort values %freq;
		    my $k = join "", sort keys %freq;
		    if (is_pair($f)) {
			$op++;
		    } elsif (is_twopair($f)) {
			$tp++;
		    } elsif (is_3kind($f)) {
			$k3++;
		    } elsif (is_4kind($f)) {
			$k4++;
		    } elsif (is_fh($f)) {
			$fh++;
		    } else {
			if (is_rf($k, @suits, @ranks)) {
			    $rf++;
			} elsif (is_sf($k, @suits, @ranks)) {
			    $sf++;
			} elsif (is_flush(@suits)) {
			    $fl++;
			} elsif (is_straight($k)) {
			    $st++;
			} else {
			    $no++;
			}
		    }
		}
	    }
	}
    }
}
    
say "There are $tot_cnt distinct hands.";
printf("rf:%d sf:%d 4k:%d fh:%d fl:%d st:%d 3k:%d tp:%d op:%d no:%d -> ", $rf, $sf, $k4, $fh, $fl, $st, $k3, $tp, $op, $no);
say "The sum of these is ", sum($rf, $sf, $fh, $k4, $k3, $tp, $op, $fl, $st, $no);
