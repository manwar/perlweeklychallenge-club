#!/usr/bin/env perl

use utf8;

print &makeover('ÃÊÍÒÙ');
#AEIOU

print &makeover('âÊíÒÙ');
#aEiOU

sub makeover {
    my ($string) = @_;    
    return `echo $string | iconv -f utf-8 -t ascii//translit`;
}
