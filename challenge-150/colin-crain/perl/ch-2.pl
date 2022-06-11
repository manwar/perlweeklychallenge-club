#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       no-squares-allowed.pl
#
#       Square-free Integer
#         Submitted by: Mohammad S Anwar
#         Write a script to generate all square-free integers <= 500.
# 
#         In mathematics, a square-free integer (or squarefree integer) is
#         an integer which is divisible by no perfect square other than 1.
#         That is, its prime factorization has exactly one factor for each
#         prime that appears in it. For example, 10 = 2 ⋅ 5 is square-free,
#         but 18 = 2 ⋅ 3 ⋅ 3 is not, because 18 is divisible by 9 = 3**2.
# 
#         Example
# 
#         The smallest positive square-free integers are
#             1, 2, 3, 5, 6, 7, 10, 11, 13, 14, 15, 17, 19, 21, 22, 23, 26, 29, 30, ...
# 
#         method
# 
#             We're going to make stab at sidestepping a lot of complexity
#             solving this one. We could for instance spend alot of time
#             compiling lists of factors for each candidate value, and then
#             somehow make sure none of those factors have an integral
#             square root.
# 
#             That would be the long road; the scenic route.
# 
#             Alternately we could compile a list of the proscribed values
#             and divide each candidate in turn by them until the test
#             square is more than the candidate. Which means we need a
#             list of squares.
# 
#             Let's try that instead.
# 
#             PS: I felt like thinking through some optimizations and
#             decided I wanted to avoid constantly checking whether our
#             test square is too large to know when we can safely stop with
# 
#                 last if $sq > $candidate;
# 
#             a grep filter on the @squares list proved to be expensive and
#             we were worse off. So instead I went with creating a master
#             list of all squares we might need and a second list of valid
#             squares for a candidate, kept up-to-date by moving values
#             from one list over to the other. At each candidate the value
#             is compared against the smallest master element, and if it
#             matches we both update the working list with the new element
#             and, since we know it's equal to the candidate, fail the
#             candidate and move on. This shaved significant processing
#             time, if say we wanted 500,000 values instead of 500. Not
#             necessary but I liked the pattern of one list updating the
#             other. 
# 
#
#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';



my $max = shift // 500;

my @all_squares = map { $_ * $_ } ( 2..sqrt $max );
my @squares = shift @all_squares;
my @out;

CANDIDATE: for my $candidate ( 1..$max ) {
    if ( @all_squares && $all_squares[0] == $candidate) {
        push @squares, shift @all_squares; 
        next CANDIDATE ;
    }

    for my $sq ( @squares ) {
        next CANDIDATE unless $candidate % $sq;
    }
    push @out, $candidate;
}

while (my @temp = splice @out, 1, 10) {
    say join ',', map { sprintf "%5s", $_ } @temp
}
