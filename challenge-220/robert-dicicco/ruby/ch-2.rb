#!/usr/bin/env ruby
=begin
------------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-06-08
Challenge 220 Task 2 Squareful ( Ruby )
------------------------------------------
=end

myints = [[1,8,17],[1,8,17,19]];

def IsPerfectSquare(number_to_test)
    root = Math.sqrt(number_to_test).to_i
    if ((root ** 2 ) == number_to_test)
        return true;
    end
    return false;
end

$pm = []

myints.each do |intsub|
    puts("Input: @ints = #{intsub}")
    ln = intsub.length()
    print("Output: ")
    intsub.permutation(ln).to_a.each do |perm|
        tv = 0
        $flag = 0
            while tv < (ln - 1)
               if IsPerfectSquare(perm[tv] + perm[tv + 1])
                   $flag += 1
               else
                   $flag = 0
               end
               tv += 1
            end
            if $flag == ln - 1
                 print("#{perm} ")
            end
    end

    print("\n\n")
end

=begin
------------------------------------------
SAMPLE OUTPUT
ruby .\Squareful.rb

Input: @ints = [1, 8, 17]
Output: [1, 8, 17] [17, 8, 1]

Input: @ints = [1, 8, 17, 19]
Output: [1, 8, 17, 19] [19, 17, 8, 1]
------------------------------------------
=end
