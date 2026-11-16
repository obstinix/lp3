# Fibonacci Series - DAA Viva Preparation

## Program Objective

Generate the first `n` Fibonacci numbers using:

1. An iterative (non-recursive) approach.
2. A recursive approach.
3. Step counting and time/space complexity analysis.

The sequence used by these programs is:

```text
0, 1, 1, 2, 3, 5, 8, 13, ...
```

The recurrence relation is:

```text
F(n) = F(n - 1) + F(n - 2)
F(0) = 0, F(1) = 1
```

## Top 20 Viva Questions and Answers

### 1. What is the Fibonacci series?

The Fibonacci series is a sequence in which every term is the sum of the
previous two terms. It starts with `0` and `1`:
`0, 1, 1, 2, 3, 5, 8, ...`.

### 2. What is the recurrence relation for Fibonacci numbers?

For `n >= 2`:

```text
F(n) = F(n - 1) + F(n - 2)
```

The base cases are `F(0) = 0` and `F(1) = 1`.

### 3. What does the program calculate?

It calculates and prints the first `n` Fibonacci numbers, where `n` is
entered by the user.

### 4. Why does the iterative program initialize `series` as `[0, 1]`?

`0` and `1` are the first two Fibonacci values. The loop calculates the
remaining values starting from index `2`.

### 5. Why does the loop use `range(2, n)`?

The first two values are already present at indexes `0` and `1`, so the loop
starts at index `2` and continues up to, but not including, `n`.

### 6. What is the purpose of `a`, `b`, and `c`?

`a` and `b` store the two previous Fibonacci values. `c` stores their sum:

```python
c = a + b
a = b
b = c
```

This moves the pair forward for the next iteration.

### 7. Why must the update statements be inside the loop?

They must execute after every new term is calculated. If they are outside the
loop, only one term is appended and the remaining Fibonacci values are lost.

### 8. What happens when `n` is 0 or 1?

The loop does not execute. The output is obtained using `series[:n]`:

```text
n = 0 -> []
n = 1 -> [0]
```

### 9. What is the time complexity of the iterative approach?

The loop executes approximately `n - 2` times, so the time complexity is
`O(n)`.

### 10. What is the space complexity of the iterative approach?

The program stores all `n` terms in `series`, so its space complexity is
`O(n)`. If only the last two values were required, the auxiliary space would
be `O(1)`.

### 11. What is recursion?

Recursion is a technique in which a function calls itself to solve smaller
instances of the same problem.

### 12. What are the base cases in `recursive_fib`?

The base cases are:

```python
if n <= 1:
    return n
```

They return `0` for `F(0)` and `1` for `F(1)` and stop further recursive
calls.

### 13. How does the recursive Fibonacci function work?

For `n > 1`, it computes:

```python
recursive_fib(n - 1, counter) + recursive_fib(n - 2, counter)
```

The function keeps dividing the problem into two smaller overlapping
subproblems.

### 14. What is the time complexity of the recursive approach?

The simple recursive algorithm has exponential time complexity, commonly
written as `O(2^n)`. A tighter bound is `O(phi^n)`, where `phi` is the golden
ratio. It repeats many calculations.

### 15. What is the space complexity of the recursive approach?

The maximum recursion depth is `O(n)`. The program also stores the generated
series, which requires `O(n)` space. Therefore, the total space complexity is
`O(n)`.

### 16. Why is the recursive approach slower?

It calculates the same Fibonacci values repeatedly. For example, calculating
`F(5)` calculates `F(3)` and other subproblems multiple times.

### 17. How can recursive Fibonacci be optimized?

Dynamic programming can store already calculated values. This avoids repeated
work and reduces the time complexity to `O(n)`.

Two common methods are:

- **Memoization:** top-down recursion with a cache.
- **Tabulation:** bottom-up calculation using an array.

### 18. What is the difference between iteration and recursion here?

| Iterative approach | Recursive approach |
|---|---|
| Uses a loop | Uses function calls |
| Runs in `O(n)` time | Runs in exponential time |
| No recursion overhead | Uses a recursion stack |
| Generally more efficient | Easier to express mathematically |

### 19. What is step counting?

Step counting estimates how many selected basic operations execute in an
algorithm. In the iterative program, the counter is incremented for
initialization, addition, append, and variable updates.

For this implementation, the formula is:

```text
3 + 4 max(0, n - 2)
```

The exact count depends on which operations the programmer chooses to count.

### 20. What is the purpose of `step_counter` in the recursive program?

`step_counter` is a dictionary containing a mutable `count` value. Each call
to `recursive_fib` increments that value, allowing the program to count
recursive function calls.

## Additional Relevant Questions

### 21. Why is a dictionary used for the recursive counter?

Integers are immutable in Python. A dictionary lets every recursive call
modify the same shared `count` value without returning the counter separately.

### 22. What is overlapping subproblem property?

A problem has overlapping subproblems when the same smaller problem is solved
more than once. Naive recursive Fibonacci has this property, which is why
dynamic programming improves its performance.

### 23. What is optimal substructure?

A problem has optimal substructure when its solution can be constructed from
solutions to smaller subproblems. Fibonacci values directly use solutions of
the two previous smaller values.

### 24. What is the difference between `O(n)` and `O(2^n)`?

`O(n)` grows linearly as the input increases. `O(2^n)` grows exponentially,
so even a moderate increase in `n` can make the recursive solution very slow.

### 25. What is the main limitation of the program?

The recursive version becomes inefficient for large `n`, and Python integers
and memory usage also grow as the Fibonacci values become larger. An iterative
or dynamic-programming solution is preferable for large inputs.

## Quick Exam Revision

- Base values: `F(0) = 0`, `F(1) = 1`.
- Formula: `F(n) = F(n-1) + F(n-2)`.
- Iterative time: `O(n)`.
- Iterative space while storing the series: `O(n)`.
- Iterative auxiliary space if only two values are kept: `O(1)`.
- Naive recursive time: `O(2^n)` commonly, or tighter `O(phi^n)`.
- Recursive stack space: `O(n)`.
- Dynamic programming time: `O(n)`.
- Dynamic programming space with an array: `O(n)`.
- Main recursive weakness: repeated calculation of overlapping subproblems.

## Combined C++ Program

The folder also contains `fibonacci.cpp`, which prints both series using one
program. It uses `iterativeSeries` for the loop-based method and
`recursiveSeries` for the recursive method. Both methods use the same base
values, `F(0) = 0` and `F(1) = 1`.

### Questions About the Combined Program

#### Why are both approaches in one program?

Keeping both approaches together makes their outputs easy to compare for the
same input and demonstrates the difference between iteration and recursion.

#### What does `recursiveCallCount` measure?

It counts every call to `recursiveFibonacci`, including calls that reach the
base cases. It is an instrumented count of function calls, not a count of all
machine instructions.

#### Why does the C++ program use `long long`?

Fibonacci values grow quickly, so `long long` supports larger values than a
standard `int`. It still has a finite limit; very large terms can overflow.

#### What is the C++ program's space complexity?

The generated series requires `O(n)` space. The recursive call stack also
requires `O(n)` space. The recursive calculation still has exponential time
because it repeats subproblems.
