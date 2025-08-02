sub strong-password ($pwd is copy) {
    my $count = 0;
    # At least one uppercase letter
    $pwd ~= "A" and $count++ if $pwd !~~ /<:Lu>/;
    # At least one lowercase letter
    $pwd ~= "b" and $count++ if $pwd !~~ /<:Ll>/;
    # At least one digit
    $pwd ~= "3" and $count++ if $pwd !~~ /\d/;
    # no repeating characters
    while $pwd ~~ /(.)$0**2/ {
        my $subst = ($0.ord + 1).chr;
        $pwd ~~ s/(.)$0**2/$0$0$subst/;
        $count++;
    }
    for 'a'..'z' -> $ch {
        last if $pwd.chars >= 6;
        $count++;
        $pwd ~= $ch
    }
    return $count;
}

my @tests = <a aB2 PaaSW0rd Paaasw0rd aaaaa foob>;
for @tests -> $test {
    printf "%-10s => ", $test;
    say strong-password $test;
}
