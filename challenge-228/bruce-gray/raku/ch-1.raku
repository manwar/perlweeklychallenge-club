# Bag, iterated by Pairs:
sub task1a ( @ns --> UInt ) {
    return @ns.Bag.map({ .key if .value == 1 }).sum;
}

# Set difference:
sub task1b ( @ns --> UInt ) {
      return ( @ns (-) @ns.repeated ).keys.sum;
}

# Single-pass:
sub task1c ( @ns --> UInt ) {
    my Bool %seen; # tri-state
    my UInt $total = 0;

    for @ns -> $n {
        my $c = %seen{$n};

        if    $c         { next }
        elsif $c.defined { $total -= $n; %seen{$n} = True; }
        else             { $total += $n; %seen{$n} = False; }
    }

    return $total;
}

# Single-pass single-statement / Cosmic Horror with anonymous %seen hash:
sub task1Z ( @ns --> UInt ) {
    return sum map { $_ * (1,-1,0)[ %.{$_}++ min 2 ] }, @ns;
}

constant @tests = map { Hash.new: <in expected> Z=> .list },
    ( (2, 1, 3, 2),  4 ),
    ( (1, 1, 1, 1),  0 ),
    ( (2, 1, 3, 4), 10 ),
;
constant @fs = :&task1a, :&task1b, :&task1c, :&task1Z;
use Test;
plan @fs*@tests;
for @fs -> ( :key($f_name), :value(&f) ) {
    is f(.<in>), .<expected>, "{$f_name} : {.<in>}" for @tests;
}
