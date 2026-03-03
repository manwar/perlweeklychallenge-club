


FROM_BASE_35 = {
    0 => 0,
    1 => 1,
    2 => 2,
    3 => 3,
    4 => 4,
    5 => 5,
    6 => 6,
    7 => 7,
    8 => 8,
    9 => 9,
    :A => 10,
    :B => 11,
    :C => 12,
    :D => 13,
    :E => 14,
    :F => 15,
    :G => 16,
    :H => 17,
    :I => 18,
    :J => 19,
    :K => 20,
    :L => 21,
    :M => 22,
    :N => 23,
    :O => 24,
    :P => 25,
    :Q => 26,
    :R => 27,
    :S => 28,
    :T => 29,
    :U => 30,
    :V => 31,
    :W => 32,
    :X => 33,
    :Y => 34
}

TO_BASE_35 = Hash.new

(0..9).each { |i| FROM_BASE_35[i.to_s] = i }

("A".."Y").each_with_index do |char, i|
  FROM_BASE_35[char] = i + 10
end

def _is_number(val)
    return val.match(/^\d+$/)
end

def to_base_35(val)
    if not _is_number(val)
        return
    end
    normalized_val = val.to_i.abs;
    if normalized_val < 35
        return TO_BASE_35[normalized_val]
    end
    sentinel = -1
    remainders = Array.new

    while sentinel != 0
        remainder = normalized_val % 35
        remainders.push(remainder)
        normalized_val = (normalized_val - remainder) / 35;

        if normalized_val < 35
            remainders.push(normalized_val)
            sentinel = 0
        end
    end
    base_35_number = ""
    while !remainders.empty?
        base_35_number.concat(TO_BASE_35[remainders.pop].to_s)
    end

    return base_35_number
end

def from_base_35(val)
    # Validate full string contains only valid base-35 chars
    return unless val.match?(/\A[0-9A-Ya-y]+\z/)

    decimal_result = 0
    val_len = val.length - 1

    val.each_char do |base_35_char|
        decimal_var = FROM_BASE_35[base_35_char.to_s.upcase]
        return unless !decimal_var.nil?   # extra safety

        decimal_result += decimal_var * (35 ** val_len)
        val_len -= 1
    end

    return decimal_result
end

puts to_base_35("133")
puts from_base_35("22OFRD")