#!/usr/bin/env perl6

print &makeover('ÃÊÍÒÙ');
#AEIOU

print &makeover('âÊíÒÙ');
#aEiOU

sub makeover( $string ) {   
    return qqx{echo $string | iconv -f utf-8 -t ascii//translit};
}
