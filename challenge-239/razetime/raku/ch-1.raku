sub ch1{([~] $^a)===([~] $^b)}

say ch1(("ab", "c"),("a", "bc")); # true
say ch1(("ab", "c"),("ac", "b")); # false
say ch1(("ab", "cd", "e"),("abcde")); # true
