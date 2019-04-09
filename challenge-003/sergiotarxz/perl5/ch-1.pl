use v5.28;
my @a = (2,3,5);
for (my $i=1; $i<$ARGV[0]; $i++) {
    my $a = $i;
    for (@a) {
        $a/=$_ until $a%$_;
    }
    $a==1 and say $i;
}
