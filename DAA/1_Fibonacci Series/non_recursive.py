"""Write a program non-recursive and recursive program to calculate Fibonacci numbers and
analyze their time and space complexity."""
print("Program 1.2:Non Recursive program to calculate the Fibonacci Series:")
n=int(input("\nEnter the no. to calculate that many fibonacci series numbers: "))

count=0

series=[0,1]
count+=1

a=0
count+=1

b=1
count+=1

for i in range(2,n):
    c=a+b
    count+=1

    series.append(c)
    count+=1

    a=b
    count+=1

    b=c
    count+=1

iterations = max(0, n - 2)

print("Fibonacci Series",series[:n])
print("Step count Formula Wise",(4*iterations)+3)
print("Actual Step Count",count)

print("Time Complexity:O(n)")
print("Space Complexity:O(n)")