#!/usr/bin/env -S perl -wl

#--modified a bit from the examples
#-- input contains surnames only.

local *secret_santa=sub {
    local (%secret_santa,@secret_santa);
    foreach (@_) {
        $secret_santa{$_}++; 
        push @secret_santa, $_."_".$secret_santa{$_};
    }
    %secret_santa=();
    {
        local (@sorted_1, @sorted_2);
        @sorted_1=sort {$a cmp $b} @secret_santa;
        @sorted_2=sort {$b cmp $a} @secret_santa;
        foreach (0 .. $#secret_santa) {
            $secret_santa{$sorted_1[$_]} = $sorted_2[$_];
        }
    }
    return %secret_santa;
};

local *print_hash=sub {
    local %_=@_;
    foreach (sort keys %_){
        print $_," => ", $_{$_};
    }
};


&print_hash( &secret_santa('Wall', 'Wall', 'Anwar', 'Anwar', 'Conway', 'Cross') );
#Anwar_1 => Wall_2
#Anwar_2 => Wall_1
#Conway_1 => Cross_1
#Cross_1 => Conway_1
#Wall_1 => Anwar_2
#Wall_2 => Anwar_1

&print_hash( &secret_santa('Wall','Wall','Anwar') );
#Anwar_1 => Wall_2
#Wall_1 => Wall_1 :-) (why not?)
#Wall_2 => Anwar_1


