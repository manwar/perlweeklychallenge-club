#! /usr/bin/perl6

use Test;

plan 2;

is-deeply(sequencenumber(["ab1234", "cd5678", "ef1342"]),
          ["001234", "015678", "021342"],
              'example 1');

is-deeply(sequencenumber(["pq1122", "rs3334"]),
          ["001122", "013334"],
          'example 2');

sub sequencenumber(@list) {
    my $nn = 0;
    my @out;
    for @list -> $ins {
        @out.push(sprintf('%02d',$nn) ~ substr($ins,2,4));
        $nn++;
    }
    return @out;
}
