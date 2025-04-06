sub eqstrops {
    "@_" =~ / ^ (\w+) \w* ( \s \1 \w* )* $ /x
        ? length($&)  -  @_  +  1  -  @_ * length($1)
        : -1
}

print eqstrops( "abc", "abb", "ab"  ) ==  2 ? "ok\n" : "err\n";
print eqstrops( "ayz", "cyz", "xyz" ) == -1 ? "ok\n" : "err\n";
print eqstrops( "yza", "yzb", "yzc" ) ==  3 ? "ok\n" : "err\n";
