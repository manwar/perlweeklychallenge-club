#!/usr/bin/env python

import re

good_names = [
  "electronics", "grocery", "pharmacy", "restaurant"
]

def check_coupon(code, name, status):
  if (
    status == 'true' and
    name in good_names and
    re.fullmatch(r'^[a-zA-Z0-9_]+$', code)
  ):
    return 'true'
  else:
    return 'false'

def validate_coupon(params):
  coupons = []
  for t in zip(params["codes"],
               params["names"],
               params["status"]):
    coupons.append(check_coupon(*t))
  return coupons

def quoted_list(arr):
  return ", ".join([f'"{s}"' for s in arr])

def solution(params):
  print(f'Input: @codes  = ({quoted_list(params["codes"])})')
  print(f'       @names  = ({quoted_list(params["names"])})')
  print(f'       @status = ({quoted_list(params["status"])})')
  output = ", ".join(validate_coupon(params))
  print(f'Output: {output}')

print('Example 1:')
solution({
  'codes':  ["A123", "B_456", "C789", 'D@1', "E123"],
  'names':  ["electronics", "restaurant", "electronics",
             "pharmacy", "grocery"],
  'status': ["true", "false", "true", "true", "true"]
})

print('\nExample 2:')
solution({
  'codes':  ["Z_9", "AB_12", "G01", "X99", "test"],
  'names':  ["pharmacy", "electronics", "grocery",
             "electronics", "unknown"],
  'status': ["true", "true", "false", "true", "true"]
})

print('\nExample 3:')
solution({
  'codes':  ["_123", "123", "", "Coupon_A", "Alpha"],
  'names':  ["restaurant", "electronics", "electronics",
             "pharmacy", "grocery"],
  'status': ["true", "true", "false", "true", "true"]
})

print('\nExample 4:')
solution({
  'codes':  ["ITEM_1", "ITEM_2", "ITEM_3", "ITEM_4"],
  'names':  ["electronics", "electronics", "grocery", "grocery"],
  'status': ["true", "true", "true", "true"]
})

print('\nExample 5:')
solution({
  'codes':  ["CAFE_X", "ELEC_100", "FOOD_1", "DRUG_A", "ELEC_99"],
  'names':  ["restaurant", "electronics", "grocery", "pharmacy",
             "electronics"],
  'status': ["true", "true", "true", "true", "false"]
})
