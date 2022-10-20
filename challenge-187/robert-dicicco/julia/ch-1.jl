#!/usr/bin/env julia

# AUTHOR: Robert DiCicco

# DATE: 2022-10-18

# Challenge 187 Days Together ( Julia )



using Dates



dates = [

        "2022-01-12","2022-01-20","2022-01-15","2022-01-18",

        "2022-03-02","2022-03-12","2022-03-13","2022-03-14",

        "2022-03-02","2022-03-12","2022-03-11","2022-03-15",

        "2022-03-30","2022-04-05","2022-03-28","2022-04-02"

        ]



for x in 1:4:length(dates)

    BD = dates[x]

    arr = split(BD, "-")

    a = parse(Int, arr[1])

    b = parse(Int, arr[2])

    c= parse(Int, arr[3])



    ED = dates[x+1]

    arr = split(ED, "-")

    d = parse(Int, arr[1])

    e = parse(Int, arr[2])

    f = parse(Int, arr[3])



    BD = dates[x+2]

    arr = split(BD, "-")

    g = parse(Int, arr[1])

    h = parse(Int, arr[2])

    i = parse(Int, arr[3])



    ED = dates[x+3]

    arr = split(ED, "-")

    j = parse(Int, arr[1])

    k = parse(Int, arr[2])

    l = parse(Int, arr[3])



    dr1 = Date(a,b,c):Day(1):Date(d,e,f)

    d1 = Set(collect(dr1))

    dr2 = Date(g,h,i):Day(1):Date(j,k,l)

    d2 = Set(collect(dr2))

    print("Output: ")

    println(length(intersect(d1,d2)))

end
