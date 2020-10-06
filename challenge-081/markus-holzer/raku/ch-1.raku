unit sub MAIN(Str $A, $B);

my $chars = ( $A, $B ).max.chars;
my @chars = ( $A, $B ).min.comb;

.say for ( [\~] @chars ).grep( -> $part {
    $part x $chars div $part.chars eq $B })