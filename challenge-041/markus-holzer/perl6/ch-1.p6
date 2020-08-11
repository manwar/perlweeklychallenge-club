use Prime::Factor; 
.say for (2..50).grep( -> $n { is-prime prime-factors( $n ).elems });