#!/usr/bin/env ruby
=begin
-------------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-04-08
Challenge 211 Toeplitz Matrix ( Ruby )
-------------------------------------------
=end

$matrx = [ [4, 3, 2, 1],[5, 4, 3, 2],[6, 5, 4, 3], ]

#$matrx = [ [1,2,3],[3,2,1] ]

$rows = $matrx.length()
$cols = $matrx[0].length()


r = 0
c = 0

outarr = []
$flag = 0

def CheckDiag(o)
    arr_u = o.uniq
    if arr_u.length() != 1
        $flag = -1
    end
end

def Diag(c,r)
    outarr = []
    while r < $rows
        outarr.push($matrx[r][c])
        if r == $rows - 1
            CheckDiag(outarr)
            return
        else
            if c == $cols - 1
                CheckDiag(outarr)
                break
            end
            c += 1
            r += 1
        end
    end
end

puts("Input: @matrix = #{$matrx}")

c = 0
r = 0

while c < $cols - 1
    Diag(c,r)
    c = c + 1
end

r = 1
c = 0
while r < $rows - 1
    Diag(c,r)
    r = r + 1
end


$flag == -1 ? puts("Output: false") : puts("Output: true")

=begin
-------------------------------------------
SAMPLE OUTPUT
ruby .\Toeplitz.rb
Input: @matrix = [[4, 3, 2, 1], [5, 4, 3, 2], [6, 5, 4, 3]]
Output: true

ruby .\Toeplitz.rb
Input: @matrix = [[1, 2, 3], [3, 2, 1]]
Output: false
-------------------------------------------

=end



