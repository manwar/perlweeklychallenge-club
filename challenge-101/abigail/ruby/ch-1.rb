#!/usr/bin/ruby

#
# See ../README.md
#
 
#
# Run as: ruby ch-1.rb < input-file
#

RIGHT  = 0
UP     = 1
LEFT   = 2
DOWN   = 3

#
# Read the data, one line of input, split on whitespace.
#
elements = gets . chomp . split

#
# Calculate the optimal height and width
#
count  = elements . length
height = (Math . sqrt (count)) . floor
while count % height > 0
    height -= 1
end
width = count / height

#
# Initialize the matrix
#
matrix = Array . new (height)
for x in 0 .. height - 1 do
    matrix [x] = Array . new (width)
end


#
# Fill the matrix, starting from the bottom left.
#
min_x     = 0
max_x     = height - 1
min_y     = 0
max_y     = width  - 1
x         = max_x
y         = min_y
direction = RIGHT

for element in elements do
    matrix [x] [y] = element
    turn = false
    if  direction == RIGHT
        if   y >= max_y then turn = true; x -= 1; max_x -= 1
        else y += 1
        end
    end

    if  direction == UP
        if   x <= min_x then turn = true; y -= 1; max_y -= 1
        else x -= 1
        end
    end

    if  direction == LEFT
        if   y <= min_y then turn = true; x += 1; min_x += 1
        else y -= 1
        end
    end

    if  direction == DOWN
        if   x >= max_x then turn = true; y += 1; min_y += 1
        else x += 1
        end
    end

    if  turn
        direction += 1
        direction %= 4
    end

end

#
# Create an array with column widths
#
widths = Array . new (width)
for y in 0 .. width - 1 do
    max = 0
    for x in 0 .. height - 1 do
        if  max < matrix [x] [y] . length
            max = matrix [x] [y] . length
        end
    end
    widths [y] = max
end

#
# Pretty print the matrix
#
for x in 0 .. height - 1 do
    for y in 0 .. width - 1 do
        if  y > 0
            print " "
        end
        format = "%" + widths [y] . to_s + "s"
        printf format, matrix [x] [y]
    end
    print "\n"
end
