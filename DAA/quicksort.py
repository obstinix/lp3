"""Compare deterministic and randomized Quick Sort."""

import random
import time


def deterministic_partition(arr, low, high):
    pivot = arr[high]
    i = low - 1

    for j in range(low, high):
        if arr[j] <= pivot:
            i += 1
            arr[i], arr[j] = arr[j], arr[i]

    arr[i + 1], arr[high] = arr[high], arr[i + 1]
    return i + 1


def deterministic_quick_sort(arr, low, high):
    if low < high:
        pivot_index = deterministic_partition(arr, low, high)
        deterministic_quick_sort(arr, low, pivot_index - 1)
        deterministic_quick_sort(arr, pivot_index + 1, high)


def randomized_partition(arr, low, high):
    random_index = random.randint(low, high)
    arr[random_index], arr[high] = arr[high], arr[random_index]
    return deterministic_partition(arr, low, high)


def randomized_quick_sort(arr, low, high):
    if low < high:
        pivot_index = randomized_partition(arr, low, high)
        randomized_quick_sort(arr, low, pivot_index - 1)
        randomized_quick_sort(arr, pivot_index + 1, high)


def measure_time(sort_function, original_array):
    arr = original_array.copy()
    start_time = time.perf_counter()
    sort_function(arr, 0, len(arr) - 1)
    end_time = time.perf_counter()
    return arr, end_time - start_time


try:
    n = int(input("Enter the number of elements for the array: "))
except ValueError:
    print("Please enter a non-negative integer.")
else:
    if n < 0:
        print("Please enter a non-negative integer.")
    else:
        arr = [random.randint(1, 100000) for _ in range(n)]
        print("\nOriginal array:", arr)

        sorted_deterministic, deterministic_time = measure_time(
            deterministic_quick_sort, arr
        )
        sorted_randomized, randomized_time = measure_time(
            randomized_quick_sort, arr
        )

        print("\nUsing deterministic Quick Sort:")
        print("Sorted array:", sorted_deterministic)
        print(f"Time taken: {deterministic_time:.8f}s")

        print("\nUsing randomized Quick Sort:")
        print("Sorted array:", sorted_randomized)
        print(f"Time taken: {randomized_time:.8f}s")
