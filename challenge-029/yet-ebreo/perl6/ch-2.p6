use NativeCall;
use experimental :cached;
sub fib(int32) returns int32 is native('fib.so') {*}

sub MAIN () {

    my $start = now;
    print (perl_fib($_)~" ") for 1..36;

    say "\nRun Time (Perl): "~(now - $start)~" sec\n";

    $start = now;
    print (perl_fib_cached($_)~" ") for 1..36;

    say "\nRun Time (Perl-Cached): "~(now - $start)~" sec\n";

    $start = now;
    print (fib($_)~" ") for 1..36;
 
    say "\nRun Time: (NativeCall)"~(now - $start)~" sec\n";
}

sub perl_fib($n)  { ($n == 0) ?? 0 !! ($n == 1) ?? 1 !! perl_fib($n-1)+perl_fib($n-2) }
sub perl_fib_cached($n) is cached { ($n == 0) ?? 0 !! ($n == 1) ?? 1 !! perl_fib_cached($n-1)+perl_fib_cached($n-2) }


# perl6 .\ch-2.p6 32
# 1 1 2 3 5 8 13 21 34 55 89 144 233 377 610 987 1597 2584 4181 6765 10946 17711 28657 46368 75025 121393 196418 317811 514229 832040 1346269 2178309 3524578 5702887 9227465 14930352
# Run Time (Perl): 74.794843 sec
#
# 1 1 2 3 5 8 13 21 34 55 89 144 233 377 610 987 1597 2584 4181 6765 10946 17711 28657 46368 75025 121393 196418 317811 514229 832040 1346269 2178309 3524578 5702887 9227465 14930352
# Run Time (Perl-Cached): 0.029755 sec
#
# 1 1 2 3 5 8 13 21 34 55 89 144 233 377 610 987 1597 2584 4181 6765 10946 17711 28657 46368 75025 121393 196418 317811 514229 832040 1346269 2178309 3524578 5702887 9227465 14930352
# Run Time: (NativeCall)0.31090124 sec

