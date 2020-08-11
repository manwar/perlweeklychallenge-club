sub MAIN($str = "AABBBBCDDEEEEFGGHH") { say $str.comb( rx/ (\w) {} $0* / ) }
