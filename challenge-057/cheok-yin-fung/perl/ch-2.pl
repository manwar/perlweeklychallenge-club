#!/usr/bin/perl
use strict;
use Scalar::Util qw/dualvar/;

#Usage: $   ch-2.pl [list of words]
#e.g. ch-2.pl alphabet book carpet cadmium cadeau alpine
#output: alph , b , car , cadm , cade , alpi

my @data = @ARGV;



my $N = $#data + 1;

my $i = 0; 
my @dualv_sorted = sort {$a cmp $b} map { dualvar($i++, $_) } @data;

my @dualv_processed = ();

my $k = 1;

for (0..$N-2) {
    my $tempk = $k;
    $k = 1;
    my $first = substr($dualv_sorted[$_], 0, $k); 
  
    while ($first eq substr( $dualv_sorted[$_+1], 0, $k)) {
        $k++;
        $first = substr( $dualv_sorted[$_], 0, $k);
    }

    $first = substr($dualv_sorted[$_], 0, max($tempk, $k));
    $dualv_processed[$_] =  dualvar( $dualv_sorted[$_]+0 , "$first");
}


   $dualv_processed[$N-1] 
 = dualvar($dualv_sorted[$N-1]+0, substr($dualv_sorted[$N-1], 0, $k));


print join " , ", (sort {$a <=> $b} @dualv_processed);





sub max {
    return ($_[0] > $_[1] ? $_[0]: $_[1]); 
}
