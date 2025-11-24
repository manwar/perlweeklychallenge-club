sub f { ( sort {$b<=>$a} map length, pop =~ /((.)\2*)/g )[0] }

print f("textbook")             == 2 ? "ok\n" : "error\n";
print f("aaaaa")                == 5 ? "ok\n" : "error\n";
print f("hoorayyy")             == 3 ? "ok\n" : "error\n";
print f("x")                    == 1 ? "ok\n" : "error\n";
print f("aabcccddeeffffghijjk") == 4 ? "ok\n" : "error\n";
