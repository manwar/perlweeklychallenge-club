for "1ac2.34f0.b1c2", "abc1.20f1.345a" -> $test {
    $_ = $test;
    s:g/\./:/;
    s:g/(\w\w)(\w\w)/$0:$1/;
    .say;
}
