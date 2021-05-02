#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       phone-block.pl
#
#       Valid Phone Numbers
#         Submitted by: Mohammad S Anwar
#         You are given a text file.
# 
#         Write a script to display all valid phone numbers in the given text file.
# 
#         Acceptable Phone Number Formats
#             +nn  nnnnnnnnnn
#             (nn) nnnnnnnnnn
#             nnnn nnnnnnnnnn
# 
#         Input File
#             0044 1148820341
#              +44 1148820341
#               44-11-4882-0341
#             (44) 1148820341
#               00 1148820341
# 
#         Output
#             0044 1148820341
#              +44 1148820341
#             (44) 1148820341
# 
#
#         method:
#             we are given a specific text file which we will assume is selected
#             to be representative of the typical data:
#                 * 1 possible number per line
#                 * possible whitespace before and after
#                 * internal whitespace between beginning and end block is
#                   significant
# 
#             the '00' prefix on the last line seems like it should be
#             disqualifying, but it's already out for not wearing the proper
#             attire. So it is not removed for its insensibility but rather its
#             sartorial malfesance. I have no idea what city codes (?) are or
#             are not allowed. 
# 
#             These rules seem pretty strict; over here we tolerate phone
#             numbers in a little more variety of related formats:
#                   (212) 555-1212
#                    (212)555-1212
#                     212-555-1212
#                     212.555.1212
#             or even 212 555 1212
# 
#             although the parentheses if present are exclusively around the
#             area code, other combinations of dashes, dots and spaces can be
#             found in the wild and all are considered perfectly acceptable.
# 
#             the most important part being the breaking into 3 digits, 3 digits
#             and 4 digits. The delimiters are varied, the single dot being the
#             most recent addition, but still decades old by now. Rarely you
#             might still see a number without an area code, but I live in a big
#             city and haven't seen this for years. I have, in my life, lived in
#             communities where is was acceptable to go with the last four
#             digits if the others could be assumed to be the common exchange
#             prefix (and at that point the area code is obvious). I'm not sure
#             when the last time I was not required to dial an area code.
# 
#             to me the ten-number segment looks brutal to scan. Just sayin'.
#                
#             to solve the task we will write a regular expression that will
#             match the three valid cases. Woe to those who stray from the path
#             of rightousness.
#         


#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';

@ARGV = qw( phone-numbers.txt );
my @numbers;

my $regex = qr/((?: \d{4} | \(\d\d\) | \+\d\d ) \s \d{10}) (?!\d)/x;

while (<>) {
    push @numbers, $_ for /$regex/;
}

say $_ for @numbers;



