import sys
import bisect

prices = [int(value) for value in sys.argv[1:]]


sale_prices = []
seen_prices = []
for price in reversed(prices):
    seen_price_index = bisect.bisect_right(seen_prices, price)
    discount = seen_prices[seen_price_index-1] if seen_price_index > 0 else 0
    if seen_price_index == 0 or seen_prices[seen_price_index-1] != price:
        seen_prices[seen_price_index:] = [price]
    sale_prices.insert(0, price - discount)


print("prices: ", prices)
print("sale prices ", sale_prices)
