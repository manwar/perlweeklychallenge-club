" $_ ".comb.rotor(3 => -2).map({.[1] eq '?' ?? ('a'..'z').join.trans(.[0,2] => '').substr(0, 1) !! .[1]}).join
