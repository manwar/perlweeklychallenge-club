#!/usr/local/bin/jconsole

require 'regex'

NB. overwrite from 'regex'
rxapply=: 1 : 0
:
if. L. x do. 'pat ndx'=. x else. pat=. x [ ndx=. ,0 end.
if. 1 ~: #$ ndx do. 13!:8[3 end.
mat=. ({.ndx) {"2 pat rxmatches y
r=. u.&.> mat rxfrom y
r mat rxmerge y
)

molecular_formula =: verb define
    NB. compile some regexes:
    NB. match elements or closing parentheses without a factor
    hnorm =. rxcomp '(?:\p{Lu}\p{Ll}?+|\))(?!\d)'
    NB. identify isolated '1's
    hdenorm =. rxcomp '(?<!\d)1(?!\d)'
    NB. match repeated digits
    hdigit =. rxcomp '\d++'
    NB. identify parenthesized leaf groups and their factor and
    NB. match both
    hgroup =. rxcomp '\(([^()]++)\)(\d++)'

    NB. apply or remove factors '1':
    NB. normalize '(H2O)' => '(H2O1)1'
    NB. normalize inv '(H2O1)1' => '(H2O)'
    normalize =. hnorm&(,&'1' rxapply) :. ((hdenorm;'')&rxrplc)

    NB. split string of XnYm... into a N x 2 array of boxed
    NB. element / factor pairs or re-join using "split inv"
    split =. (_2 (]\) ] rxcut~ hdigit rxmatches ]) :. (;@,)

    NB. open and convert to numeric (has an inverse: convert to character and box)
    num =. ".@>

    NB. multiply all factors in y by x:
    NB. 2 mol_mult 'H2O1' => 'H4O2'
    mol_mult =. ({.@] , [ *&.(a:`num) {:@])"1&.(a:`split)

    NB. resolve a leaf group:
    NB. resolve_group '(H2O1)2' => 'H4O2'
    resolve_group =. [: (".@] mol_mult [)&>/ ] rxfrom~ (hgroup;1 2) rxmatch ]

    NB. resolve leaf groups repeatedly until no group remains
    resolve_all =. hgroup&(resolve_group rxapply)^:_

    NB. sort split list by element 
    sort_by_elem =. ] /: {."1

    NB. cumulate counts by element in split list
    cumulate_by_elem =. {."1 ([ , (+/)&.:num@])/.. {:"1

    NB. normalize, resolve all groups, split, sort, cumulate, join and
    NB. denormalize on y
    (cumulate_by_elem@sort_by_elem&.split)@resolve_all&.normalize y
)

Examples =: cutopen 0 : 0
((N2O)3(H2O)2)2
Mg3(PO4)2
(((H)2)3)4
NaCl3(O2(S10)2)2Mg
Z2Y3(X2W)2
)

Expected =: cutopen 0 : 0
H8N12O10
Mg3O8P2
H24
Cl3MgNaO4S40
W2X4Y3Z2
)

Tests =: cutopen 0 : 0
NH4NO3
(NH4)2HPO4
NH(CH2)6NHCO(CH2)4CO
)

Results =: cutopen 0 : 0
H4N2O3
H9N2O4P
C12H22N2O2
)

3 : 0 (2}. ARGV)
if.
    1 = # y
do.
    echo molecular_formula 0{:: y
elseif.
    0 = # y
do.
    try.
        assert. Expected -: molecular_formula&.> Examples
        assert. Results -: molecular_formula&.> Tests
        echo 'tests succeeded'
    catch.
        echo 'tests failed'
        echo 13!:12''
    end.
else.
    echo 'Call "./ch-2.ijs STR" to process string'
    echo 'or   "./ch-2.ijs"     to run the examples'
end.
)

exit ''