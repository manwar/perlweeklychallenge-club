#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
# 
#       rare-numbers.pl
#
#         TASK #1 › Rare Numbers
#         Submitted by: Mohammad S Anwar
#         You are given a positive integer $N.
# 
#         Write a script to generate all Rare numbers of size $N if exists.
#         Please checkout the page for more information about it.
# 
#         Examples
#         (a) 2 digits: 65
#         (b) 6 digits: 621770
#         (c) 9 digits: 281089082
#
# 
#
#     method: 
#         Let's start by making the broad statement that fast as Perl may be,
#         using an interpreted language for this sort of massive raw computation
#         is just foolish. There is a reason Mr. Gupta chose FORTRAN I assume, for
#         same reason it persists to this day among certain scientific
#         data-crunching adherents: it's fast — very, very fast — at numerical
#         processing.
# 
#         Perl, in all the joy of expressiveness it brings to the table, is just
#         ill-suited. Of course it can be used to attack the problem, but will
#         always run up against certain walls when processing 10 billion numbers.
# 
#         The biggest optimization is limiting the first digit to 2,4,6, or 8, and
#         advancing the iterator one at the outer order of magnitude rather than a
#         simple `next`. This cuts the number of iterations 55% immediately at the
#         cost of the performing one `substr` on the test value.
# 
#         After this, however, it becomes a trade-off on doing more expensive
#         `substr` operations, poking about at extracting individual digits, and
#         the associated conditionals to determine whether to jump to the next
#         iteation, against the rather expensivve `sqrt` operation to check for
#         perfect squares.
# 
#         Needless to say the gains in jumping over a hundred million values are
#         quite a bit more obvious than short-circuiting out to the next
#         incremental candidate. 

#         Unfortunately the further "optimizations" given are not as effective,
#         ultimately becoming a tradeoff between the iterations and expesive
#         computation saved versus the added ovverhead of implementation,
#         leading to diminishing returns.
# 
#         The next set though, of examining the relationships between the first
#         and last digits, yielded quite good results, reducing the number of
#         squareroot operations about 5 times further. At this point the
#         iterations for a 4-digit value have been reduced from 8999 to start
#         (numbers between 1000 and 9999), to 4399 after filtering for even lead
#         digits, to about 800 after skipping impossible combinations of first
#         and last digits.

#         Simply short-circuiting out of an invalid combination of digits did
#         not, however, produce much gain in computation time. Using `next` did
#         not change the actual number of iterations, only avoiding further
#         intensive computation within a given loop. The `substr` operations to
#         gather the relevant digits and the the added complexity ate in to any
#         effort saved, resulting in only a samll tim ereduction.
# 
#         The potential gains were not truly realized until I managed to not
#         just short-circut the loop but reconfigure things entirely to skip
#         whole blocks of values in the incrementation phase, essentially
#         unrolling the large pattern of allowed values over each set of
#         permissable combinations. This required a new counter for the tens
#         place that allowed proper rollovers between the sets.
# 
#         This was pretty tedious work, but paid off in a nearly fourfold
#         increase in execution speed.
# 
#         Further implementation of the second and second-to-last digits was not
#         nearly as effective. In the end the reduction was minimal and all the
#         unrolled incrementation was, well tedious no longer covered it.
# 
#         It felt a lot like assembler, to be honest, so rather than attempt to
#         refine it further it was clear there would be no more orders of
#         magnitude available to trim ahead of us. I threw in the towel at
#         10-digit numbers, taking 509 seconds to find the 2 rare numbers there.
#         
#         
#         
#         
#         The abandoned  next level of complexity. Unrolling these loops could
#         be done, but would be maddening, and the only way to see any gains.
# 
#             If A == 8 then Z == 2, 3, 7 or 8: 
#                 if Z = 2 then: 
#                     B + tens == 9, 
#                 if Z = 3 then:
#                     B - tens == 7  when B > tens 
#                     B - tens == -3 when B < tens 
#                     B can never be equal to tens, 
#                 if Z == 7 then:
#                     B + tens == 11 when B > 1 
#                     B + tens == 1  when B < 1, 
#                 if Z == 8 then B == tens.
# 
# 
# 
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";

my $then = time;

my $order = shift @ARGV || 9;

my $test = 10**($order-1);
my $end  = 10**$order;
my @out;

my $tens = 0;

while ($test < $end) {
    
    my $A = substr $test, 0, 1;
    if ($A % 2 == 1) { 
        $test += 10**($order-1);
        next;
    }

    my $Z = substr $test, -1, 1; 

    ## 2s
    if ($A == 2 and $Z == 0) {
        $test += 2;
    }
    elsif ($A == 2 and $Z > 2) {
        if ($tens == 9) {
            $test += 7;
            $tens = 0;
            next;
        }
        $test += 9;
        $tens++;
    }
    
    ## 4s
    if ($A == 4 and $Z > 0) {
        if ($tens == 9) {
            $test += 9;
            $tens = 0;
            next;
        }
        $test += 9;
        $tens++;
    }

    ## 6s 
    if ($A == 6 and $Z == 1) {
        $test += 4;
    }
    elsif ($A == 6 and $Z == 6) {
        if ($tens == 9) {
            $test += 4;
            $tens = 0;
            next;
        }
        $test += 4;
        $tens++;
    }

    ## 8s
    if    ($A == 8 and $Z == 0) {
        $test += 2;
    }
    elsif ($A == 8 and $Z == 4) {
        $test += 3;
    }
    elsif ($A == 8 and $Z == 9) {
        if ($tens == 9) {
            $test += 1;
            $tens = 0;
            next;
        }
        $test +=3;
        $tens++;
    }

    
## the second and second-to-last optimizations, not yet unrolled:
## 333 seconds for order == 9    
# 
#     my $A = substr $test, 0, 1;    
#     $A % 2 == 1 and $test += 10**($order-1);
#     
#     my $B = substr $test,  1, 1;
#     my $P = substr $test, -2, 1;
#     my $Q = substr $test, -1, 1;
# 
#     if ($A == 2)    {
#         next if $Q != 2;
#         next unless ($B - $P) % 2 == 0;
#     } 
#     elsif ($A == 4) {
#         next if $Q != 0;
#         next unless abs(($B - $P) % 2) == 1;
#     } 
#     elsif ($A == 6) {
#         next unless ($Q == 0 or $Q == 5);
#     } 
#     else {                                      ## $A == 8
#         if    ($Q == 2) {
#             next unless $B + $P == 9;
#         }
#         elsif ($Q == 3) {
#             next if $B == $P;
#             if ( $B > $P ) {
#                 next unless $B - $P == 7;
#             }
#             next unless $B - $P == -3;
#         }
#         elsif ($Q == 7) {
#             if ($B > 1) {
#                 next unless $B + $P == 11;
#             }
#             if ($B == 0) {
#                 next unless $P == 1;
#             }
#         }
#         elsif ($Q == 8) {
#             next unless $B == $P;
#         }
#         else {
#             next;
#         }              
#     }

    my $rev = reverse $test;
    if (    $test == $rev 
         or $test - $rev < 0
         or int(sqrt($test-$rev))**2 != ($test-$rev)
         or int(sqrt($test+$rev))**2 != ($test+$rev)  ) {
                $test++;
                next;
    }

    push @out, $test;
    $test++;
}

say $_ for @out;

say "time: ", time - $then;

