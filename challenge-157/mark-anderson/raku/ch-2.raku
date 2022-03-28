#!/usr/bin/env raku

use Test;

# Brazilian numbers https://oeis.org/A125134/b125134.txt
is-deeply (^Inf).hyper.grep(&Brazilian)[3980..3999], 
(4598, 4599, 4600, 4601, 4602, 4604, 4605, 4606, 4607, 4608,
 4609, 4610, 4611, 4612, 4613, 4614, 4615, 4616, 4617, 4618);
                                             
# Odd Brazilian numbers https://oeis.org/A257521/b257521.txt
is-deeply (1, 3...*).hyper.grep(&Brazilian)[3980..3999], 
(10509, 10511, 10515, 10517, 10519, 10521, 10523, 10525, 10527, 10533,
 10535, 10537, 10539, 10541, 10543, 10545, 10547, 10549, 10551, 10553);

# Composite Brazilian numbers https://oeis.org/A220571/b220571.txt
is-deeply (^Inf).hyper.grep(*.is-prime.not).grep(&Brazilian)[9980..9999], 
(11382, 11384, 11385, 11386, 11387, 11388, 11389, 11390, 11391, 11392,
 11394, 11395, 11396, 11397, 11398, 11400, 11401, 11402, 11403, 11404);

# Prime Brazilian numbers https://oeis.org/A085104/b085104.txt 
is-deeply (^Inf).hyper.grep(&is-prime).grep(&Brazilian)[80..99],
(88741,  95791,  98911,  108571, 110557, 113233, 117307, 118681, 121453, 123553,
 127807, 131071, 136531, 143263, 145543, 147073, 154057, 156421, 158803, 162007);

sub Brazilian(\n)
{
    given n
    {
        when ^7            { False }
        when 121           { True  }
        when not .is-prime { not .sqrt.is-prime } 
        default
        {
            my \b = .sqrt.floor;
            return True if .item == [+] 1, b, b², b³...n; 

            for 2..e**(.log/4) -> \b 
            {
                return True if .item == [+] 1, b, b², b³...n; 
            }
        }
    }
}
