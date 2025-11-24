sub f { $_[0] =~ y/U/U/ == $_[0] =~ y/D/D/ and   #equal count of U's and D's and
        $_[0] =~ y/L/L/ == $_[0] =~ y/R/R/     } #equal count of L's and R's.

print!f("ULD")          ? "ok\n" : "error\n";
print f("ULDR")         ? "ok\n" : "error\n";
print!f("UUURRRDDD")    ? "ok\n" : "error\n";
print f("UURRRDDLLL")   ? "ok\n" : "error\n";
#print f("RRUULLDDRRUU") ? "ok\n" : "error\n"; #bug in example 5
print f("RRUULLDDrruu") ? "ok\n" : "error\n";
