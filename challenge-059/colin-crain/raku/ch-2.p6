sub MAIN ( *@input ) {

    my @sets = @input.combinations: 2;
    my $sum = [+] @sets.map({bit_difference($_)});

    $sum.say;
}

sub bit_difference ($array) {
    return ([+^] |$array).base(2).comb.sum;
}
