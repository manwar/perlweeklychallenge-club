sub pick-lotto-numbers() {
    return (1..49).roll(*).unique.head(6);
}

# Test
use Test;
plan 1;
my @result = pick-lotto-numbers().sort;
is @result.elems, 6, 'Six numbers are picked';
# Additional tests for uniqueness and range can be added

# Main
.say for pick-lotto-numbers().sort;
