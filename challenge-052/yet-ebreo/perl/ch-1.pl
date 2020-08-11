#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';

my ($start,$end) = @ARGV;

die ("Usage:\n\tch1.pl <start> <end>\n\n") if @ARGV<2;

my @range = ($start..$end);
my $step  = "0123456789";
my $num   = "@range ";
my %hash;
say "List of stepping number(s) from $start to $end";
while ($step =~ s/(.)(.)(.)/$2$3/) {
    my ($l,$m,$r) = ($1,$2,$3);
    $num =~ "$l$m$r "   && $hash{$&}++;
    $num =~ "$r$m$l "   && $hash{$&}++;
    $num =~ "$l$m$l "   && $hash{$&}++;
    $num =~ "$m$l$m "   && $hash{$&}++;
    $num =~ "$r$m$r "   && $hash{$&}++;
    $num =~ "$m$r$m "   && $hash{$&}++;
};

say for sort {$a-$b} keys %hash;
=begin
perl .\ch-1.pl 124 780
List of stepping number(s) from 124 to 780
210 
212
232
234
321
323
343
345
432
434
454
456
543
545
565
567
654
656
676
678
765
767

perl .\ch-1.pl 100 999
List of stepping number(s) from 100 to 999
101 
121
123
210 
212
232
234
321
323
343
345
432 
434
454
456
543
545
565
567
654
656
676
678
765
767
787
789
876
878
898
987
989
=cut