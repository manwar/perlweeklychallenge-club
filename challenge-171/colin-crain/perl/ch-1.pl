#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       let-me-make-this-abundantly-clear.pl
#
#     Abundant Number
#         Submitted by: Mohammad S Anwar
#         Write a script to generate first 20 Abundant Odd Numbers.
# 
#         According to wikipedia,
# 
# 
#         A number n for which the sum of divisors σ(n) > 2n, or,
#         equivalently, the sum of proper divisors (or aliquot sum) s(n) >
#         n.
# 
# 
#         For example, 945 is the first Abundant Odd Number.
# 
#         Sum of divisors:
#         1 + 3 + 5 + 7 + 9 + 15 + 21 + 27 + 35 
#           + 45 + 63 + 105 + 135 + 189 + 315 = 975

#         discussion:
# 
#         In number theory, a defining process in the the field is finding
#         relationships between divisors and the number they multipy to,
#         and exloring performing other operations on these divisor sets
#         such as summing them.
# 
#         What is a divisor, though? There are always two divisors for a
#         number: the multiplicative identity, 1, and the number itself. In
#         the case of the number 1 these two are the same number but can be
#         conceptually considered to be different if you want to view the
#         rules as applying across all numbers. After all, the
#         multiplicative identity times any number results in the original
#         number by definition, and the inverse is also truem that any
#         number divided by itself equals 1. And 1 x 1 = 1 or course so it
#         works out.
# 
#         Although the number itself is sometimes included in a list of
#         divisors under this reasoning, it generally is not, under a
#         different philisophical distinction: in dividing a thing, the
#         collection of parts found to make up the whole is known as the
#         alliquot set. Viewed this way the thing itself undivided has no
#         separate components so is not a portion of itself.
# 
#         The idea of nothing as being a real thing is arguably a
#         relatively new idea in mathematics, as it so self-evidently is
#         nothing. The ancient Greek mathematicians had a serious
#         philosopical problem on their hands with the notion.
# 
#         The most common understanding of divisors, with respect to number
#         theory, is all whole values that when multiplied by another whole
#         value greater than 1 yield the numberin question. So the trival
#         divisor of 1 is included, but the number itself is not. These are
#         then known as the *proper divisors*.
# 
#         For completeness I should add the definition is far from settled.
#         Negative numbers are whole and are sometimes included, and 1 and
#         -1 are sometimes explicitly excluded, as with the number itself
#         and its negative inverse.
# 
#         However as far as the relationships to summing divisors go, if we
#         include the number itself we need to change the definitions
#         slightly to adjust the target values, but with some fiddling we
#         can generate equivalent number sets within the categories.
# 
#         And what are those categories? Glad you asked.
# 
#         If the sum of the proper divisors not including the number itself
#         sum to the number, then that is known as a perfect number. If
#         they sum to less then the number is deficient. If they sum to
#         more then the number is abundant.
# 
#         The amount a divisor sum exceeds its source value is known as its
#         abundancy, and a number whose abundancy is greater than any
#         smaller number is highly abundant. If a number's abundancy
#         relative to its value — the range of abundancy frows as the
#         numbers grow larger — is higher than any smaller number than it
#         is known as a superabundant number.
# 
#         There is a lot of obvious crossover between abundant numbers and
#         numbers that happen to have a lot of divisors; numbers that stand
#         apart as having more divisors than any smaller number are known
#         as highly composite numbers. In fact all highly cpmposite numbers
#         greater than 6 are also abundant numbers.
# 
#         Like heavy-metal and EDM music, the subgenres seem to just keep
#         going down into a rabbit-hole of ever narrowly defined
#         constraints. We have for instance colossally abundant numbers and
#         superior highly composite numbers. We even have weird numbers
#         that somehow don't fit our preconcievd notions.
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

use ntheory qw( divisors );
use List::Util qw( sum );

use constant { LIMIT => 20 };

my @abundant;
my $candidate = 2;

while (@abundant < LIMIT) {
    my @d = divisors( $candidate );
    pop @d;
    my $s = sum @d;
    push @abundant, [$candidate, $s - $candidate, join ', ', @d] 
        if $s > $candidate;
    $candidate++;
}

## make report
say "value | abundance | divisors";
say "------+-----------+---------";
say sprintf "%5d | %-9d | %s", $_->@* for @abundant;





