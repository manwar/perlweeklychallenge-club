sub f {  pop() eq join('', map substr($_,0,1), @_) }

print f( "Perl", "Weekly", "Challenge",  "PWC" ) ? "ok\n" : "error\n";  #true
print f( "Bob", "Charlie", "Joe",        "BCJ" ) ? "ok\n" : "error\n";  #true
print f( "Morning", "Good",              "MM"  ) ? "error\n" : "ok\n";  #false
