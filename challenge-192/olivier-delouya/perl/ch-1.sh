perl -se '$a=sprintf "%b", $x; $a =~ s/(0|1)/$1 ? 0:1/eg; print eval "0b$a"' -- -x=5

perl -se '$a=sprintf "%b", $x; $a =~ s/(0|1)/$1 ? 0:1/eg; print eval "0b$a"' -- -x=4

perl -se '$a=sprintf "%b", $x; $a =~ s/(0|1)/$1 ? 0:1/eg; print eval "0b$a"' -- -x=6
