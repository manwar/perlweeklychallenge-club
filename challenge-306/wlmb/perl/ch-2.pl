#!/usr/bin/env perl
# Perl weekly challenge 306
# Task 2:  Last Element
#
# See https://wlmb.github.io/2025/01/27/PWC306/#task-2-last-element
use v5.36;
die <<~"FIN" unless @ARGV;
    Usage: $0 N1 N2 ...
    to repeatedly replace the two largest numbers of an array
    by their differernce, starting from N1 N2...
    FIN
my @array = @ARGV;
while(@array > 1){
    my $max = remove_max(\@array);
    my $almost_max= remove_max(\@array);
    push @array,$max-$almost_max
}
my $result = $array[0];
say "@ARGV -> $result";

sub remove_max($a){
    my @a=@$a;
    my $m=$a[my $i=0];
    ($m<$a[$_])&&($m=$a[$i=$_]) for(1..@a-1);
    return splice @$a, $i, 1;
}
