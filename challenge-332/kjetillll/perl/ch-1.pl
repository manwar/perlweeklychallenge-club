sub f { pop =~ s{ \d+ }{ sprintf "%b", $& }xger }

print f( "2025-07-26" ) eq "11111101001-111-11010"   ? "ok\n" : "error\n";
print f( "2000-02-02" ) eq "11111010000-10-10"       ? "ok\n" : "error\n";
print f( "2024-12-31" ) eq "11111101000-1100-11111"  ? "ok\n" : "error\n";
print f( "2025-09-32" ) eq "11111101001-1001-100000" ? "ok\n" : "error\n"; #hm
