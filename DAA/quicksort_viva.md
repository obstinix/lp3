# Quick Sort Analysis - Viva Preparation

## Program Objective

Compare deterministic and randomized versions of Quick Sort. Both programs
sort the same randomly generated array and measure their execution time.

## Top 20 Viva Questions and Answers

### 1. What is Quick Sort?

Quick Sort is a divide-and-conquer sorting algorithm. It selects a pivot,
partitions the array around that pivot, and recursively sorts the two
subarrays.

### 2. What is a pivot?

The pivot is the element used to divide the array. After partitioning, values
less than or equal to the pivot are placed on one side and larger values on
the other side.

### 3. How does the partition function work?

It scans the range from `low` to `high - 1`, moves values less than or equal
to the pivot toward the left, and finally places the pivot in its correct
sorted position.

### 4. What is the difference between the two variants?

The deterministic version always chooses the last element as the pivot. The
randomized version first selects a random element and swaps it with the last
element, then uses the same partition logic.

### 5. Why randomize the pivot?

Random pivot selection reduces the likelihood of repeatedly choosing a poor
pivot, especially when the input has an unfavorable order.

### 6. What is the best-case time complexity?

The best case is `O(n log n)`, when every pivot divides the array into nearly
equal parts.

### 7. What is the average-case time complexity?

The average-case time complexity is `O(n log n)`. Randomized Quick Sort has
this expected complexity regardless of the original input order.

### 8. What is the worst-case time complexity?

The worst case is `O(n^2)`, when the pivot repeatedly becomes the smallest or
largest element and one partition is empty.

### 9. When can deterministic Quick Sort reach the worst case?

If the last element is consistently a poor pivot, such as for an already
sorted or reverse-sorted array, the recursion can become highly unbalanced.

### 10. What is the space complexity?

Quick Sort uses `O(log n)` average recursion-stack space and `O(n)` worst-case
stack space. The partitioning itself is in-place and uses `O(1)` extra array
space.

### 11. Is Quick Sort stable?

No. Equal elements may change their relative order during swaps.

### 12. Is Quick Sort in-place?

Yes, the partition operation rearranges the input array without requiring a
second array. The recursion stack is still additional memory.

### 13. What is the base case?

The recursive function stops when `low >= high`, because a range with zero or
one element is already sorted.

### 14. Why are the recursive calls made on `pivotIndex - 1` and
`pivotIndex + 1`?

The pivot is already in its final position, so it must not be processed again.
Only the ranges before and after the pivot need sorting.

### 15. What is the purpose of copying the original array?

Each sorting method receives its own copy. This ensures both algorithms sort
the same original data and can be compared fairly.

### 16. How is execution time measured in Python?

The Python program uses `time.perf_counter()`, which is suitable for measuring
short elapsed intervals with high-resolution timing.

### 17. How is execution time measured in C++?

The C++ program uses `chrono::high_resolution_clock` and calculates the
duration between the start and end of each sort.

### 18. Does randomized Quick Sort always run faster?

No. Randomization improves expected behavior but does not guarantee a faster
run for every input. Timing also depends on the input, system load, and
random choices.

### 19. What is the recurrence relation for Quick Sort?

For balanced partitions:

```text
T(n) = 2T(n/2) + O(n) = O(n log n)
```

For an extremely unbalanced partition:

```text
T(n) = T(n - 1) + O(n) = O(n^2)
```

### 20. Why is partitioning `O(n)`?

Each element in the selected subarray is examined at most once, and each
swap takes constant time.

## Additional Relevant Questions

### 21. What is the difference between expected and guaranteed complexity?

Randomized Quick Sort has expected `O(n log n)` time, but a particular random
sequence can still produce the `O(n^2)` worst case.

### 22. What happens when duplicate values are present?

The program still sorts correctly. The condition `arr[j] <= pivot` places
equal values on the left side, although it can create less balanced
partitions for arrays containing many duplicates.

### 23. Why does the randomized partition call the deterministic partition?

Both variants use the same partition algorithm. The only difference is how
the pivot is chosen; after moving the random pivot to the final position, the
common partition logic can be reused.

### 24. What is the role of `mt19937` in the C++ program?

`mt19937` is a pseudorandom number generator used to select random pivot
indexes and generate random array values.

### 25. What is the role of `random.randint` in Python?

It generates a random integer within the specified inclusive range. It is
used to select the randomized pivot and create test values.

### 26. Does the program measure array-generation time?

No. The timer starts after the arrays have been generated and measures only
the sorting operation.

### 27. What is a limitation of timing a single small array?

The measured time may be dominated by timer precision and system activity.
Reliable comparisons should use larger inputs or multiple repeated trials.

### 28. How can worst-case recursion be reduced?

Use randomized or median-of-three pivot selection, recurse first on the
smaller partition, and process the larger partition iteratively.

### 29. How does Quick Sort compare with Merge Sort?

Quick Sort is usually in-place and often fast in practice, but has a
worst-case `O(n^2)` time. Merge Sort guarantees `O(n log n)` time but normally
requires `O(n)` extra array space.

### 30. What input validation does the program perform?

Both versions require the number of elements to be a non-negative integer.
They generate values from `1` to `100000`, then sort and display the results.

## Quick Exam Revision

- Quick Sort uses divide and conquer.
- The pivot divides the array into two ranges.
- Partitioning takes `O(n)`.
- Best and average time: `O(n log n)`.
- Worst-case time: `O(n^2)`.
- Average stack space: `O(log n)`.
- Worst-case stack space: `O(n)`.
- It is in-place but not stable.
- Deterministic version uses the last element as pivot.
- Randomized version moves a random pivot to the last position.
- The pivot is excluded from subsequent recursive calls.
