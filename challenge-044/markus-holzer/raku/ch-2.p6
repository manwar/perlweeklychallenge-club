my $amount = 200;

.say for my @amounts = reverse +$amount, |gather until $amount < 2
{ 
    take $amount = $amount %% 2 
        ?? $amount / 2 
        !! $amount - 1;  
};

# Outputs:
#
# 1
# 2
# 3
# 6
# 12
# 24
# 25
# 50
# 100
# 200