# N-Queens Problem - DAA Viva Preparation

## Program Objective

Place `n` queens on an `n x n` chessboard so that no two queens attack each
other. The Python and C++ programs use backtracking and generate all valid
solutions.

## Top 20 Viva Questions and Answers

### 1. What is the N-Queens problem?

It is the problem of placing `n` queens on an `n x n` chessboard so that no
two queens share the same row, column, or diagonal.

### 2. Why is backtracking used?

Backtracking builds a solution one row at a time. When a partial placement
cannot lead to a valid solution, it removes the last queen and tries another
column.

### 3. What is the basic strategy of the program?

For each row, try every column. If a column is safe, place a queen and
recursively solve the next row. After returning, remove the queen so the next
choice can be tested.

### 4. Why is one queen placed per row?

The algorithm selects exactly one position in each row. This automatically
prevents two queens from sharing a row.

### 5. How are column conflicts checked?

The `cols` set in Python and the `columns` vector in C++ record columns that
already contain queens. A candidate is rejected if its column is occupied.

### 6. How are diagonal conflicts detected?

For a cell `(row, column)`:

- Cells on the same descending diagonal have the same `row - column`.
- Cells on the same ascending diagonal have the same `row + column`.

The programs track both values.

### 7. Why is `row - column` shifted in the C++ program?

`row - column` can be negative. Adding `n - 1` converts it into an array
index from `0` to `2n - 2`:

```cpp
int firstDiagonal = row - col + n - 1;
```

### 8. What is the base case?

When `row == n`, all rows contain a safely placed queen. The current board is
therefore a complete solution and is stored.

### 9. What happens during backtracking?

The queen is removed from the board and its column and diagonal markers are
cleared. This restores the state before the choice was made.

### 10. What is the time complexity?

The worst-case time complexity is commonly stated as `O(n!)`, because the
algorithm explores permutations of column placements. Safety checks reduce
the practical search, but the problem remains exponential.

### 11. What is the space complexity?

The auxiliary tracking structures and recursion stack require `O(n)` space.
Because these programs store every board, the total space can be `O(S * n^2)`,
where `S` is the number of solutions.

### 12. What is the difference between auxiliary space and total space here?

Auxiliary space excludes the stored output and is `O(n)`. Total space includes
all saved solutions and can be much larger.

### 13. Why can no solution exist for `n = 2` or `n = 3`?

It is impossible to place all queens without a conflict for those board sizes.
Therefore, the program correctly returns zero solutions.

### 14. How many solutions exist for `n = 1` and `n = 4`?

There is one solution for `n = 1` and two solutions for `n = 4`.

### 15. What is the purpose of the board representation?

Each board row is a string containing `.` for an empty cell and `Q` for a
queen. This makes the solutions easy to print.

### 16. Why are all solutions stored?

The requirement is to generate all valid boards, not only the first one.
Whenever the base case is reached, a copy of the current board is stored.

### 17. What would change if only one solution were required?

The search could stop and return immediately after the first complete board.
There would be no need to store a vector of all solutions.

### 18. What is the role of recursion in this solution?

Each recursive call represents the decision for one row. The call stack keeps
the previous row choices until the algorithm either finds a solution or
backtracks.

### 19. What input validation is performed?

Both programs require the number of queens to be a positive integer. Invalid
input is rejected instead of creating an invalid board.

### 20. What is the main advantage of backtracking over brute force?

Brute force can examine every possible board arrangement. Backtracking
rejects unsafe partial arrangements early, avoiding many unnecessary
possibilities.

## Additional Relevant Questions

### 21. Is N-Queens an optimization problem?

The usual N-Queens problem is a constraint-satisfaction problem: find boards
that satisfy all constraints. It can be changed into an optimization problem
if an objective is added.

### 22. What is a promising node?

A partial board is promising if no two queens placed so far attack each other.
Only promising nodes are expanded.

### 23. What is the state-space tree?

Each level represents a row, and each branch represents a column choice for
that row. A path from the root to level `n` represents a complete board.

### 24. Why is a set useful in the Python version?

Membership checks and insertions are average `O(1)`. The sets make it quick to
test whether a column or diagonal is already occupied.

### 25. Why does the C++ version use `vector<bool>`?

It stores the occupied-column and occupied-diagonal flags compactly and
provides direct indexed access for constant-time checks.

### 26. What happens when `n = 0`?

The programs reject it because the intended input is a positive number of
queens. This also avoids treating an empty board as a complete solution.

### 27. Can symmetry reduce the search?

Yes. The first queen can be restricted to part of the first row, and mirrored
solutions can be generated afterward. This reduces work but is not required
for the basic implementation.

### 28. Can the algorithm be implemented without storing boards?

Yes. It can print each solution immediately or count solutions only. That
reduces output storage, although printing still takes output time.

### 29. How is the C++ program different from the Python program?

Both use the same backtracking logic and diagonal formulas. The C++ version
uses arrays of boolean flags and vectors, while the Python version uses sets.

### 30. What is the output for `n = 4`?

The program reports two solutions. Each solution has exactly one `Q` in every
row and column, with no queens sharing a diagonal.

## Quick Exam Revision

- One queen per row prevents row conflicts.
- Track columns using `cols` or `columns`.
- Track diagonals using `row - column` and `row + column`.
- Base case: `row == n`.
- Backtrack by undoing every placement and marker.
- Worst-case time: commonly `O(n!)`.
- Auxiliary space: `O(n)`.
- Storing all boards requires additional output space.
- `n = 1` has one solution; `n = 2` and `n = 3` have none.
- `n = 4` has two solutions.
