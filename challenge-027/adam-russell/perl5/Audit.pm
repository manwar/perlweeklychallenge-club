package Audit{
    use Data::Dump q/pp/;
    use Filter::Simple;

    our %Log;

    sub audit{
        my($name, $value) = @_; 
        $value = "undef" if !defined($value); 
        if($Log{$name}){
            push @{$Log{$name}}, $value;
        }
        else{
            $Log{$name} = [$value]; 
        } 
    }  

    sub clear_log{
        %Log = (); 
    } 

    sub print_log{
        for my $key (keys %Log){
            print "$key: " . join(", ", @{$Log{$key}}) . "\n";  
        } 
    } 
    
    sub pretty_print_log{
        for my $key (keys %Log){
            print "$key: " . join(", ", map{ pp $_ } @{$Log{$key}}) . "\n";  
        } 
    } 

    FILTER_ONLY code => sub{
       s|((\$[[:alnum:]_]*).*;)|$1 Audit::audit('$2', $2);|g;
    }  
}
