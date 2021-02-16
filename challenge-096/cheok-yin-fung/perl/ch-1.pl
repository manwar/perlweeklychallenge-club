# The Weekly Challenge 096
# Usage:
# $ perl ch-1.pl "the weekly challenge"
# challenge weekly the

$_ = $ARGV[0];
s/(\s)+/ /g ; 
@a = reverse split / /, $_;
print join " ", @a;
print "\n"
