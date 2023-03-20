import sys
from collections import deque

inFile = sys.argv[1]
inputfile = open(inFile)

N = int(inputfile.readline())
solved = False

for line in inputfile:
    queue = [int(i) for i in line.split()]  

sorted = queue[:]
sorted.sort()
sorted = tuple(sorted)

init = (tuple(queue), (), '')
Q = deque([init])
prev = {init: None}

visited = set()
visited.add(hash((init[0], init[1])))

def next(s):
    if (s[0]):
        temp_queue = s[0][1:]
        temp_stack = (s[0][0],) + s[1]
        moves = s[2] + "Q"
        yield (temp_queue, temp_stack, moves)
    if (s[1]):
        temp_queue = s[0] + (s[1][0],)
        temp_stack = s[1][1:]
        moves = s[2] + "S"
        yield (temp_queue, temp_stack, moves)


while Q:
    s = Q.popleft()
    if (s[0] == sorted):
        solved = True
        break
    for t in next(s):
        if hash((t[0], t[1])) not in visited:     
            Q.append(t)
            visited.add(hash((t[0], t[1])))

if solved:
    if(not s[2]):
        print("empty")
    else:
        print(s[2])