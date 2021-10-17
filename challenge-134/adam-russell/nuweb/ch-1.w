\documentclass{article}

\usepackage{listings}
\lstset{extendedchars=true , keepspaces=true , language=perl}

\begin{document}

Challenge 134

\section{Pandigital Numbers}

Write a script to generate first 5 Pandigital Numbers in base 10.

\section{Pandigital Numbers: Perl}
@s
@o perl/ch-1.pl 
@{
    @<preamble...@>
    @<first n pandigital numbers@>
    @<first 5 pandigital numbers@>
    @<main@>
@}

@d preamble: use statements, introductory comments, etc.
@{
    use strict;
    use warnings;
    ##
    # Write a script to generate first 5 Pandigital Numbers in base 10.
    ##
    use boolean;
@}

@d check if pandigital
@{
    my $test = $x;
    push @@{$pandigitals}, $x if 
        ($test =~ tr/0//d) > 0 &&
        ($test =~ tr/1//d) > 0 &&
        ($test =~ tr/2//d) > 0 &&
        ($test =~ tr/3//d) > 0 &&
        ($test =~ tr/4//d) > 0 &&
        ($test =~ tr/5//d) > 0 &&
        ($test =~ tr/6//d) > 0 &&
        ($test =~ tr/7//d) > 0 &&
        ($test =~ tr/8//d) > 0 &&
        ($test =~ tr/9//d) > 0;
    $found = (@@{$pandigitals} == $n);
@}

@d first n pandigital numbers
@{
    sub first_n_pandigitals{
        my($n) = @@_;
        my $found = false; 
        my $pandigitals = []; 
        my $x = 1_000_000_000;
        do{
            @<check if pandigital@>
            $x++;
        } while(!$found);
        return $pandigitals;  
    }
@}

@d first 5 pandigital numbers
@{
    sub first_5_pandigitals{
        return first_n_pandigitals(5);  
    }
@}

@d main
@{
    MAIN:{
        my $pandigitals = first_5_pandigitals;
        for my $x (@@{$pandigitals}){
            print "$x\n";
        }
    }

@}
@S

\section{Pandigital Numbers: C++}
@s
@s
@o cxx/ch-1.cxx
@{
    @<preamble: #...@>
    @<class definition@>
    @<first n pandigital numbers@>
    @<first 5 pandigital numbers@>
    @<main@>
@}

@d preamble: #include statements, introductory comments, etc.
@{
    #include<iostream>
    #include<vector>
    #include<algorithm>
    /*
    * Write a script to generate first 5 Pandigital Numbers in base 10.
    */
@}

@d class definition
@{
    class Pandigital{
        public: 
            std::vector<int> first_n_pandigitals(int);
            std::vector<int> first_5_pandigitals();
    };
@}

@d first 5 pandigital numbers
@{
    std::vector<int> Pandigital::first_5_pandigitals(){
        return this->first_n_pandigitals(5);
    }
@}

@d first n pandigital numbers
@{
    std::vector<int> Pandigital::first_n_pandigitals(int n){
        std::vector<int> pandigitals;
        int x = 1000000000;
        do{
            @<check if pandigital@>
            x++; 
        }while(pandigitals.size() < n);
        return pandigitals;
    }
@}

@d check if pandigital
@{
    int test = x;
    std::vector<int> test_vector;
    do{
        test_vector.push_back(test % 10);
        test = test / 10;  
    }while(test > 0);
    if(std::count(test_vector.begin(), test_vector.end(), 0) && 
       std::count(test_vector.begin(), test_vector.end(), 1) && 
       std::count(test_vector.begin(), test_vector.end(), 2) && 
       std::count(test_vector.begin(), test_vector.end(), 3) && 
       std::count(test_vector.begin(), test_vector.end(), 4) && 
       std::count(test_vector.begin(), test_vector.end(), 5) && 
       std::count(test_vector.begin(), test_vector.end(), 6) && 
       std::count(test_vector.begin(), test_vector.end(), 7) && 
       std::count(test_vector.begin(), test_vector.end(), 8) && 
       std::count(test_vector.begin(), test_vector.end(), 9))
           pandigitals.push_back(x);
@}

@d main
@{
    int main(int argc, char** argv){
        Pandigital p;
        std::vector<int> pandigitals = p.first_5_pandigitals();
        for(int i = 0; i < pandigitals.size(); i++){
            std::cout << pandigitals[i] << std::endl;
        }
    }
@}

\end{document}
