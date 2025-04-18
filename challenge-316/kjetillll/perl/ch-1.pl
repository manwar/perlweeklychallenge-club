sub f { "@_" !~ /(.) (?!\1)/ }

print   f("perl", "loves", "scala")           ? "ok\n" : "error\n";  # true
print ! f("love", "the", "programming")       ? "ok\n" : "error\n";  # false
print   f("java", "awk", "kotlin", "node.js") ? "ok\n" : "error\n";  # true
print   f("ISI","I","IJK","KAREN")            ? "ok\n" : "error\n";  # true
print ! f("ISI","I","KJK","KAREN")            ? "ok\n" : "error\n";  # false
