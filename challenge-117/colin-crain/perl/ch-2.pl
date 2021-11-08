#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       triangular-tour.pl
#
#
#       Find Possible Paths
#         Submitted by: E. Choroba
#         You are given size of a triangle.
# 
#         Write a script to find all possible paths from top to the bottom right
#         corner.
# 
#         In each step, we can either move horizontally to the right (H), or
#         move downwards to the left (L) or right (R).
# 
#         BONUS: Try if it can handle triangle of size 10 or 20.
# 
#         Example 1:
#         Input: $N = 2
# 
#                    S
#                   / \
#                  / _ \
#                 /\   /\
#                /__\ /__\ E
# 
#         Output: RR, LHR, LHLH, LLHH, RLH, LRH
#         Example 2:
#         Input: $N = 1
# 
#                    S
#                   / \
#                  / _ \ E
# 
#         Output: R, LH
# 
#         method:
#         
#         verified to n=13:
#         
#         A006318       Large Schröder numbers (or large Schroeder numbers, or big
#         Schroeder numbers). 
#         1, 2, 6, 22, 90, 394, 1806, 8558, 41586, 206098, 1037718, 5293446,
#         27297738, 142078746, 745387038, 3937603038, 20927156706, 111818026018,
#         600318853926, 3236724317174, 17518619320890, 95149655201962,
#         518431875418926, 2832923350929742, 15521467648875090
# 
#         tp(n) = S(n+1)
# 
#         tp(10) =          1_037_718
#         tp(20) = 17_518_619_320_890
# 

#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';

my $tri_size = shift // 10;
my $mat = [ map { ['L' x $_] } (0..$tri_size) ];

for my $pos (1..$tri_size) {            ## horz position in the tri
    my @next;
    for my $level ($pos..$tri_size) {   ## tri level
            push $next[$level]->@*, (map { $_ . 'L' } $next[$level-1]->@*) 
                if defined $next[$level-1];
            push $next[$level]->@*, (map { $_ . 'R' } $mat->[$level-1]->@* );
            push $next[$level]->@*, (map { $_ . 'H' } $mat->[$level]->@*)
    }
    $mat = \@next;
}

say "results: ", scalar $mat->[-1]->@*;;
say $_ for $mat->[-1]->@*;



=cut
[colincrain@boris:~/Code/PWC]$  time perl triangular-tour-3.pl 10
result:
1037718

real	0m0.916s
user	0m0.842s
sys	0m0.070s
[colincrain@boris:~/Code/PWC]$  time perl triangular-tour-3.pl 11
result:
5293446

real	0m4.694s
user	0m4.311s
sys	0m0.377s
[colincrain@boris:~/Code/PWC]$  time perl triangular-tour-3.pl 12
result:
27297738

real	0m24.150s
user	0m22.166s
sys	0m1.974s
[colincrain@boris:~/Code/PWC]$  time perl triangular-tour-2.pl 13
result:
142078746

real	6m52.523s
user	2m42.176s
sys	2m48.754s           <-- grinding
