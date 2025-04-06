
  
use v5.40; 

  
sub find_third{
    my ($s, $first, $second) = @_;
    $s =~ s/[[:punct:]]//g;
    my @thirds = ();
    my($previous, $current, $next) = (q//, q//, q//);
    do{
        push @thirds, $_ if $next;
        $current = $_;
        $next = 1 if $previous eq $first && $current eq $second;
        $next = 0 unless $previous eq $first && $current eq $second;
        $previous = $current;
    } for split q/\s+/, $s;
    return @thirds;
}

  
MAIN:{
  say q/(/ . join(q/, /, find_third(q/Perl is a my favourite language but Python is my favourite too./, q/my/, q/favourite/)). q/)/; 
  say q/(/ . join(q/, /, find_third(q/Barbie is a beautiful doll also also a beautiful princess./, q/a/, q/beautiful/)) . q/)/; 
  say q/(/ . join(q/, /, find_third(q/we will we will rock you rock you./, q/we/, q/will/)) . q/)/; 
}

