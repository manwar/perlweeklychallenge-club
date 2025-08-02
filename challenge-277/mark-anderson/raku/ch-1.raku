#!/usr/bin/env raku
use Test;

is count-common(<Perl is my friend>, 
                <Perl and Raku are friend>),              2;

is count-common(<Perl and Python are very similar>,
                <Python is top in guest languages>),      1;

is count-common(<Perl is imperative Lisp is functional>,
                <Crystal is similar to Ruby>),            0;

sub count-common(@words1, @words2)
{
    (@words1.grep(@words1.one) (&) @words2.grep(@words2.one)).elems
}
