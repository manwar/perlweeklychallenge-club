#!/usr/bin/perl
use 5.40.1;
use warnings;

my $str = shift;

$str =~ s/
    \b (\w+)
    ( \s | (?: \s? <[^>]+> \s? )+ )
    (\1)
/
    "\[$1]$2\[$3]"
/igxe;

say join qq{\n}, grep { /[\[]/ } split /\n/, $str;

