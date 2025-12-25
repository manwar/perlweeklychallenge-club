def validate_codes(codes, names, status):
    valid_categories = {"electronics", "grocery", "pharmacy", "restaurant"}
    result = []

    for i in range(len(codes)):
        code_ok = (codes[i] != '' and 
                  all(c.isalnum() or c == '_' for c in codes[i]))

        name_ok = names[i] in valid_categories if names[i] else False

        status_ok = status[i] == 'true' if status[i] else False

        result.append("true" if code_ok and name_ok and status_ok else "false")

    return result


def show_case(label, codes, names, status):
    print(label)
    print('Input: codes  = ("{}")'.format('", "'.join(codes)))
    print('      names  = ("{}")'.format('", "'.join(names)))
    print('      status = ("{}")'.format('", "'.join(status)))

    out = validate_codes(codes, names, status)
    print("Output: ({})\n".format(', '.join(out)))


# Example 1
codes1 = ["A123", "B_456", "C789", "D", "E123"]
names1 = ["electronics", "restaurant", "electronics", "pharmacy", "grocery"]
status1 = ["true", "false", "true", "true", "true"]
show_case("Example 1", codes1, names1, status1)

# Example 2
codes2 = ["Z_9", "AB_12", "G01", "X99", "test"]
names2 = ["pharmacy", "electronics", "grocery", "electronics", "unknown"]
status2 = ["true", "true", "false", "true", "true"]
show_case("Example 2", codes2, names2, status2)

# Example 3
codes3 = ["_123", "123", "", "Coupon_A", "Alpha"]
names3 = ["restaurant", "electronics", "electronics", "pharmacy", "grocery"]
status3 = ["true", "true", "false", "true", "true"]
show_case("Example 3", codes3, names3, status3)

# Example 4
codes4 = ["ITEM_1", "ITEM_2", "ITEM_3", "ITEM_4"]
names4 = ["electronics", "electronics", "grocery", "grocery"]
status4 = ["true", "true", "true", "true"]
show_case("Example 4", codes4, names4, status4)

# Example 5
codes5 = ["CAFE_X", "ELEC_100", "FOOD_1", "DRUG_A", "ELEC_99"]
names5 = ["restaurant", "electronics", "grocery", "pharmacy", "electronics"]
status5 = ["true", "true", "true", "true", "false"]
show_case("Example 5", codes5, names5, status5)
