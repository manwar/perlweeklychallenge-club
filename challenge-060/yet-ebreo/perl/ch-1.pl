#!/usr/bin/perl
use strict;
use warnings;
use feature 'say';

sub to_num  {
    (ord) - 64 + 26 * (&to_num||0) if $_ = chop @_
}
sub to_exl {
    $% = pop;
    while ($%>26) {
        $" = chr (64 + $% - 26*($% /= 26)) . $";
    }
    chr(64 + $%).$"
}
my $excelcol = uc ($ARGV[0]||2708874);

if ($excelcol=~/\D/) {
    say to_num($excelcol);
} else {
    say to_exl($excelcol);
}
=begin
perl .\ch-1.pl 2708874 
EXCEL

perl .\ch-1.pl 1
A

perl .\ch-1.pl A
1

perl .\ch-1.pl 26
Z

perl .\ch-1.pl Z
26

perl .\ch-1.pl 661
YK

perl .\ch-1.pl YK
661

perl .\ch-1.pl 16384
XFD

perl .\ch-1.pl XFD
16384

perl .\ch-1.pl 214358502
RABBIT

perl .\ch-1.pl RABBIT
214358502

=cut