use v6;


#Stepping Numbers

#Write a script to accept two numbers between 100 and 999. 
#It should then print all Stepping Numbers between them.

#A number is called a stepping number if the adjacent digits have a difference of 1. 
#For example, 456 is a stepping number but 129 is not.


sub MAIN ( Int $firstNumber  , Int $secondNumber   ) {
    unless isValidNumber($firstNumber)   && isValidNumber($secondNumber)  {        
        die "Error: Scripts accepts two numbers between 100 and 999\n";
    }

    
    my $numberFrom = $firstNumber;
    my $numberTo = $secondNumber;
    #From should be smaller than To 
    if $firstNumber > $secondNumber {
        $numberFrom = $secondNumber;
        $numberTo = $firstNumber;
    } 


    for $numberFrom..$numberTo {
        printIfSteppingNumber($_);    
    }   
}

sub isValidNumber (Int $number){
    if  $number.defined && $number >= 100 && $number <= 999 {       
        return 1;
    }
    say $number ~ "  is not valid";
    return 0;
}

sub printIfSteppingNumber ( Int $number ) {
    my @aDigits = split('',$number);
    @aDigits.pop;
    @aDigits.shift;
    my $isSteppingNumber = 1;

    for 1..@aDigits.Int-1 {
        my $diff = @aDigits[$_] - @aDigits[$_-1];
        if  $diff != 1 && $diff != -1 {
            $isSteppingNumber = 0;
        }
    }
    if $isSteppingNumber {
        say $number;
    }

}