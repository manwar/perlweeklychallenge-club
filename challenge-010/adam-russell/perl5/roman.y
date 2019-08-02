%{
%}
%token I II III IV V IX X XX XXX XL L XC C CC CCC CD D CM M MM MMM EOL
%%
start:	|
		start input  
	;
input:          roman EOL        { print $1 . "\n"; }
        |       EOL
        ;
roman:          I            {$$ += 1}
        |       II           {$$ +=2}  
        |       III          {$$ +=3}  
        |       IV           {$$ += 4}  
        |       V            {$$ += 5}  
        |       IX           {$$ += 9}  
        |       X            {$$ += 10}  
        |       XX           {$$ += 20}  
        |       XXX          {$$ += 30}  
        |       XL           {$$ += 40}  
        |       L            {$$ += 50}  
        |       XC           {$$ += 90}  
        |       C            {$$ += 100}  
        |       CC           {$$ += 200}  
        |       CCC          {$$ += 300}  
        |       CD           {$$ += 400}  
        |       D            {$$ += 500}  
        |       CM           {$$ += 900}  
        |       M            {$$ += 1000}  
        |       MM           {$$ += 2000}  
        |       MMM          {$$ += 3000}  
        |       roman I      {$$ += 1}     
        |       roman II     {$$ += 2}     
        |       roman III    {$$ += 3}     
        |       roman IV     {$$ += 4}     
        |       roman V      {$$ += 5}       
        |       roman IX     {$$ += 9}       
        |       roman X      {$$ += 10}       
        |       roman XX     {$$ += 20}       
        |       roman XXX    {$$ += 30}       
        |       roman XL     {$$ += 40}       
        |       roman L      {$$ += 50}       
        |       roman XC     {$$ += 90}       
        |       roman C      {$$ += 100}       
        |       roman CC     {$$ += 200}       
        |       roman CCC    {$$ += 300}       
        |       roman CD     {$$ += 400}       
        |       roman D      {$$ += 500}       
        |       roman CM     {$$ += 900}       
        |       roman M      {$$ += 1000}       
        |       roman MM     {$$ += 2000}       
        |       roman MMM    {$$ += 3000}       
        ;
%%
sub yylex{
    my($s) = @_;
    my($c, $val);

    while(($c = $s->getc) eq " " || $c eq "\t"){ 
        # ignore single spaces and tabs 
    }

    if ($c eq ""){
	return 0;
    }
    elsif($c eq "\n"){
	return $EOL;
    }
    elsif($c eq "I") {
	$val = $c;
        $c = $s->getc;  
        if($c ne "I" && $c ne "X" && $c ne "V" && $c ne "\n"){
            return 0;  
        }  
        elsif($c eq "I"){
            $val .= $c;   
            $c = $s->getc;  
            if($c eq "I"){
                $val .= $c;
                $c = $s->getc;  
                if($c ne "\n"){
                    return 0;  
                }  
                $s->ungetc; 
                return($III, $val);   
            }
            else{
                if($c ne "\n"){
                    return 0;  
                }  
                $s->ungetc; 
                return($II,$val);   
            }  
        }  
        elsif($c eq "V"){
            $val .= $c;  
	    return($IV, $val);
        }  
        elsif($c eq "X"){
            $val .= $c;  
	    return($IX, $val);
        }  
	$s->ungetc;
	return($I, $val);
    }
    elsif($c eq "V"){
        return($V, $c);   
    }  
    elsif($c eq "X"){
	$val = $c;
        $c = $s->getc;  
        if($c eq "X"){
            $val .= $c;   
            $c = $s->getc;  
            if($c eq "X"){
                $val .= $c;
                return($XXX, $val);   
            }
            else{
                $s->ungetc; 
                return($XX,$val);   
            }  
        }  
        if($c eq "L"){
            $val .= $c;  
	    return ($XL, $val);
        }  
        elsif($c eq "C"){
            $val .= $c;  
	    return ($XC, $val);
        }  
	$s->ungetc;
        return($X, $c);   
    }  
    elsif($c eq "L"){
        return($L, $c);   
    }  
    elsif($c eq "C"){
	$val = $c;
        $c = $s->getc;  
        if($c eq "C"){
            $val .= $c;   
            $c = $s->getc;  
            if($c eq "C"){
                $val .= $c;
                return($CCC, $val);   
            }
            else{
                $s->ungetc; 
                return($CC,$val);   
            }  
        }  
        if($c eq "D"){
            $val .= $c;  
	    return ($CD, $val);
        }  
        elsif($c eq "M"){
            $val .= $c;  
	    return ($CM, $val);
        }  
	$s->ungetc;
        return($C, $c);   
    }  
    elsif($c eq "D"){
        return($D, $c);   
    }  
    elsif($c eq "M"){
	$val = $c;
        $c = $s->getc;  
        if($c eq "M"){
            $val .= $c;   
            $c = $s->getc;  
            if($c eq "M"){
                $val .= $c;
                return($MMM, $val);   
            }
            else{
                $s->ungetc; 
                return($MM,$val);   
            }  
        }  
	$s->ungetc;
        return($M, $c);   
    }  
}

sub yyerror{
    my ($msg, $s) = @_;
    die "$msg at " . $s->name . " line " . $s->lineno . ".\n";
}
