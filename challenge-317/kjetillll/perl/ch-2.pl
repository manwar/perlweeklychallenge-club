sub f { join( '', sort split//, pop ) eq
        join( '', sort split//, pop )    }

print f( "desc",   "dsec"   ) ? "ok\n" : "error\n";  # true
print f( "fuck",   "fcuk"   ) ? "ok\n" : "error\n";  # true
print f( "poo",    "eop"    ) ? "error\n" : "ok\n";  # false
print f( "stripe", "sprite" ) ? "ok\n" : "error\n";  # true


=pod

For long inputs the sorting in   sub f   is sub-optimal.

Sorting makes this a   O( n * log n )   solution.

For long inputs a faster solution in linear time:   O( n )   is counting the
frequency of each letter and then compare the counts like in   sub f2   below.

The break even according to the benchmarks at the bottom are around 100 chars.
When the strings become longer than that the   sub f2   without sorting becomes
faster. And much faster for very long inputs.

=cut

sub f2 {
    my %freq1; $freq1{$_}++ for split//, shift;
    my %freq2; $freq2{$_}++ for split//, shift;
    return 0 if 0+keys(%freq1) != 0+keys(%freq2);
    for( keys %freq1 ){
	return 0 if $freq1{$_} != $freq2{$_};
    }
    return 1
}

print f2( "desc",   "dsec"   ) ? "ok\n" : "error\n";  # true
print f2( "fuck",   "fcuk"   ) ? "ok\n" : "error\n";  # true
print f2( "poo",    "eop"    ) ? "error\n" : "ok\n";  # false
print f2( "stripe", "sprite" ) ? "ok\n" : "error\n";  # true



use Benchmark;
use List::Util 'shuffle';
for my $len ( 10, 30, 100, 300, 1e3, 1e4, 1e5, 1e6 ){
    print "---------- len: $len\n";
    my $a = join '', map ['a'..'z']->[rand(26)], 1 .. $len;
    my $b = join '', shuffle split //, $a;
    my $count = 3e6 / $len;
    $count = 5 if $count < 5;
    timethese($count, {
	'f'  => sub { f($a,$b)  ? 1 : die },
	'f2' => sub { f2($a,$b) ? 1 : die },
	      });
}
