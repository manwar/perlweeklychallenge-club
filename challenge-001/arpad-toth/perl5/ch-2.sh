perl -le 'my @num=(1..20);foreach(@num){print $_%15==0?"fizzfuzz":$_%5==0?"fuzz":$_%3==0?"fizz":$_}'
