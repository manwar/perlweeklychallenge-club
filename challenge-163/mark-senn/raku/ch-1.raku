use v6.d;

Test((1, 2, 3));
Test((2, 3, 4));

sub Test(@array)
{
    my @n = @array;
    say "Input : @n = ({@n.join(,)})";
    say 'Output: ' ~ combinations(@n, 2).map({[+&] $_}).sum;
}
