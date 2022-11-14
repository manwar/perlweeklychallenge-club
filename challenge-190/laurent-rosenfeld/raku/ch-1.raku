sub is-correct-case ($str) {
    # All lowercase or all uppercase:
    return 1 if $str ~~ /^<:Ll>+$ | ^<:Lu>+$ /;
    # One uppercase followed by only lowercase
    return 1 if $str ~~ /^<:Lu><:Ll>+$/;
    return 0;
}
for < Perl TPF PyThon raku Raku RAKU RaKu raKu > -> $str {
    printf "% -8s -> %d\n", $str, is-correct-case $str;
}
