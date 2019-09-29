package Audit{
    use Filter::Simple;

    our %Log;

    sub audit{
        my($name, $value) = @_; 
        $value = "undef" if !$value; 
        if($Log{$name}){
            push @{$Log{$name}}, $value;
        }
        else{
            $Log{$name} = [$value]; 
        } 
        #print "A " . $name . " " . $value . "\n"; 
    }  

    sub print_log{
        for my $key (keys %Log){
            print "$key: " . join(", ", @{$Log{$key}}) . "\n";  
        } 
    } 

    FILTER_ONLY code => sub{
       s|((\$[[:alpha:]]*).*;)|$1 Audit::audit('$2', $2);|g;
       #print $1 . "\n";  
       #print $2 . "\n";  
       #print;
    }  
}
