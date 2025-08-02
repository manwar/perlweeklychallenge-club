sub b-after-a ($str) {
    return $str ~~ /^ <-[b]>* b <-[a]>* $/ ?? True !! False;
}

for <aabb abab aaa bbb> ->  $test {
    printf "%-5s => ", $test;
    say b-after-a $test;
}
