#!/usr/bin/env julia

#=

AUTHOR: Robert DiCicco

DATE  : 2023-01-09

Challenge 199 Good Pairs ( Julia )

=#

 

using Printf

 

lists = [[1,2,3,1,1,3],[1,2,3],[1,1,1,1]]

finalCnt = 0

 

for list in lists

                global finalCnt

                @printf("Input: @list = %s\n", list)

                beginner = 1

                ender = length(list)

                cnt = beginner + 1

                while beginner < ender

                                while cnt <= ender

                                                if list[cnt] == list[beginner]

                                                                @printf("%d,%d\n",beginner-1,cnt-1)

                                                                finalCnt += 1

                                                end

                                                cnt += 1

                                end

                                beginner += 1

                                cnt = beginner + 1

                end

                @printf("Output: %d\n\n", finalCnt)

                finalCnt = 0

end

 

#=

SAMPLE OUTPUT

julia .\GoodPairs.jl

Input: @list = [1, 2, 3, 1, 1, 3]

0,3

0,4

2,5

3,4

Output: 4

 

Input: @list = [1, 2, 3]

Output: 0

 

Input: @list = [1, 1, 1, 1]

0,1

0,2

0,3

1,2

1,3

2,3

Output: 6

=#
