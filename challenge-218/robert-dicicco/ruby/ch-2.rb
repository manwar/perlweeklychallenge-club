#!/usr/bin/env ruby
#---------------------------------------------
# AUTHOR: Robert DiCicco
# DATE  : 2023-05-27
# Challenge 218 MatrixScore.py ( Ruby )
#---------------------------------------------

$matrix = [ [0,0,1,1],
           [1,0,1,0],
           [1,1,0,0], ]

def GetColVal(c)
    testmat = []
    row = 0
    while row < 3
        testmat.push($matrix[row][c])
        row += 1
    end
    colval = binary_to_decimal(testmat)
    return colval
end

def ToggleCol(c)
    ov = GetColVal(c);
    row = 0
    testmat = []
    testval = 0
    while row < 3
        $matrix[row][c] == 0 ? testmat.push(1) : testmat.push(0)
        row += 1
    end
    testval = binary_to_decimal(testmat);
    if testval > ov
        x = 0
        while x < 3
            $matrix[x][c] = testmat[x]
            x += 1
        end
        puts("Toggled column #{c+1}")
        ShowMatrix()
    end
end

def ToggleRow(r, ov)
    testmat = []
    col = 0
    while col <= 3
        x = $matrix[r][col]
        if x == 0
            testmat.push(1)
        else
            testmat.push(0)
        end
        col += 1
    end
    testval = binary_to_decimal(testmat)
    if testval > ov
        puts("\nToggled row #{r+1}")
        $matrix[r] = testmat
        ShowMatrix()
    end
end

def ShowMatrix()
    total = 0
    cnt = 0
    while cnt < 3
        puts("#{$matrix[cnt]}")
        total += binary_to_decimal($matrix[cnt])
        cnt += 1
    end
    puts("Total = #{total}\n\n")
end

def binary_to_decimal(binary_array)
    decimal = 0
    power = binary_array.length() - 1
    binary_array.each do |digit|
        decimal += digit * ( 2 ** power)
        power -= 1
    end
    return decimal
end

ShowMatrix()
myrow = 0
while myrow < 3
    bd = binary_to_decimal($matrix[myrow].to_a)
    ToggleRow(myrow,bd)
    myrow += 1
end

mycol = 0
while mycol < 4
    ToggleCol(mycol)
    mycol += 1
end

#---------------------------------------------
# SAMPLE OUTPUT
# ruby .\MatrixScore.rb
# [0, 0, 1, 1]
# [1, 0, 1, 0]
# [1, 1, 0, 0]
# Total = 25

# Toggled row 1
# [1, 1, 0, 0]
# [1, 0, 1, 0]
# [1, 1, 0, 0]
# Total = 34

# Toggled column 3
# [1, 1, 1, 0]
# [1, 0, 0, 0]
# [1, 1, 1, 0]
# Total = 36

# Toggled column 4
# [1, 1, 1, 1]
# [1, 0, 0, 1]
# [1, 1, 1, 1]
# Total = 39
#---------------------------------------------
