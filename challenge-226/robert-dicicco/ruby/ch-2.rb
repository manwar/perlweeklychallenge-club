#!/usr/bin/env ruby
=begin
--------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-07-20
Challenge 226 Task 2 Zero Array ( Ruby )
--------------------------------------
=end

ints = [[1, 5, 0, 3, 5],[0],[2, 1, 4, 0, 3]]
flag = 1

def GetMinint(x)
    cnt = 0
    minint = 100
    while cnt < x.length()
        if  x[cnt] > 0 and x[cnt] < minint
            minint = x[cnt]
        end
        cnt += 1
    end
    return minint
end

cycle = 1
ints.each do |nts|
    while flag == 1
        if (cycle == 1)
            puts("Input: ints = #{nts}")
        end
        cnt = 0

        if nts.length() == 1 and nts[0] == 0
            #last
            break
        end

        #### find min of array ( not including zero )
        minint = GetMinint(nts)

        cnt = 0
        while cnt < nts.length()
            if nts[cnt] > 0
                nts[cnt] -= minint
            end
            cnt += 1
        end

        puts("operation cycle: pick #{minint} #{nts}")
        cycle +=1

        cnt = 0
        flag = 0
        while  cnt < nts.length()
            if (nts[cnt] > 0)
                flag = 1
            end
            cnt += 1
        end
     end
     cycle -= 1
     puts("Output: #{cycle}\n\n")
     flag = 1
     cycle = 1
end

=begin
--------------------------------------
SAMPLE OUTPUT
ruby .\ZeroArray.rb

Input: ints = [1, 5, 0, 3, 5]
operation cycle: pick 1 [0, 4, 0, 2, 4]
operation cycle: pick 2 [0, 2, 0, 0, 2]
operation cycle: pick 2 [0, 0, 0, 0, 0]
Output: 3

Input: ints = [0]
Output: 0

Input: ints = [2, 1, 4, 0, 3]
operation cycle: pick 1 [1, 0, 3, 0, 2]
operation cycle: pick 1 [0, 0, 2, 0, 1]
operation cycle: pick 1 [0, 0, 1, 0, 0]
operation cycle: pick 1 [0, 0, 0, 0, 0]
Output: 4
--------------------------------------
=end



