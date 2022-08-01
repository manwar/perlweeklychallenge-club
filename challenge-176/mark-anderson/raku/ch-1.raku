#!/usr/bin/env raku

say (9,18...*).hyper.first({ [eqv] ((2..6) >>*>> $_).map(*.comb.Bag) }); 
