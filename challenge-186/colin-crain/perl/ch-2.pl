#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       uni-no-local.pl

#       Unicode Makeover
#         Submitted by: Mohammad S Anwar
#         You are given a string with possible unicode characters.
# 
#         Create a subroutine sub makeover($str) that replace the unicode
#         characters with ascii equivalent. For this task, let us assume it
#         only contains alphabets.
# 
#         Example 1
#             Input: $str = 'ÃÊÍÒÙ'
#             Output: 'AEIOU'
# 
#         Example 2
#             Input: $str = 'âÊíÒÙ'
#             Output: 'aEiOU'
#
#       method:
#         
#         Let's being by saying this job, the big, job, the _real_ job, is
#         non-trivial. It's not exactly clear what a unicode character with
#         an ascii equivalent means. There are, for instance, characters
#         like the Icelandic Thorn, which map very cleanly to the English
#         ASCII characters TH. This isn't an approximation either, as the
#         glyph was orignally part of the English alphabet to designate
#         that exact sound.  
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
use open ":std", ":encoding(UTF-8)";
use charnames ':full';

use Text::Unidecode;

my $str = 'âÊíÒÙ';
my $let = $str;

say "input:     ", $str;

say "unidecode: ", unidecode( $str );
say "makeover:  ", makeover($str);

sub makeover ($str) {
    my @in = split //, $str;
    my $out;
    for (@in) {
        $out .= uni2ascii($_);
    }
    return $out;


}

sub uni2ascii ( $char ) {
    my $let = $char;
    my $hex =  sprintf '%x', ord $char;
    my $name = charnames::viacode("0x$hex");
        
    my $qualifier = '(?:AFRICAN |REVERSED |TURNED )';
    return '' if $name =~ /^COMBINING/;         ## strip combining characters

    if ($name =~ /LATIN (CAPITAL|SMALL) LETTER ([A-Z])(?:\s|\n|$)/) {
        $let = $1 eq 'SMALL' 
            ? lc($2)
            : $2 ;
    }
    
    return $let;

}



use Test::More;

is makeover( 'ÃÊÍÒÙ' ), 'AEIOU', 'ex-1';
is makeover( 'âÊíÒÙ' ), 'aEiOU', 'ex-2';
is makeover( 'resumé' ), 'resume', 'mixed ascii + unicode';
is makeover( 'Ģ' ), 'G', 'LATIN CAPITAL LETTER G WITH CEDILLA';

done_testing();
