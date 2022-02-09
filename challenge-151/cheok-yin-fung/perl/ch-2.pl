# The Weekly Challenge 151
# Task 2 Rob the House
# Usage: $ ch-2.pl @valuables 
use strict;
use v5.22.0;
use List::Util qw/max/;

{   # BEGIN of package Chain
    use strict;
    package Chain;

    sub new {
        my ($class) = @_;
        bless {
            _last_ind => $_[1],
            _sum => $_[2],
            _chain => $_[3],
        }, $class;
    }

    sub last_ind { $_[0]->{_last_ind} }
    sub sum { $_[0]->{_sum} }
    sub chain { $_[0]->{_chain} }

    sub add_house {
        $_[0]->{_sum} += $_[1];
        push $_[0]->{_chain}->@*, $_[1];
        $_[0]->{_last_ind} = $_[2];
    }

}  # END of package Chain

say largest_revenue(@ARGV) if defined($ARGV[0]);



sub largest_revenue {
    my @house = @_;
    my @cand;
    my $num_of_houses = scalar @house;
    return $house[0] if $num_of_houses <= 2;
    push @cand, Chain->new(
        0, 
        $house[0],
        [$house[0]]
    );
    my $cur_ind = 2;
    while ($cur_ind < $num_of_houses) {
        for (@cand) {
            if ($cur_ind - $_->last_ind == 2) {
                push @cand, Chain->new( 
                    $cur_ind , 
                    $_->sum + $house[$cur_ind] , 
                    [$_->chain->@*, $house[$cur_ind]]
                );
            }
            if ($cur_ind - $_->last_ind == 3) {
                $_->add_house($house[$cur_ind], $cur_ind);
            }
        }

        my @pairwise = [ [0,1], [0,2], [0,3], [1,2], [1,3], [2,3] ];
        LOOP: for (@pairwise) {
            next LOOP if !defined($cand[$_->[1]]);
            my ($pre, $nxt) = ($_->[0], $_->[1]);
            if ($cand[$pre]->last_ind == $cand[$nxt]->last_ind) {
                if ($cand[$pre]->sum >= $cand[$nxt]->sum) {
                    splice(@cand, $nxt, 1);
                }
                else {
                    splice(@cand, $pre, 1);
                }
                last LOOP;
            }
        }
        $cur_ind++;
    }
    return max (map {$_->sum} @cand);
}



use Test::More tests => 6;
ok largest_revenue( (1, 8, 9, 4, 2, 7, 6, 5, 3) ) == 22;
ok largest_revenue( (4, 2, 3, 6, 5, 3) ) == 13;
ok largest_revenue( (2, 8, 5) ) == 7;
ok largest_revenue( (2, 6, 5) ) == 7;
ok largest_revenue( (3, 8) ) == 3;
ok largest_revenue( (5, 2) ) == 5;
