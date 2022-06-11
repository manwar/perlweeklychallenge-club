#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       book-codes.pl
#
#       ISBN-13
#         Submitted by: Mohammad S Anwar
#         Write a script to generate the check digit of given ISBN-13 code.
#         Please refer wikipedia for more information.
# 
#         Example
#           ISBN-13 check digit for '978-0-306-40615-7' is 7.

#         commentary
# 
#             The International Standard Book Number, ISBN, is labeling
#             systems designed to assign every book title published a
#             unique identifier, with separate assignments for alternate or
#             updated editions and formats. Reprints of a unaltered
#             publication run retain the same label until substantial
#             changes warrant the reclassification as a new edition.
# 
#             The modern version of this label, the ISBN-13, is a 13-digit
#             classification that when parsed descends from broad language
#             groups to areas, publshers within that area and serial block
#             assignments for publishers to label individual works. The
#             actual assignments of digits within the sections is not
#             absolutely fixed, so parsing can be complicated.
# 
#             At the end of the process a check digit is calculated as a
#             confidence check that no step within the multi-stage process
#             was mishandled, producing an incorrect ISBN.

#             Well, that's the way it's supposed to work, at least. You can
#             lead a horse to water and all that. Im fact incorrect ISBNs
#             make it into publications, and ISBNs are occasionally
#             incorrectly assigned across differing editions or outright
#             accidentally reused. Such are the perils of having publishers
#             managing the final assignment of the numeric labels. When
#             anyone with a laserprinter can become an imprint, we will end
#             up with the whole statistical gamut of competency to show for
#             it. But the system mostly works, and as the penalty for
#             fouling one's ISBN codes is dysfunction in the ability of
#             large distribution networks to order and sell your product
#             this does provide a strong motivator to get the details
#             right.

#         method

#             The ISBN-13 checksum digit is calculated by multiplying each
#             digit in the numeric code by alternating coeficients of 1 and
#             3 and then summing them. The result is taken modulo 10 and
#             the checksum is that digit that when added to the result
#             brings the total to 0. 

#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';

my @tests = ( '978-0-306-40615-7',  ## Error-Correction Coding 
                                    ##   for Digital Communications   
              '978-0-547-54927-9',  ## The Exegesis of Philip K. Dick
              '9780416469608' ,     ## Tao of Pooh
                );

for my $isbn (@tests) {
    my @arr = $isbn =~ /(\d)/g;
    my $c   = 1;
    my $sum = 0;

    $sum += $_ * (++$c * 2 % 4 + 1) for @arr[0..11];
    my $ck = 10 - $sum % 10;
    $ck == 10 and $ck = 0;          ## correct 10 -> 0

    say <<~"END";
        input      $isbn
        checksum   $ck 
    END
}








