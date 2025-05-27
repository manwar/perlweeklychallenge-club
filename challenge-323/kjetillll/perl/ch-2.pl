sub f_alternative_1 {
    my($in, @b) = @_;
    my $tax = 0;
    my $in_taxed = 0;
    while($in > 0 and @b){
        my($upto, $percent) = @{ shift @b };
        $upto -= $in_taxed;
        my $amount = $upto < $in ? $upto : $in;
        $tax += $amount * $percent / 100;
        $in -= $amount;
        $in_taxed += $amount;
    }
    $tax
}

sub f_alternative_2 {
    my($income,@brackets)=@_;
    !ref$income      ? f( [$income,0], @brackets )
   :!@brackets       ? 0
   :$$income[0] <= 0 ? 0
   :do{
       my($income_left, $income_taxed_so_far) = @$income;
       my($upto, $percent) = @{ shift @brackets };
       $upto -= $income_taxed_so_far;
       my $amount = $income_left > $upto ? $upto : $income_left;
       $amount * $percent / 100 + f( [$income_left - $amount, $income_taxed_so_far + $amount], @brackets )
   }
}

sub f_alternative_3 {
    my $income = shift;
    my @percent; @percent[0 .. $$_[0]-1] = ( $$_[1] / 100) x $$_[0] for reverse @_;
    sprintf "%f", eval join '+', map shift@percent, 1 .. $income
}

*f = *f_alternative_3;

print f( 10,  [3, 50], [7, 10], [12,25] ) == 2.65 ? "😊\n" : "💀\n";
print f(  2,  [1, 0], [4, 25], [5,50] )   == 0.25 ? "😊\n" : "💀\n";
print f(  0,  [2, 50]  )                  == 0    ? "😊\n" : "💀\n";
