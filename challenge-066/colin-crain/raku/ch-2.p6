sub MAIN ( Int $input = 324  ) {

    my %decomp = decompose($input).map: { $_ => ++%decomp{$_} };

    my ($power, %base_factors) = get_powers( %decomp );

    if %base_factors.keys > 0 {
        my $base = [*] %base_factors.keys.map: { $_ ** %base_factors{$_} }
        say "$input = $base^$power";
    }
    else {
        say 0;
    }


}

sub decompose ( $num is copy ) {
## given a number
## returns an array list of prime decomposition factors of the number
    my @decomp;
    my @primelist = (2..(sqrt($num)).Int).grep({ .is-prime });
    my $prime = shift @primelist;

    while ( $prime <= $num ) {
        while ($num %% $prime) {
            $num /= $prime;
            @decomp.push: $prime;
        }
        last unless @primelist.elems;
        $prime =  @primelist.shift;
    }
    return @decomp;
}

sub get_powers ( %decomp ) {
## divides a hash of factors and their incidences into a power and hash with new incidences
## or returns Nil if impossible

    my @factors = %decomp.keys.sort: { %decomp{$^a} <=> %decomp{$^b}
                                       ||       $^a <=> $^b  };

    return if @factors.elems == 0;       ## single factors for prime numbers aren't recorded,
                                         ## but we don't care

    my $power = %decomp{@factors.head};
    return if $power == 1;

    my %base_factors = @factors.map: { %decomp{$_} %% $power ?? ($_ => %decomp{$_} / $power)
                                                             !! return  } ;

    return ($power, %base_factors);
}



