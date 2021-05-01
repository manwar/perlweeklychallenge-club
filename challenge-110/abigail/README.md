# Solutions by Asbigail
## [Valid Phone Number Formats](https://perlweeklychallenge.org/blog/perl-weekly-challenge-110/#TASK1)

> You are given a text file.
> 
> Write a script to display all valid phone numbers in the given text file.

### Acceptable Phone Number Formats

~~~~
+nn  nnnnnnnnnn
(nn) nnnnnnnnnn
nnnn nnnnnnnnnn
~~~~

### Input File
~~~~
0044 1148820341
 +44 1148820341
  44-11-4882-0341
(44) 1148820341
  00 1148820341
~~~~

### Output
~~~~
0044 1148820341
 +44 1148820341
(44) 1148820341
~~~~

### Notes
The examples show we should not take the specification as a specification;
just a rough guideline. According to the specification, 
" +44 1148820341" fails the criteria not once, but twice: it contains
a leading space (not allowed in the specification), and it has only a
single space between the '+44' part and the rest, where the specification
requires two.

We therefore conclude the examples just contain random spaces, and we
can completly ignore any white space in the input.

### Solutions
* [AWK](awk/ch-1.awk)
* [Bash](bash/ch-1.sh)
* [C](c/ch-1.c)
* [Lua](lua/ch-1.lua)
* [Node.js](node/ch-1.js)
* [Perl](perl/ch-1.pl)
* [Python](python/ch-1.py)
* [Ruby](ruby/ch-1.rb)

### Blog

## [Transpose File](https://perlweeklychallenge.org/blog/perl-weekly-challenge-110/#TASK2)

> You are given a text file.
> 
> Write a script to transpose the contents of the given file.

### Input File
~~~~
name,age,sex
Mohammad,45,m
Joe,20,m
Julie,35,f
Cristina,10,f
~~~~

### Output
~~~~
name,Mohammad,Joe,Julie,Cristina
age,45,20,35,10
sex,m,m,f,f
~~~~


### Solutions
* [AWK](awk/ch-2.awk)
* [Bash](bash/ch-2.ch)
* [C](c/ch-2.c)
* [Lua](lua/ch-2.lua)
* [Node.js](node/ch-2.js)
* [Perl](perl/ch-2.pl)
* [Python](python/ch-2.py)
* [Ruby](ruby/ch-2.rb)

### Blog

