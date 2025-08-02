#!/usr/bin/perl

sub reverseLetters {
    my $string = shift;
    my @chars = split(//, $string);
    
    my @pattern = ();
    my @letters = ();

    #create the pattern with x replacing any letter
    #store any found letters in the letters array
    foreach my $char (@chars) {
        if ($char =~ /[a-zA-Z]/) {
            push(@pattern, 'x');
            unshift(@letters, $char);
        } else {
            push(@pattern, $char);
        }
    }

    #replace the x's with the last element in the letters array
    for (my $i = 0; $i < @pattern; $i++) {
        if ($pattern[$i] eq 'x') {
            $pattern[$i] = shift(@letters);
        }
    }

    print join('', @pattern) . "\n";
}

reverseLetters('p-er?l');
reverseLetters('wee-k!L-y');
reverseLetters('_c-!h_all-en!g_e');
