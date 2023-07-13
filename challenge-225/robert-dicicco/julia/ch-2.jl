#!/usr/bin/env julia
#=
---------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-07-12
Challenge 225 Task 2 Left Right Sum Diff ( Julia )
---------------------------------------
=#
using Printf

arr = [1, 2, 3, 4, 5]
#arr = [10,4,8,3]

left = []
right = [];
left_right_sum_diff = [];

function ltr(arr)
    sum = 0
    push!(left, 0)
    ln = length(arr)
    for x = 1:ln-1
        sum += arr[x];
        push!(left,sum)
    end
end

function rtl(arr)
    global right
    sum = 0
    push!(right,0);
    i = length(arr);
    while i > 1
        sum += arr[i];
        push!(right,sum);
        i -= 1;
    end
    right = reverse!(right)
end

@printf("Input:  @ints = %s\n",arr);
ltr(arr)
@printf("\t@left  = %s\n",left)
rtl(arr)
@printf("\t@right = %s\n",right)

ndx = 1
while ndx <= length(arr)
    global ndx
    val = abs(left[ndx] - right[ndx])
    push!(left_right_sum_diff, val)
    ndx += 1
end
@printf("\tOutput: @left_right_sum_diff = %s\n",left_right_sum_diff)

#=
---------------------------------------
SAMPLE OUTPUT

julia LRSD.jl
Input:  @ints = [10, 4, 8, 3]
        @left  = Any[0, 10, 14, 22]
        @right = Any[15, 11, 3, 0]
        Output: @left_right_sum_diff = Any[15, 1, 11, 22]

julia LRSD.jl
Input:  @ints = [1, 2, 3, 4, 5]
        @left  = Any[0, 1, 3, 6, 10]
        @right = Any[14, 12, 9, 5, 0]
        Output: @left_right_sum_diff = Any[14, 11, 6, 1, 10]
---------------------------------------
=#
