use Math::BigFloat;
Math::BigFloat->div_scale(200);
my $r = Math::BigFloat->new( 163 );
$r -> bsqrt();
my $pi = Math::BigFloat->new("3.141592653589793238462643383279502884197169399375105820974944592307816406286208998628034825342117067982148086513282306647093844609550582231725359408128481117450284102701938521105559644622948954930381964428810975665933446128475648233786783165271201909145648566923460348610454326648213393607260249141273724587006606315588174881520920962829254091715364367892590360");
$r -> bmul ($pi);
my $e = Math::BigFloat->new( "2.718281828459045235360287471352662497757247093699959574966967627724076630353547594571382178525166427427466391932003059921817413596629043572900334295260595630738132328627943490763233829880753195251019011573834187930702154089149934884" );
$e->bpow($r);
print $e."\n";