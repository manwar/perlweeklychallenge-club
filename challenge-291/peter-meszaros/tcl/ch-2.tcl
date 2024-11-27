#!/usr/bin/env tclsh
#
# Task 2: Poker Hand Rankings
# 
# Submitted by: Robbie Hatley
# 
# A draw poker hand consists of 5 cards, drawn from a pack of 52: no jokers, no
# wild cards. An ace can rank either high or low.
# 
# Write a script to determine the following three things:
# 
#     1. How many different 5-card hands can be dealt?
# 
#     2. How many different hands of each of the 10 ranks can be dealt?
#        See here for descriptions of the 10 ranks of Poker hands:
#        https://en.wikipedia.org/wiki/List_of_poker_hands#Hand-ranking_categories
# 
#     3. Check the ten numbers you get in step 2 by adding them together
#        and showing that they're equal to the number you get in step 1.
# 

package require tcltest
package require math::combinatorics 

set cases {
    {-1 1 "Example 1"}
}

#
#  https://eng.libretexts.org/Bookshelves/Computer_Science/Programming_and_Computation_Fundamentals/Mathematics_for_Computer_Science_(Lehman_Leighton_and_Meyer)/03%3A_Counting/14%3A_Cardinality_Rules/14.07%3A__Counting_Practice_-_Poker_Hands
#

set deck {
    {1  1}
    {1  2}
    {1  3}
    {1  4}
    {1  5}
    {1  6}
    {1  7}
    {1  8}
    {1  9}
    {1 10}
    {1 11}
    {1 12}
    {1 13}
    {2  1}
    {2  2}
    {2  3}
    {2  4}
    {2  5}
    {2  6}
    {2  7}
    {2  8}
    {2  9}
    {2 10}
    {2 11}
    {2 12}
    {2 13}
    {3  1}
    {3  2}
    {3  3}
    {3  4}
    {3  5}
    {3  6}
    {3  7}
    {3  8}
    {3  9}
    {3 10}
    {3 11}
    {3 12}
    {3 13}
    {4  1}
    {4  2}
    {4  3}
    {4  4}
    {4  5}
    {4  6}
    {4  7}
    {4  8}
    {4  9}
    {4 10}
    {4 11}
    {4 12}
    {4 13}
}

set cat [dict create]
dict set cat five_of_a_kind  0 
dict set cat straight_flush  0 
dict set cat four_of_a_kind  0 
dict set cat full_house      0 
dict set cat flush           0 
dict set cat straight        0 
dict set cat three_of_a_kind 0 
dict set cat two_pair        0 
dict set cat one_pair        0 
dict set cat high_card       0 

# five_of_a_kind          0
# straight_flush         40
# four_of_a_kind        624
# full_house          3_744
# flush               5_108
# straight           10_200
# three_of_a_kind    54_912
# two_pair          123_552
# one_pair        1_098_240
# high_card       1_302_540
#                 2_598_960 <== sum

proc pdict {dict {pattern *}} {
   set longest 0
   set keys [dict keys $dict $pattern]
   foreach key $keys {
      set l [string length $key]
      if {$l > $longest} {set longest $l}
   }
   foreach key $keys {
      puts [format "%-${longest}s = %s" $key [dict get $dict $key]]
   }
}

proc ladd {l} {
    set total 0
    foreach nxt $l {
        incr total $nxt
    }
    return $total
}

proc max {args} {
    return [lindex [lsort -real $args] end]
}

proc is_straight {l} {

    set r [lrepeat 14 0]
    foreach i $l {
        lset r $i 1
        if {$i == 13} {
            lset r 0 1
        }
    }

   for {set i 0} {$i < 10} {incr i} {
       set h [lrange $r $i [expr $i + 4]]
       if {[ladd $h] == [llength $h]} {
           return 1
       }
   }

    return 0
}

proc poker_hand_rankings {x} {
    upvar 1 cat catlocal
    upvar 1 deck decklocal
    set cnt 0
    set combi [::math::combinatorics::combinationObj create "hand" 52 5]
    set h [$combi next]
    while {[llength $h] == 5} {
        incr cnt
        set clor_stat [dict create]
        set rank_stat [dict create]

        foreach c $h {
            set i [lindex $decklocal $c]
            dict incr clor_stat [lindex $i 0] 1
            dict incr rank_stat [lindex $i 1] 1
        }

        set num_clors [llength [dict keys $clor_stat]]
        set num_ranks [llength [dict keys $rank_stat]]
        set values    [dict values $rank_stat]
        set keys      [dict keys $rank_stat]
        set straight  [is_straight $keys]

        if {$straight == 1} {
            set k1 "straight_flush"
            set k2 "straight"
        } else {
            set k1 "flush"
            set k2 "high_card" 
        }

        if {$num_clors == 4 && $num_ranks <= 2 && [max {*}$values] == 4} {
            dict incr catlocal "four_of_a_kind" 1
        } elseif {$num_ranks == 2 && 
            (([lindex $values 0] == 2 && [lindex $values 1] == 3) ||
             ([lindex $values 0] == 3 && [lindex $values 1] == 2))} {
            dict incr catlocal "full_house" 1
        } elseif {$num_ranks == 3 &&
            (([lindex $values 0] == 2 && [lindex $values 1] == 2) ||
             ([lindex $values 1] == 2 && [lindex $values 2] == 2) ||
             ([lindex $values 2] == 2 && [lindex $values 0] == 2))} {
            dict incr catlocal "two_pair" 1
        } elseif {$num_ranks == 4 &&
            ([lindex $values 0] == 2 ||
             [lindex $values 1] == 2 ||
             [lindex $values 2] == 2 ||
             [lindex $values 3] == 2)} {
            dict incr catlocal "one_pair" 1
        } elseif {$num_ranks == 3 &&
            ([lindex $values 0] == 3 ||
             [lindex $values 1] == 3 ||
             [lindex $values 2] == 3)} {
            dict incr catlocal "three_of_a_kind" 1
        } elseif {$num_clors == 1} {
            dict incr catlocal $k1 1
        } else {
            dict incr catlocal $k2 1
        }

        set h [$combi next]
    }

    set sum 0
    foreach v [dict values $catlocal] {
        incr sum $v
    }
    return [expr $cnt == $sum ? 1 : 0]
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
       poker_hand_rankings [lindex $case 0]
    } [lindex $case 1]
}

exit 0

