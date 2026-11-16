# 0/1 Knapsack Using Dynamic Programming - Viva Preparation

## Program Objective

Select items with maximum total profit without exceeding the knapsack
capacity. Each item can either be selected completely or not selected at all.
This implementation solves the **0/1 Knapsack problem using dynamic
programming**.

## Problem Definition

For each item `i`:

- `weight[i]` is its weight.
- `profit[i]` is its profit.
- `x[i]` is either `0` or `1`.

The objective is:

```text
Maximize sum(profit[i] * x[i])
subject to sum(weight[i] * x[i]) <= capacity
```

## Top 20 Viva Questions and Answers

### 1. What is the 0/1 Knapsack problem?

It is an optimization problem in which each item is either selected completely
(`1`) or rejected (`0`). The selected items must fit within the given
capacity, while their total profit is maximized.

### 2. Why is it called 0/1 Knapsack?

For every item, the decision variable can have only two values:

```text
0 = do not select the item
1 = select the item
```

An item cannot be selected more than once or partially selected.

### 3. What algorithm does this program use?

It uses dynamic programming. It constructs a table in which each entry stores
the maximum profit possible for a particular number of items and capacity.

### 4. What is the dynamic-programming state?

`dp[i][w]` represents the maximum profit obtained using the first `i` items
with a knapsack capacity of `w`.

### 5. What is the recurrence relation?

If item `i` fits:

```text
dp[i][w] = max(
    dp[i - 1][w],
    profit[i] + dp[i - 1][w - weight[i]]
)
```

The first choice excludes the item, and the second choice includes it.

### 6. What happens when the item does not fit?

If `weight[i] > w`, the item cannot be selected:

```text
dp[i][w] = dp[i - 1][w]
```

The best result is copied from the previous row.

### 7. Why is the DP table initialized with zeroes?

Using zero items or a knapsack with zero capacity gives zero profit. These
are the base cases represented by the first row and first column.

### 8. Why are the vectors created with `n + 1` elements?

The program uses item indexes from `1` through `n`. Index `0` is reserved for
the base case, so `n + 1` positions are required.

### 9. Why does the loop start from item 1?

Index `0` represents the case of selecting no items. Actual input items are
stored from index `1`.

### 10. What is the time complexity?

There are `(n + 1) * (capacity + 1)` DP entries, and each entry takes constant
time to calculate. Therefore, the time complexity is:

```text
O(n * capacity)
```

### 11. What is the space complexity?

The two-dimensional table contains `(n + 1) * (capacity + 1)` entries, so the
space complexity is:

```text
O(n * capacity)
```

### 12. What is the meaning of overlapping subproblems?

The same smaller knapsack problems occur while solving different larger
problems. Dynamic programming stores their results so they are not solved
repeatedly.

### 13. What is optimal substructure in this problem?

An optimal solution to a problem contains optimal solutions to its smaller
subproblems. The best solution for `i` items and capacity `w` is built from
solutions involving `i - 1` items.

### 14. How does the program find the selected items?

It starts at `dp[n][capacity]` and moves upward through the table. If:

```cpp
dp[i][w] != dp[i - 1][w]
```

item `i` was selected. Its weight is then subtracted from `w`.

### 15. Why are selected items checked from `n` down to 1?

Backtracking starts at the final table entry and follows the decisions toward
the base case. Therefore, items are examined in reverse order.

### 16. Why can the selected items be printed in reverse order?

The reconstruction loop visits items from `n` down to `1`. The selected set is
correct, but the display order is descending by item number. It can be
reversed if ascending order is required.

### 17. Can this problem be solved using a greedy algorithm?

The general 0/1 Knapsack problem cannot be solved optimally by simply choosing
the highest profit, lowest weight, or highest profit-to-weight ratio. Greedy
selection is correct for the **fractional Knapsack** problem, not generally
for 0/1 Knapsack.

### 18. What is the difference between 0/1 and fractional Knapsack?

| 0/1 Knapsack | Fractional Knapsack |
|---|---|
| An item is fully selected or rejected | Fractions of items are allowed |
| Dynamic programming is commonly used | Greedy ratio method is optimal |
| Usually `O(n * capacity)` DP time | Usually `O(n log n)` after sorting |

### 19. Is `O(n * capacity)` polynomial?

It is pseudo-polynomial. The complexity is polynomial in the numeric value of
the capacity, but not necessarily in the number of bits required to represent
the capacity.

### 20. What is the purpose of `max()` in the program?

`max()` chooses the better of two decisions:

1. Exclude the current item.
2. Include the current item and add its profit.

## Additional Relevant Questions

### 21. What happens if an item's weight is greater than the capacity?

That item cannot be selected for that capacity. The program copies the result
from the previous row.

### 22. What happens if an item has zero weight?

It can fit in every capacity. If it has positive profit, selecting it is
beneficial. Input rules should still be defined clearly for zero-weight items.

### 23. What happens if an item has zero profit?

Selecting it does not improve the objective. The DP table may choose either
decision without changing the maximum profit.

### 24. What assumptions does this implementation make?

It assumes that:

- `n` is non-negative.
- Capacity is non-negative.
- Weights and profits are integer values.
- Input is valid.
- The values fit in the `int` data type.

Production-quality code should validate these assumptions and use `long long`
when profits may be large.

### 25. Why does this implementation use integer capacity?

The DP table uses capacity as an array index. Array indexes must be discrete,
so this implementation is designed for non-negative integer weights and
capacity. Decimal weights require a different approach or scaling strategy.

### 26. What is the brute-force complexity?

Each item has two choices, so brute force can examine up to `2^n` subsets.
Its time complexity is `O(2^n)`, which is much slower than the DP approach
for moderate integer capacities.

### 27. Can the space complexity be reduced?

Yes. A one-dimensional DP array can reduce space to `O(capacity)`. In that
version, capacities must be processed from right to left so that an item is
not reused in the same iteration.

### 28. Why must a one-dimensional 0/1 DP loop run backward?

Processing capacities backward ensures that `dp[w - weight]` still refers to
the previous item iteration. Processing forward could use the same item
multiple times, which would change the problem into an unbounded knapsack
variant.

### 29. Can there be multiple optimal solutions?

Yes. Different subsets can have the same maximum profit. The reconstruction
condition in this program returns one optimal solution, not necessarily every
possible solution.

### 30. What is the output of the program?

It prints:

1. The maximum possible profit.
2. The item numbers selected to obtain that profit.

It does not print the total selected weight unless that is added separately.

## Example

For:

```text
Item   Weight   Profit
1         2        12
2         1        10
3         3        20
4         2        15

Capacity = 5
```

One optimal selection is items `1`, `2`, and `4`:

```text
Total weight = 2 + 1 + 2 = 5
Total profit = 12 + 10 + 15 = 37
```

The program can print these items in reverse order:

```text
Maximum Profit = 37
Selected Items: 4 2 1
```

## Quick Exam Revision

- 0/1 means each item is selected once or not selected.
- DP state: `dp[i][w]`.
- Include/exclude recurrence gives the maximum.
- Base row and column contain zeroes.
- Time complexity: `O(n * capacity)`.
- Space complexity of this program: `O(n * capacity)`.
- It is pseudo-polynomial.
- Greedy ratio is not generally correct for 0/1 Knapsack.
- Greedy ratio is correct for Fractional Knapsack.
- Backtracking identifies selected items.
- Multiple optimal subsets may exist.
- A one-dimensional optimization uses `O(capacity)` space and iterates
  capacities backward.
