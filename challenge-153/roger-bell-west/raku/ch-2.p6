#! /usr/bin/perl6

use Test;

plan 2;

is(factorion(145),True,'example 1');

is(factorion(125),False,'example 2');

sub factorion($input) {
    if ($input == 0) {
        return False;
    }
    my @fd;
    @fd.push(1);
    my $ff=1;
    for (1..9) -> $i {
        $ff *= $i;
        @fd.push($ff);
    }
    my $working=$input;
    my $dsum=0;
    while ($working > 0) {
        $dsum += @fd[$working % 10];
        $working=floor($working/10);
    }
    return $input==$dsum;
}
