my @A = (3, 2, 3, 5, 7, 5);
#my @A = (2, 1, 4, 5, 3, 7);
say ( 1..@A ).map({ |@A.rotor($_ => 1 - $_) }).max({ .min * .elems });