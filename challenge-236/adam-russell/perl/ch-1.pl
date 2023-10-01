use v5.36;
##
# You are asked to sell juice each costs $5. You are given an array of bills. 
# You can only sell ONE juice to each customer but make sure you return exact change back. 
# You only have $5, $10 and $20 notes. You do not have any change in hand at first.
# Write a script to find out if it is possible to sell to each customers with correct 
# change.
##
use boolean;
use constant COST_JUICE => 5;

sub exact_change{
    my @bank;
    my $current_customer = shift;
    { 
        push @bank, $current_customer if $current_customer == COST_JUICE;
        if($current_customer > COST_JUICE){
            my $change_due = $current_customer - COST_JUICE;
            my @bank_sorted = sort {$a <=> $b} @bank;
            my @bank_reserved;
            {
                my $bill = pop @bank_sorted;
                push @bank_reserved, $bill if $change_due < $bill;
                $change_due -= $bill if $change_due >= $bill;
                redo if @bank_sorted;
            } 
            return false if $change_due != 0;
            @bank = @bank_reserved;
            push @bank, $current_customer;
        }
        $current_customer = shift; 
        redo if $current_customer;
    }
    return true;
}


MAIN:{
    say exact_change 5, 5, 5, 10, 20;
    say exact_change 5, 5, 10, 10, 20;
    say exact_change 5, 5, 5, 20;
}