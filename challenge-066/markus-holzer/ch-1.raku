subset NonZeroInt of Int where * != 0;

multi sub infix:<subdiv>( Int $a, NonZeroInt $b where $a.sign == $b.sign ) { 
	( $a, * - $b, * < $b ).elems - 1
}

multi sub infix:<subdiv>( Int $a, NonZeroInt $b ) { 
	- ( -$a subdiv $b )
}

multi sub infix:<subdiv>( $, 0 ) { 
	1 / 0
}

say 5 subdiv 2;
say -5 subdiv -2;
say 5 subdiv -2;
say -5 subdiv 2;
say -5 subdiv 0;
