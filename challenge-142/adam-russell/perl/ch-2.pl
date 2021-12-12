use strict;
use warnings;
##
# Implement Sleep Sort.     
##
use Thread::Pool;

sub create_workers{
    my @numbers = @_; 
    my $count = @numbers; 
    my $workers = new Thread::Pool({
        optimize => "cpu", 
        do => \&sleeper, 
        workers => $count,
        maxjobs => $count, 
        minjobs => $count 
    });
    return $workers;
}

sub sleeper{
    my($n) = @_; 
    sleep($n);
    return $n;   
}

sub sleep_sort{
    my($numbers, $workers) = @_; 
    my @jobs;
    my @sorted;   
    for my $n (@{$numbers}){
        my $job_id = $workers->job($n);
        push @jobs, $job_id;   
    } 
    {
        my $job = pop @jobs;     
        my @result = $workers->result_any(\$job);
        if(!@result){    
            push @jobs, $job;  
        }
        else{
            push @sorted, $result[0]; 
        }
        redo if @jobs; 
    }
    $workers->shutdown; 
    return @sorted;   
}

MAIN:{
    my @numbers;
    my @sorted; 
    @numbers = map{int(rand($_) + 1)} (0 .. 9);  
    print join(", ", @numbers) . "\n"; 
    @sorted = sleep_sort(\@numbers, create_workers(@numbers));  
    print join(", ", @sorted) . "\n"; 
}  
