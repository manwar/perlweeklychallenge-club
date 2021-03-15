use v5.16;

# Let "Stack" print calls and results
$Stack::verbose = 1;

say 'create Stack';
my $stack = Stack->new;

$stack->push(2);
$stack->push(-1);
$stack->push(0);
$stack->pop;
$stack->top;
$stack->push(0);

$stack->min;

$stack->max;
$stack->size;
