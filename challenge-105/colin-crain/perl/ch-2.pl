#! /opt/local/bin/perl
#
#       name-game.pl
# 
#         The Name Game
#         Submitted by: Mohammad S Anwar
#         You are given a $name.
# 
#         Write a script to display the lyrics to the Shirley Ellis song The
#         Name Game. Please checkout the wiki page for more information.
# 
#         Example
#         Input: $name = "Katie"
#         Output:
# 
#             Katie, Katie, bo-batie,
#             Bonana-fanna fo-fatie
#             Fee fi mo-matie
#             Katie!
#
#       rules:
#         (X), (X), bo-b (Y)
#         Bonana-fanna fo-f (Y)
#         Fee fi mo-m (Y)
#         (X)!
#  
#         If the name starts with a b, f, or m, that sound simply is not
#         repeated. For example: Billy becomes "Billy Billy bo-illy"; Fred
#         becomes "bonana fanna fo-red"; Marsha becomes "fee fi mo-arsha"[2]
# 
# 
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';

my $name = shift @ARGV || "Katie";
make_song($name, chop_syl($name));

sub chop_syl ($name) {
    $name =~ /([^aeiou]?)(.*)/i;
    my ($head, $tail) = ($1, $2);
    return ($head, lc($tail));
}


sub make_song ($name, $head, $tail) {
    my ($b, $f, $m) = ('' x 3);
    $b = 'b' unless substr($head, 0, 1) eq 'B';
    $f = 'f' unless substr($head, 0, 1) eq 'F';
    $m = 'm' unless substr($head, 0, 1) eq 'M';
    
    say<<"END";
    ${name}, ${name}, bo-${b}${tail},
    Bonana-fanna fo-${f}${tail}
    Fee fi mo-${m}${tail}
    ${name}!
END

}










# use Test::More;
# 
# is 
# 
# done_testing();
