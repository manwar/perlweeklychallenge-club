# The Weekly Challenge Week 132
# Task 1 Mirror Dates
# Usage: include("ch-1.jl")
#        mirror_dates(Date(YYYY,MM,DD))

using Dates

function mirror_dates(my_date_of_birth)
   my_today = Date(2021,09,22)
   y1 = Dates.values(my_today - my_date_of_birth)
   d_senior = my_date_of_birth - Dates.Day(y1)
   d_junior = my_today + Dates.Day(y1)
   println(d_senior)
   println(d_junior)
end


# julia> include("ch-1.jl")

# #Example 1
# julia> mirror_dates(Date(2021,09,18))
# 2021-09-14
# 2021-09-26

# #Example 2
# julia> mirror_dates(Date(1975,10,10))
# 1929-10-27
# 2067-09-05

# #Example 3
# julia> mirror_dates(Date(1967,02,14))
# 1912-07-08
# 2076-04-30

