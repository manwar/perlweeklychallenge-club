#!/usr/bin/env perl6
use v6;

# run as <script>

use Inline::Perl5;
my $p5 = Inline::Perl5.new;

$p5.run(q{
	       use v5.12;
	       use Math::BigFloat; 
	       Math::BigFloat->precision(-60);

	       say substr(Math::BigFloat->new('1')->bexp()->bpow(Math::BigFloat->bpi()->bmul(Math::BigFloat->new('163')->bsqrt())->bround(60)),0,52);
	   });
