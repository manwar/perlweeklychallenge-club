#!/usr/bin/env perl6
#
#
#       four-square-permute.raku
#
#         TASK #2 › Four Squares Puzzle
#         Submitted by: Mohammad S Anwar
#         You are given four squares as below with numbers named a,b,c,d,e,f,g.
# 
#                       (1)                    (3)
#                 ╔══════════════╗      ╔══════════════╗
#                 ║              ║      ║              ║
#                 ║      a       ║      ║      e       ║
#                 ║              ║ (2)  ║              ║  (4)
#                 ║          ┌───╫──────╫───┐      ┌───╫─────────┐
#                 ║          │   ║      ║   │      │   ║         │
#                 ║          │ b ║      ║ d │      │ f ║         │
#                 ║          │   ║      ║   │      │   ║         │
#                 ║          │   ║      ║   │      │   ║         │
#                 ╚══════════╪═══╝      ╚═══╪══════╪═══╝         │
#                            │       c      │      │      g      │
#                            │              │      │             │
#                            │              │      │             │
#                            └──────────────┘      └─────────────┘
#         Write a script to place the given unique numbers in the square box so that sum of numbers in each box is the same.
# 
#         Example
#         Input: 1,2,3,4,5,6,7
# 
#         Output:
# 
#             a = 6
#             b = 4
#             c = 1
#             d = 5
#             e = 2
#             f = 3
#             g = 7
# 
#             Box 1: a + b = 6 + 4 = 10
#             Box 2: b + c + d = 4 + 1 + 5 = 10
#             Box 3: d + e + f = 5 + 2 + 3 = 10
#             Box 4: f + g = 3 + 7 = 10
# 
# 
# 
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



multi sub MAIN () {
    for 1..1 -> $s {
        my @list = ($s..$s+6);
    
        my @sol = find_solutions(@list);
        next if not @sol.elems;
    
        say "+++++++++++++++++++++++++++++\n";
        say "Input list: ", @list;
        say @sol.elems, " solutions found.\n";
        report($_) for @sol;
    }
}

multi sub MAIN (*@list where { @list.elems == 7 }) {
    my @sol = find_solutions(@list);
    say "Input list: ", @list.sort;
    say @sol.elems, " solutions found";
    if (@sol.elems) {
        report($_) for @sol; 
    }
}

multi sub MAIN (*@list) {
    say "please enter 7 numbers";
}

sub find_solutions (@list) {
    my @out;    
    my @pm = @list.permutations;

    for @pm -> $candidate {
        my $n = validate($candidate);
        push @out, ($candidate, $n) if defined $n;
    }

    return @out;
}

sub validate (@list) {
    my $n = @list[0] + @list[1];
    $n == @list[1] + @list[2] + @list[3] 
       == @list[3] + @list[4] + @list[5] 
       == @list[5] + @list[6] ?? $n
                              !! Nil
}   

sub report ($sol) {

    my ($list, $num) = |$sol;
    say "list  ", $list;
    say "total ", $num;
    
    
    say qq:to/HEAD/;
    
        ===============================
        Solution:
            Sum:    $num for all squares
            Values:
    HEAD
    
    my @pairs =  <a b c d e f g> Z $list.list;
    
    for @pairs {
        say "\t\t $_[0] = $_[1]";
    }
        
    say qq:to/TAIL/;
    
        ===============================
    TAIL
}


