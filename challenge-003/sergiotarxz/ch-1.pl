use v5.28;
my @a = (2,3,5);
for my $i (1..$ARGV[0]) {
    my $a = $i;
    for (@a) {
        $a/=$_ while $a%$_==0; 
    }
    $a==1 and say $i;
}
