# Task 2 of the Weekly Challenge 331
# https://theweeklychallenge.org/blog/perl-weekly-challenge-331/#TASK2

say is-buddy-strings('fuck', 'fcuk'); # True
say is-buddy-strings('love', 'love'); # False
say is-buddy-strings('fodo', 'food'); # True
say is-buddy-strings('feed', 'feed'); # True


sub is-buddy-strings($str1, $str2) {
    for 0..^$str1.chars - 1 -> $i {
        return True if 
            $str2 eq $str1.substr(0, $i) ~ 
                     $str1.substr($i + 1, 1) ~ 
                     $str1.substr($i, 1) ~ 
                     $str1.substr($i + 2, $str1.chars - $i);
    }

    return False;
}
