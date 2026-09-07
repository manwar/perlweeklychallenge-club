#!/usr/bin/env raku
use Test;

is atoms-count("((N2O)3(H2O)2)2"),    "H8N12O10";
is atoms-count("Mg3(PO4)2"),          "Mg3O8P2";
is atoms-count("(((H)2)3)4"),         "H24";
is atoms-count("NaCl3(O2(S10)2)2Mg"), "Cl3MgNaO4S40";
is atoms-count("Z2Y3(X2W)2"),         "W2X4Y3Z2";

sub atoms-count($str is copy)
{
    $str ~~ s:g/ <alpha> <?before <upper> || ')' || '(' || $> /{ $/ ~ 1 }/;

    Nil while $str ~~ s/'(' (<alnum>+) ')' (<digit>+)/{ f($0, $1) }/;

    return $str.comb(/ <alpha>+ || <digit>+ /).pairup.Bag.sort>>.kv
               .flat.join.subst(/<?after <alpha>> 1 <?before <upper>>/, :g);
    
    sub f($s is copy, $n) { $s.subst(/<digit>+/, { $/ * $n }, :g) }
}
