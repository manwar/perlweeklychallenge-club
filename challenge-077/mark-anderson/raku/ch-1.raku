unit sub MAIN(UInt $N);

my @fib = (1, 1, * + * ... * + * > $N).unique;

my @results = gather {
    for 2..@fib -> $n {
        take $_ for @fib.combinations($n).grep(*.sum == $N); 
    }
}

say "$_.join(" + ") = $N" for @results;
