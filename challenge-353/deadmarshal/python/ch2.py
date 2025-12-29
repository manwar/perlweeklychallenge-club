#!/usr/bin/env python

def validate_coupon(codes, categories, statuses):
  valids = {'electronics', 'grocery', 'pharmacy', 'restaurant'}
  res = []

  for i in range(len(codes)):
    valid = codes[i] and all(c.isalnum() or c == '_' for c in codes[i])
    cvalid = categories[i] in valids
    svalid = statuses[i] == 'true'
    res.append(True if valid and cvalid and svalid else False)

  return res

print(validate_coupon(['A123','B_456','C789','D@1','E123'],
		      ['electronics','restaurant','electronics',
		       'pharmacy','grocery'],
		      ['true','false','true','true','true']))
print(validate_coupon(['Z_9','AB_12','G01','X99','test'],
		      ['pharmacy','electronics','grocery',
		       'electronics','unknown'],
		      ['true','true','false','true','true']))
print(validate_coupon(['_123','123','','Coupon_A','Alpha'],
		      ['restaurant','electronics','electronics',
		       'pharmacy','grocery'],
		      ['true','true','false','true','true']))
print(validate_coupon(['ITEM_1','ITEM_2','ITEM_3','ITEM_4'],
		      ['electronics','electronics','grocery','grocery'],
		      ['true','true','true','true']))
print(validate_coupon(['CAFE_X','ELEC_100','FOOD_1','DRUG_A','ELEC_99'],
		      ['restaurant','electronics','grocery',
		       'pharmacy','electronics'],
		      ['true','true','true','true','false']))

