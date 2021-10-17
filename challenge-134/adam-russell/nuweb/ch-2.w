\documentclass{article}

\usepackage{listings}
\lstset{extendedchars=true , keepspaces=true , language=perl}

\begin{document}

Challenge 134

\section{Distinct Terms Count}

You are given 2 positive numbers, $m and $n.
Write a script to generate multiplcation table and display count of distinct terms.

\section{Distinct Terms Count: Perl}
@s
@o perl/ch-2.pl 
@{
    @<preamble...@>
    @<compute and print table@>
    @<main@>
@}

@d preamble: use statements, introductory comments, etc.
@{
    use strict;
    use warnings;
    ##
    # You are given 2 positive numbers, $m and $n.
    # Write a script to generate multiplcation table and display count of distinct terms.
    ##
@}

@d print header
@{
    print " x | " . join(" ", (1 .. $n)) . "\n";
    print "---+-" . "-" x ($n * 2 - 1) . "\n";
@}

@d print row
@{
    print " $i | " . join(" ", map {$i * $_} (1 .. $n)) . "\n";
@}

@d compute and print table
@{
    sub compute_print{
        my($m, $n) = @@_;
        my $distinct = {}; 
        @<print header@>
        for my $i (1 .. $m){
            @<print row@>
            for my $j (1 .. $n){
                $distinct->{$i * $j} = undef;
            }
        }
        return $distinct;  
    }
@}

@d main
@{
    MAIN:{
        my $distinct = compute_print(3, 3);
        print "Distinct Terms: " . join(", ", sort {$a <=> $b} keys %{$distinct}) . "\n";
        print "Count: " . keys(%{$distinct}) . "\n";
        print "\n\n";
        $distinct = compute_print(3, 5);
        print "Distinct Terms: " . join(", ", sort {$a <=> $b} keys %{$distinct}) . "\n";
        print "Count: " . keys(%{$distinct}) . "\n";
    }

@}
@S

\section{Distinct Terms Count: C++}
@s
@o cxx/ch-2.cxx
@{
    @<preamble: #...@>
    @<class definition@>
    @<compute and print table@>
    @<main@>
@}

@d preamble: #include statements, introductory comments, etc.
@{
    #include<iostream>
    #include<vector>
    #include<algorithm>
    /*
    * You are given 2 positive numbers, m and n.
    * Write a script to generate multiplcation table and display count of distinct terms.
    */
@}

@d class definition
@{
    class DistinctTermsCount{
        public: 
            std::vector<int> compute_print(int, int);
    };
@}

@d compute and print table
@{
    std::vector<int> DistinctTermsCount::compute_print(int m, int n){
        std::vector<int> distinct;
        @<print header@>
        for(int i = 1; i <= m; i++){
            @<print start of row@>
            for(int j = 1; j <= n; j++)
                @<print row@> 
        }    
        return distinct;
    }
@}

@d print header
@{
    std::cout << " x | ";
    for(int k = 1; k <= n; k++){
        std::cout << " " << k;
    } 
    std::cout << std::endl;
    std::cout << "---+-";
    for(int k = 1; k <= n * 2; k++){
        std::cout << "-";
    } 
    std::cout << std::endl;
@}

@d print start of row
@{
    std::cout << " " << i << " | ";
@}

@d print row
@{
    {
        int x = i * j;
        std::cout << " " << x;
        if(std::count(distinct.begin(), distinct.end(), x) == 0) {
            distinct.push_back(x);
        }
    }
    std::cout << std::endl;
@}

@d main
@{
    int main(int argc, char** argv){
        DistinctTermsCount dtc;
        std::vector<int> distinct = dtc.compute_print(3, 3);
        std::cout << "Distinct Terms: ";
        for(int i = 0; i < distinct.size() - 1; i++){
            std::cout << distinct[i] << ", ";
        }
        std::cout << distinct[distinct.size() - 1] << std::endl;
        std::cout << "Count: " << distinct.size() << std::endl;
    }
@}

\end{document}