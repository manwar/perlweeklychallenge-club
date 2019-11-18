use v6.d;

sub MAIN () {
    my @array = (0..Inf);
    my %hash = ( a => 1, b => 2, c => 3, d => 4 );
    say 'Array slice: ' ~ @array[0..5];
    say 'Hash slice: ' ~ %hash{'a','b'};
}
