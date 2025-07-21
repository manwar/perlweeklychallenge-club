sub f{ pop =~ /(\w+)\s*$/; length $1 }
    
print f('The Weekly Challenge') == 9 ? "ok\n" : "err\n";
print f('   Hello   World    ') == 5 ? "ok\n" : "err\n";
print f("Let's begin the fun")  == 3 ? "ok\n" : "err\n";
