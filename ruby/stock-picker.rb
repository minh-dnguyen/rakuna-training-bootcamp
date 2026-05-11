# frozen_string_literal: true

def stock_picker(prices)
  max_profit = 0
  best_days = [0, 0]
  buy_day = 0
  while buy_day < prices.length
    sell_day = buy_day + 1
    while sell_day < prices.length
      profit = prices[sell_day] - prices[buy_day]
      if profit > max_profit
        max_profit = profit
        best_days = [buy_day, sell_day]
      end
      sell_day += 1
    end
    buy_day += 1
  end
  best_days
end

p stock_picker([17, 3, 6, 9, 15, 8, 6, 1, 10])
