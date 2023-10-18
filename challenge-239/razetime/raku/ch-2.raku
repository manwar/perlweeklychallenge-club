sub ch2(@a,$b){ 
  my @c=$b.split("",:skip-empty); 
  @a.map({.split("",:skip-empty)}).grep({$_ (<=)@c}).elems  
}

say ch2(("ad", "bd", "aaab", "baa", "badab"),"ab");
say ch2(("a", "b", "c", "ab", "ac", "bc", "abc"),"abc");
say ch2(("cc", "acd", "b", "ba", "bac", "bad", "ac", "d"),"cad");
