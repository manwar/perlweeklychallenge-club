perl -E 'my @a = "ABBBCDEEF" =~ /((.)\2*)/g; say join " ", map $a[$_], grep {$_ % 2 == 0} 0..$#a;'
