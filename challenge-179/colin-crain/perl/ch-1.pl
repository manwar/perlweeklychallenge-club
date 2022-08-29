#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       ordinary_number_rules.pl
#
#       Ordinal Number Spelling
#         Submitted by: Mohammad S Anwar
#         You are given a positive number, $n.
# 
#         Write a script to spell the ordinal number.
# 
#         For example,
# 
#         11 => eleventh
#         62 => sixty-second
#         99 => ninety-ninth
# 
#         method:
# 
#         I am tempted to attempt this task from the ground up, but natural
#         language programming is a thicket of edge cases, and frankly
#         where do you stop?
# 
#         The breakdown really isn't *too* bad, though, with half the
#         requirement creating a written term for a number and then
#         adopting a set of special rules to the last term, which is
#         almost, but not always, "add -th and call it a day".
# 
#         Thus we get fourth, sixth and seventh, but also fifth, eighth,
#         and seventieth, which all require differrent letter conversions.
#         "eleven thousand six hundred and fifty-first" has an assorment of
#         these. All managable, but a somewhat tedious cascading of special
#         cases.
# 
#         Or we can turn to the venerable Niel Bowers, who has sorted all
#         of this stuff for us already, with every hairy detail overseen.
# 
#         We have things to do, so we will defer the added effort to allow
#         other goals. So we use Lingua::EN::Numbers  and its num2en_ordinal()
#         function, which, as in most things involving NLP, is the correct
#         way to proceed. 
#
#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';


use Lingua::EN::Numbers qw (num2en_ordinal);


my $input = shift // 11_651; ## throw that delimiter in there just to
                             ## make things wonkier
                             
say num2en_ordinal( $input );


