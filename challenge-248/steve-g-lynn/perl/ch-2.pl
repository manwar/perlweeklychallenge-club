#!/usr/bin/env -S  perl -wl

use PDL;
use Inline Pdlpp;

my $mat=pdl([[1,2,3,4],[5,6,7,8],[9,10,11,12]]); 
print $mat->submatrix_sum;
#[
# [14 18 22]
# [30 34 38]
#]

$mat=pdl([[1,0,0,0],[0,1,0,0],[0,0,1,0],[0,0,0,1]]); 
print $mat->submatrix_sum;
#[
# [2 1 0]
# [1 2 1]
# [0 1 2]
#]

__DATA__

__Pdlpp__

pp_def('submatrix_sum',
    Pars => 'a(m,n); [o]b(p,q);',
    RedoDimsCode => '$SIZE(p)=$SIZE(m)-1; $SIZE(q)=$SIZE(n)-1;',
    Code => q{
        PDL_Indx i, j, m_size, n_size;
        m_size=$SIZE(m)-1;
        n_size=$SIZE(n)-1;
        for (i=0; i < m_size; i++) {
            for (j=0; j < n_size; j++) {
                $b(p=>i, q=>j)=
                $a(m=>i, n=>j)+$a(m=>i+1, n=>j+1)+
                $a(m=>i, n=>j+1)+$a(m=>i+1, n=>j);
            }
        }
    },
);
