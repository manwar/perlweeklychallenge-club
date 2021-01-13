sub MAIN( Int $n where * > 1, Int $k where * > 1 )
{
    say ( 1..$n ).permutations[ $k - 1 ];
}