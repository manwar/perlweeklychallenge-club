#!/usr/bin/env raku


(1 .. *).first({ $_ <<*<< (1 .. 6) andthen .map(*.comb.List) andthen [(==)] $_ }).say;
