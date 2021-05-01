tests = ["foo 0044 1148820341 42", "xyz +44 1148820342 abc",
         "44-11-4882-0343", " (44) 1148820344  ", "00 1148820345"]
pattern = %r{((\d{4}|\+\d{2}|\(\d{2}\))\s+\d{10})}
for str in tests
    match = str.match(pattern)
    if match then
        print(match[0], "\n")
    end
end
