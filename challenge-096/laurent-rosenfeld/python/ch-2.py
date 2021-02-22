cache = dict()

def cached_distance(left, right):
    key = left + ';' + right
    if key not in cache:
        cache[key] = edit_distance(left, right)
    return cache[key]

def edit_distance(left, right):
    lr = len(right)
    ll = len(left)
    if not left: return lr
    if not right: return ll
    shortened_l = left[0:ll-1]
    shortened_r = right[0:lr-1]
    if left[ll-1] == right[lr-1]:
        return cached_distance(shortened_l, shortened_r)

    return 1 + min( cached_distance(left, shortened_r),     # Insert
                    cached_distance(shortened_l, right),    # Remove
                    cached_distance(shortened_l, shortened_r)  # Replace
                  )

tests = ( [ "kitten", "sitting" ], [ "Monday", "Friday" ],
          [ "Sunday", "Saturday" ], [ "January", "February" ],
          [ "November", "December" ],
          [ "constitutionally", "anticonstitutional" ],
        )

for test in tests:
    print (test[0], test[1], edit_distance(test[0], test[1]  ))
