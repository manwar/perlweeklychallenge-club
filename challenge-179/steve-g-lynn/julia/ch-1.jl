#!/usr/bin/env julia

#-- this is really perl 5 using the Lingua::EN::Numbers module
#-- illustrates calling perl 5 one-liners from Julia

#-- https://docs.julialang.org/en/v1/manual/running-external-programs/

run(`perl -MLingua::EN::Numbers -e 'print Lingua::EN::Numbers::num2en_ordinal(11),"\n"'`)

run(`perl -MLingua::EN::Numbers -e 'print Lingua::EN::Numbers::num2en_ordinal(62),"\n"'`)

run(`perl -MLingua::EN::Numbers -e 'print Lingua::EN::Numbers::num2en_ordinal(99),"\n"'`)


