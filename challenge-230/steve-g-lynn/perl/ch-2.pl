#!/usr/bin/env -S perl -wl

print &count_words('at','pay','attention','practice','attend'); #2
print &count_words('ja','janet','julia','java','javascript'); #3


sub count_words {
    my ($prefix, @words)=@_;
    
    scalar grep /^$prefix/, @words;
}


