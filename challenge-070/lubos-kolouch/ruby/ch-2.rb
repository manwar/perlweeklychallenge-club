N = 4
gray_code = ['0', '1']

(2..N).each do |i|
    rev_gray_code = gray_code.reverse
    gray_code = gray_code.map { |x| '0' + x }
    rev_gray_code = rev_gray_code.map { |x| '1' + x }
    gray_code += rev_gray_code
end

gray_code = gray_code.map { |x| x.to_i(2) }
puts gray_code.join(', ')
