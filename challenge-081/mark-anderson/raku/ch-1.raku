say common-base-strings("abcdabcd", "abcdabcdabcdabcd");
say common-base-strings("aaa", "aa");

sub common-base-strings($str1, $str2) {

    sub base-strings($str) {
        gather {
            take $str;
            take ~$_[0] for $str ~~ m:ex/(\w+)$0/;
        }
    }
    
    sort keys base-strings($str1) (&) base-strings($str2);
}
