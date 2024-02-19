sub merge ($s1, $s2) {
 roundrobin($s1.comb, $s2.comb).flat.join
}

merge("abcd", "1234").say;
merge("abc", "12345").say;
merge("abcde", "123").say;
