UTHOR: Robert DiCicco
DATE  : 2023-08-21
Challenge 231 Senior Citizen Task 2 ( Julia )
----------------------------------------
=#

using Printf

lists = [["7868190130M7522","5303914400F9211","9273338290F4010"],["1313579440F2036","2921522980M5644"]]

for lst in lists
    cnt = 0
    @printf("Input: @list = %s\n",lst)
    for info in lst
        age = (parse(Int64, info[12:13]))
        if age >= 60
            cnt += 1
        end
    end
    @printf("Output: %s\n\n",cnt)
end

#=
----------------------------------------
SAMPLE OUTPUT
julia .\SeniorCit.jl

Input: @list = ["7868190130M7522", "5303914400F9211", "9273338290F4010"]
Output: 2

Input: @list = ["1313579440F2036", "2921522980M5644"]
Output: 0
----------------------------------------
=#


