#!/usr/bin/env raku

say seq-num(< ab1234 cd5678 ef1342 >);
say seq-num(< pq1122 rs3334 >);
say seq-num(< ab1234 cd5678 ef1342 pq1122 rs3334 
              xy5529 zz9999 wx8822 hi4321 jr9876 
              br5050 er7752 us3435 mn1029 cd9368 >);

sub seq-num(+$list)
{
    my $n = '00';
    $list.map({ .subst(/^ <lower> ** 2 /, $n++) })
}
