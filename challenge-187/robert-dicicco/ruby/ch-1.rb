require 'date'

# AUTHOR: Robert DiCicco

# DATE: 2022-10-17

# Challenge 187 Days Together ( Ruby )



=begin

Example 1



Input: Foo => SD: '12-01' ED: '20-01'

       Bar => SD: '15-01' ED: '18-01'



Example 2



Input: Foo => SD: '02-03' ED: '12-03'

       Bar => SD: '13-03' ED: '14-03'



Example 3



Input: Foo => SD: '02-03' ED: '12-03'

       Bar => SD: '11-03' ED: '15-03'



Example 4



Input: Foo => SD: '30-03' ED: '05-04'

       Bar => SD: '28-03' ED: '02-04'

=end



dates = %w(2022-01-12 2022-01-20 2022-01-15 2022-01-18 2022-03-02 2022-03-12 2022-03-13 2022-03-14\

           2022-03-02 2022-03-12 2022-03-11 2022-03-15 2022-03-30 2022-04-05 2022-03-28 2022-04-02)



(0..dates.length - 1).step(4).each do |x|

  sample = Date.parse(dates[x])

  sample1 = Date.parse(dates[x+1])

  sample2 = Date.parse(dates[x+2])

  sample3 = Date.parse(dates[x+3])

  n = 0

  ((sample..sample1).to_a & (sample2..sample3).to_a).each {n+=1}

  puts("Output: #{n} days")

end
