#=
AUTHOR: Robert DiCicco
DATE  : 2023-09-09
Challenge 233 Task one Similar Words ( Julia )
=#

using Combinatorics
using Printf

#words = ["aba", "aabb", "abcd", "bac", "aabc"]
words = ["aabb", "ab", "ba"]

pair = 0
cnt = 1

@printf("Input: @words = %s\n", words)

for wds in combinations(words,2)
    global pair,cnt
    #@printf("%s\n",wds[1])
    arr = split(wds[1],"")
    srt1 = unique(sort(arr))
    arr = split(wds[2],"")
    srt2 = unique(sort(arr))
    srt1 = join(srt1,"")
    srt2 = join(srt2, "")
    if cmp(srt1,srt2) == 0
        @printf("\tpair%d %s\n",cnt,wds)
        pair += 1
        cnt += 1
    end
end
@printf("Output: %d\n",pair)

#=
SAMPLE OUTPUT
julia .\SimilarWords.jl

Input: @words = ["aba", "aabb", "abcd", "bac", "aabc"]
        pair1 ["aba", "aabb"]
        pair2 ["bac", "aabc"]
Output: 2

julia .\SimilarWords.jl
Input: @words = ["aabb", "ab", "ba"]
        pair1 ["aabb", "ab"]
        pair2 ["aabb", "ba"]
        pair3 ["ab", "ba"]
Output: 3
=#


