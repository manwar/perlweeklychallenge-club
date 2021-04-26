#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       four-sq-permute.pl
#
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
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";
use feature qw(signatures);
no  warnings 'experimental::signatures';

use Algorithm::Combinatorics qw(permutations);
use List::Util 1.56 qw(sum zip);   ## need 1.56 for zip

if (@ARGV == 7) {
    my @sol = find_solutions(\@ARGV);
    say "Input list: @ARGV";
    say scalar @sol, " solutions found.\n";
    if (@sol) {
        report($_) for @sol; 
    }
}
else {
    for my $s (-10..10) {
        my @list = ($s..$s+6);

        my @sol = find_solutions(\@list);
        next if not @sol;

        say "+++++++++++++++++++++++++++++\n";
        say "Input list: @list";
        say scalar @sol, " solutions found.\n";
        report($_) for @sol;
    }
}

sub find_solutions ($list) {
    my @out;    
    for my $candidate ( permutations($list) ) {
        my $n = validate($candidate);
        push @out, [$candidate, $n] if defined $n;
    }

    return @out;
}

sub validate ($r) {
    my $n = $r->[0] + $r->[1];
    return $n if     $n 
                 ==  $r->[1] + $r->[2] + $r->[3] 
                 ==  $r->[3] + $r->[4] + $r->[5] 
                 ==  $r->[5] + $r->[6] ; 
    return undef;
}   

sub report ($sol) {
    my ($list, $num) = $sol->@*;
    
    say<<~"HEAD";
        ===============================
        Solution:
            Sum:    $num for all squares
            Values:
    HEAD
    
    my @lets = zip ['a'..'g'], $list;
    for (@lets) {
        say "\t\t$_->[0] = $_->[1]";
    }
        
    say<<~"TAIL";
    
        ===============================
    TAIL
}







