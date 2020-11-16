#!/usr/bin/perl
# The Weekly Challenge - Perl & Raku - 086
# Task: Sudoku
# print one of the possible solutions for the given hints
# print -1 if impossible
# Usage: capable for generating 16 x 16 Sudoku SOMETIMES,  try: perl ch-2.pl 4
# capable for generating 25 x 25 Sudoku in very FEW cases, try: perl ch-2.pl 5
# Caution: The part for declaring impossibility hasn't been tested.
# Caution: The subroutine "come_bk_after_fail_attempt" 
#          is not logically complete 
# version date: 2020-11-15 HKT afternoon

use strict;
use warnings;

my @tree;
my @board;

my $LEVEL = $ARGV[0] ? $ARGV[0] : 3;  #default value of board length: 3*3=9
my $BSIZE = $LEVEL**4;
my $E_LEN = $LEVEL**2;
my @ABT = ('A'..chr(ord('A')+$E_LEN-1));
&initialize;

# TESTING INPUT, from example provided
if (!$ARGV[0]) {
@board = split "", "zzzBFzGzAFHzzGzzIzAIzzzDEzzHBzAzzzDzzzDFzBIzzzEzzzCzBHzzICzzzGDzDzzEzzCFGzCzAHzzz";
}

my $BITWORLD = 2**($E_LEN+1)-1;

my %bit_repr;
for my $i (0..$E_LEN-1) {
    $bit_repr{$ABT[$i]} = 2**$i;
}

{package node;
use strict;

sub new
{
    my ($class) = @_;
    bless{
        _position => $_[1],
        _value => $_[2],
        _is_stable => $_[3],
        _depth => $_[4],
        _nexts => $_[5],   #list of references to nodes
    }, $class;


}

    sub position {return $_[0]->{_position};}
    sub value {return $_[0]->{_value};}
    sub is_stable {return $_[0]->{_is_stable};}
    sub depth {return $_[0]->{_depth};}
    sub nexts {return $_[0]->{_nexts};}
    
1;
}

# ==== representation

sub num_repr {
    return (ord($board[$_[0]])-ord("A"));
}

sub internal_repr_to_trad_3 {
    for my $i (0..$E_LEN-1) {
        for my $j (0..$E_LEN-1) {
            my $p = $i*$E_LEN+$j;
            if ($board[$p] ne "z") {
                print ord($board[$i*$E_LEN+$j])-ord("A")+1, " ";
            } else
            {
                print "_ ";
            }
        }
        print "\n";
    }
}

sub internal_repr_to_trad {
    for my $i (0..$E_LEN-1) {
        for my $j (0..$E_LEN-1) {
            my $p = $i*$E_LEN+$j;
            if ($board[$p] ne "z") {
                print $board[$i*$E_LEN+$j], " ";
            } else
            {
                print "_ ";
            }
        }
        print "\n";
    }
}

sub TEST_print_board {
    for my $i (0..$E_LEN-1) {
        for my $j (0..$E_LEN-1) {
            print $board[$i*$E_LEN+$j], " ";
        }
        print "\n";
    }
}

sub coord_to_nth_row {return int( $_[0] / $E_LEN );}
sub coord_to_nth_col {return $_[0] % $E_LEN;}
sub coord_to_nth_ssq {
    my $r = coord_to_nth_row($_[0]);
    my $c = coord_to_nth_col($_[0]);
    return ( (int ($r / $LEVEL)) *$LEVEL + int($c / $LEVEL)  ) ;
}
# +-+-+-+
# |0|1|2|  012
# +-+-+-+
# |3|4|5|  345
# +-+-++
# |6|7|8|  678
# +-+-+-+

# ==== begin checking lines

sub checkrows {
    my @rown = @_;
    my $bool = 1;
    foreach my $r (@rown) {
        my $nvalue = 0;
        my $zcount = 0;
        for my $p ($E_LEN*$r..$E_LEN*$r+$E_LEN-1) {
            my $alpha = $board[$p];
            if ($alpha != "z") {
                if ( ($bit_repr{$alpha} & $nvalue) > 0) {  #repeat appearance
                    return undef;
                }
                $nvalue += $bit_repr{$alpha};
            } else 
            {
                $zcount++;
            }
        }
        if ($zcount == 0 and $nvalue == 0) {
            return undef;
        }
    }

    return $bool;
}

sub checkcols {
    my @coln = @_;
    my $bool = 1;
    for my $c (@coln) {
        my $nvalue = 0;
        my $zcount = 0;
        for my $p (0..$E_LEN-1) {
            my $alpha = $board[$E_LEN*$p+$c];
            if ($alpha != "z") {
                if ( ($bit_repr{$alpha} & $nvalue) > 0) {  #repeat appearance
                    return undef;
                }
                $nvalue += $bit_repr{$alpha};
            } else 
            {
                $zcount++;
            }
        }
        if ($zcount == 0 and $nvalue == 0) {
            return undef;
        }
    }
    return $bool;
}


sub r_ssq_tl {
    my $ssq_id = $_[0];
    my $floor = (int ($ssq_id / $LEVEL));
    return $LEVEL*($ssq_id % $LEVEL + $floor*$E_LEN);
}

sub checkssqs {
    my @ssqn = @_;
    my $bool = 1;
    foreach my $sq (@ssqn) {
        my $nvalue = 0;
        my $zcount = 0;
        my $ssq_tl = r_ssq_tl($sq);
        for my $p ( 0..$LEVEL-1 ) {     
            for my $q (0..$LEVEL-1) {
                my $alpha = $board[$ssq_tl+$p+$q*$E_LEN]; 
                if ($alpha != "z") {
                    if ( ($bit_repr{$alpha} & $nvalue) > 0) {  #repeat appearance
                        return undef;
                    }
                    $nvalue += $bit_repr{$alpha};
                } else 
                {
                    $zcount++;
                }
        }}
        if ($zcount == 0 and $nvalue == 0) {
            return undef;
        }
    }
    return $bool;
}


# ==== end of checking lines

# ==== algorithmic stuff



sub come_bk_from_fail_attempt {
    die "Too much recursion" if $#tree > 5001;  #appear when $LEVEL > 3
    my $naughty = pop @tree;

    # print "$#tree\n";      this line is for testing
    if (!($naughty)) {
        print "here";
        &declare_impossibility;
    }

    # act on the board to return the board to a proper value

    if (defined($naughty->nexts)) {
        # pop @{$naughty->nexts};   #seem no difference? 
        $board[$naughty->position] = 'z';

        die "TRY AGAIN" if $#tree == -1;

        my $leaf = \($tree[$#tree]);

        if (!($$leaf->nexts) && $$leaf->is_stable) {
                print "here";
                &declare_impossibility;
        }

         if ($naughty->depth == $$leaf->depth+1) {
            if (!($$leaf->nexts) && $$leaf->is_stable) {
                print "there";
                &declare_impossibility;
            }
             
        }
        if (scalar @{$$leaf->nexts} <= 1) {
            #  print "======================= need here\n"; #Testing lines
            my $active = pop @tree;
            $board[$active->position] = 'z';
            &come_bk_from_fail_attempt;
        }
    } else {
        print "zere"; 
        &declare_impossibility;
    }
}

sub declare_impossibility {
    TEST_print_board;
    die "-1\nImpossible arrangement!";
}

sub check_complete {
    if (countz() == 0) {
        # can add checking lines here
        return 1;
    }
    return undef;  
}

sub action_on_new_node {
    my $leaf = \$tree[$#tree];
    #  print "tree id: $#tree   pos: ", $$leaf->position; 
    #  print " val:", $$leaf->value , "\n"; 
    # the above printing is for various testings 
    if (defined($$leaf) && defined($$leaf->position)) {
        $board[$$leaf->position] = $$leaf->value;
        
        my $pos = &choose_an_empty_entry;
        my $p_value = choose_possible_values_for_entry($pos) if defined($pos);
        if (defined($pos) && @{$p_value} ) {
            for my $v (@{$p_value}) {  
                push @{$$leaf->nexts}, 
                    node->new($pos, $v, 0, ($$leaf->depth)+1, []);
            }
            # push @tree, reverse @{$$leaf->nexts};
            # my $trial = shift @{$$leaf->nexts};
            # push @tree, $trial;
            
             my $trial = shift @{$$leaf->nexts};
             push @tree, @{$$leaf->nexts};
             push @tree, $trial;
        } else
        { if (!check_complete()) {
                # print "location A \n";    #TESTING LINES
                come_bk_from_fail_attempt;
            }
        }
    } else 
    {
        # print "location B \n";
        come_bk_from_fail_attempt;
    }
}


sub bitstr_to_set_of_alphabets {
    my $bitstr = $_[0];
    my @set = ();
    for my $p (0..$E_LEN-1) {
        my $temp = 2**$p;
        if ($temp & $bitstr) {
            push @set, $ABT[$p];
        }
    }
    return \@set;
}

sub choose_an_empty_entry {
    my @emptyentry_pos;
    for my $i (0..$BSIZE-1) { push @emptyentry_pos,$i if $board[$i] eq 'z';}
    
    my $min_opp = $E_LEN;
    my @candidate_small;
    for my $i (@emptyentry_pos) {
        my $temp_i = scalar @{choose_possible_values_for_entry($i)} ;
        if ($temp_i < $min_opp) {
            $min_opp = $temp_i;
            @candidate_small = ($i)
        } elsif ( $temp_i == $min_opp ) 
        {
            push @candidate_small, $i;
        }
    }
    
    @candidate_small = random_an_array(@candidate_small);
    return $candidate_small[0];
}

sub choose_possible_values_for_entry {
    my $e = $_[0];

    my $impos_set = 0;

    #rows
    for (0..$E_LEN-1)
    {
        my $coo = $E_LEN*coord_to_nth_row($e) + $_;
        $impos_set = $impos_set | 2**num_repr($coo) if $board[$coo] ne 'z';
    }   

    #columns
    for (0..$E_LEN-1) {
        my $coo = coord_to_nth_col($e) + $_*$E_LEN;
        $impos_set = $impos_set | 2**num_repr($coo) if $board[$coo] ne 'z';
    }
    
    #small squares
    my $sq_e = (int ($e / $LEVEL) % $LEVEL) + $LEVEL * int ($e / $LEVEL / $E_LEN ); 
    for my $p (0..$LEVEL-1) {
        for my $q (0..$LEVEL-1) {
             my $coo = r_ssq_tl($sq_e) + $p + $q*$E_LEN;
             $impos_set = $impos_set | 2**num_repr($coo) if $board[$coo] ne 'z';
        }
    }
    
    my $bit_opp = ( ~ $impos_set ) & $BITWORLD;
    return [@{bitstr_to_set_of_alphabets($bit_opp)}];
}


sub random_an_array {
    my $size = scalar @_;
    my @original = @_;
    my %assist = ();
    my @arrangement;
    for (@original) {
       $assist{$_} = int(1 + rand $size);
    }
    @arrangement = sort { $assist{$a} <=> $assist{$b}} (keys %assist);
    return @arrangement;
}

sub countz {
    my $ans = 0;
    for my $p (0..$BSIZE-1) {
        $ans++ if $board[$p] eq "z" ;
    }
    return $ans;
}

# ===== all procedural stuffs are coming!

#*** heart of this script ***************
sub main {
    my $o = &choose_an_empty_entry;
    $tree[0] = node->new($o, 'z', 1, 0, [] ); #create tree root

    for my $v (@{choose_possible_values_for_entry($o)}) {
       push @tree, 
           node->new($o, $v, 0, 1, []); 
    }
    while ( &countz > 0) { 
        action_on_new_node;
    }
    if (check_complete) {
        internal_repr_to_trad_3 if $LEVEL == 3; 
        internal_repr_to_trad if $LEVEL >= 4; 
        print "\n"; 
        # &initialize;  # next round?
        exit;
    };
}

sub initialize {
    @board = ('z') x $BSIZE;
    @tree = (); #Depth-first search, a stack of nodes
}

# for my $t (1..1000) {main(); print $t,"\n";}
# the above is a line for testing 9x9 sudoku

main();
