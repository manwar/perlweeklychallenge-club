use v6;
sub is-palindromic(Str() \s) { s.flip eq s }
^1000 ==> grep(*.&is-palindromic) ==> grep(*.is-prime) ==> say()
