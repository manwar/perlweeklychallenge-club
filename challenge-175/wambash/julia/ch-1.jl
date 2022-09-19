using Lazy
using Dates

year = isassigned(ARGS) ? parse(Int,ARGS[1]) : 2022

@>> 1:12 begin
    map( m -> @lazy lastdayofmonth( Date(year,m)):Day(-1):Date(year,m) )
    map( m -> filter( d -> dayofweek(d) == 7, m ) )
    map(first)
    foreach(println)
end
