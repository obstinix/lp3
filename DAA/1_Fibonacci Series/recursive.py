"""Write a program non-recursive and recursive program to calculate Fibonacci numbers and
analyze their time and space complexity."""
print("Program 1.2:Recursive program to calculate the Fibonacci Series:")
num=int(input("\nEnter the no. to calculate that many fibonacci series numbers: "))

step_counter={"count":0}

def recursive_fib(n,counter):
  counter["count"]+=1
  if n<=1:
    return n
  return recursive_fib(n-1,counter)+ recursive_fib(n-2,counter)

series=[]

for i in range(num):
  series.append(recursive_fib(i,step_counter))

print("Fibonacci Series:",series)
print("Step count recursive",step_counter)
print("Time Complexity:O(2^n)")
print("Time Complexity:O(n)")