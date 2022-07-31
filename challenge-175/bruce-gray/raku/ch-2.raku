# Simple version:
sub totient         ( UInt $n --> UInt ) { +grep { $n gcd $_ == 1 }, 1..$n }
sub totients_sum    ( UInt $n --> UInt ) { sum $n, &totient ^… 1  }
sub perfect_totient ( UInt $n --> Bool ) { $n == $n.&totients_sum }


# High-speed version; 1/10th the time of Simple, due to caching and the factor algorithm:
# sub perfect_totient ( UInt $n --> Bool ) {
#     use Prime::Factor;
#     constant @totients = flat 0, (1..^Inf).map: -> $n {
#         ( $n * [*] $n.&prime-factors.unique.map: 1 - 1/* ).narrow
#     }
#     return $n == [+] $n, { @totients[$^prev] } ^… 1;
# }


constant @perfect_totients = grep &perfect_totient, 1 ..^ Inf;
say @perfect_totients.head(20);
