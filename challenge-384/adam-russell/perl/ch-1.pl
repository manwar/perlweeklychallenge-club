use feature q/say/; 
use Math::BaseCalc;

sub make_calculator{
    my($base) =  @_;
    return new Math::BaseCalc(digits => [0 .. $base - 1]) if $base <= 9;
    return new Math::BaseCalc(digits => [0 .. 9, q/A/ .. q/F/]) if $base == 16; 
    return new Math::BaseCalc(digits => [0 .. 9, q/A/ .. q/Z/]) if $base == 36;  
    return new Math::BaseCalc(digits => [0 .. 9, q/A/ .. q/Z/, q/a/ .. q/z/, q/+/, q[/]]) if $base == 64;  
    return undef; 
}

while(<DATA>){
    chomp; 
    my($n, $b) = split /,/, $_;
    my $c = make_calculator($b); 
    say $c->to_base($n);
}

__DATA__
42,2
15642094,16
493,8
2228519,36
123456789,64
