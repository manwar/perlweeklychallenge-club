def remove_leading_zeros(number)
    if number.instance_of? String
        number = number.sub!(/^0+/,'')
    end 
    puts number * 1
end

remove_leading_zeros("0005.1")