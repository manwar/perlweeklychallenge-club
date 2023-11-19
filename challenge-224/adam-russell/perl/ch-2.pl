use v5.38;
##
# Given a string containing digits 0-9 only write a script to find out 
# if the given string is additive number. An additive number is a 
# string whose digits can form an additive sequence.
##
use boolean;  
sub is_additive{
    my $additive = false; 
    {
        my $i = @_ - 1; 
        my $x = $_[$i - 2];
        my $y = $_[$i - 1];
        my $last = pop @_;
	return false if $last != $x + $y;   
	redo if @_ > 2; 
    }
    return true; 
}

sub additive_number{
    my($digits) = @_; 
    my @numbers;
    do{
        my $i = $_;   
        $numbers[$i] = [];  
	push @{$numbers[$i]}, substr($digits, $i, $_) for 1 .. length($digits) - $i;     
    } for 0 .. length($digits) - 1; 
    my @last_numbers = map {pop @{$numbers[$_]}} 0 .. @numbers - 1;  
    my $step = 0; 
    my @additive = map {[$_]} @last_numbers; 
    my @additive_temp; 
    { 
        @last_numbers = map {pop @{$numbers[$_]}} 0 .. @numbers - 1;  
        do{
            my $i = $_;  
	    do{
                my $j = @{$additive[$i]};  
	        push @additive_temp, [$_, @{$additive[$i]}] if defined($_);   
	    } for @last_numbers; 
        } for 0 .. @additive - 1;
	$step++;
        @additive = (); 
	if($step > 2){ 
            do{
                push @additive, $_ if is_additive @{$_};   
	    } for @additive_temp; 
	}
        else{
            @additive = @additive_temp; 
	}
        @additive_temp = (); 
	redo if 0 < grep { @{$_} > 0 } @numbers;  
    }
    return boolean(@additive > 0);  
}

MAIN:{
    say additive_number 112358;  
    say additive_number 199100199;  
}
