use v6;

use Prime::Factor;
.say if prime-factors($_).elems.is-prime for 1..50;
