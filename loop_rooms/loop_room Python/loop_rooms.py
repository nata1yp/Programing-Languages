import sys
# print(sys.getrecursionlimit())
sys.setrecursionlimit(3000)

inFile = sys.argv[1]

inputfile = open(inFile)
N, M = list(map(int, inputfile.readline().split()))
maze = []
lines = inputfile.read().split("\n")[0:-1]

def split(word):
    return [char for char in word]

def assoi(array, si, sj):
    while ((len(si) != 0) and (len(sj) != 0)):
        x = si[-1]
        si.pop()
        y = sj[-1]
        sj.pop()
        array[x][y] = 1

def zeros(array, si, sj):
    while ((len(si) != 0) and (len(sj) != 0)):
        x = si[-1]
        si.pop()
        y = sj[-1]
        sj.pop()
        array[x][y] = 0

def mark(maze, array, x, y, si, sj):
    si.append(x)
    sj.append(y)
    if (maze[x][y] == 'U'):
        x -= 1
    elif (maze[x][y] == 'R'):
        y += 1
    elif (maze[x][y] == 'D'):
        x += 1
    else: 
        y -= 1

    # print(x,y)
    if (array[x][y] == -1):
        array[x][y] = 0
        mark(maze, array, x, y, si, sj)
    elif (array[x][y] == 1):
        assoi(array, si, sj)
    else:
        zeros(array, si, sj)


for line in lines:
    char = (split(line))
    maze.append(char)
# print(maze)

array = [[-1 for j in range(M)] for i in range(N)]
# print(array)

for i in range(N):
    for j in range(M):
        if ((i == 0) and (maze[i][j] == 'U')):
            array[i][j] = 1
        if ((j == 0) and (maze[i][j] == 'L')):
            array[i][j] = 1
        if ((i == N-1) and (maze[i][j] == 'D')):
            array[i][j] = 1
        if ((j == M-1) and (maze[i][j] == 'R')):
            array[i][j] = 1    
# print(array, "\n")

si = []
sj = []

for i in range(N):
    for j in range(M):
        if (array[i][j] == -1):
            mark(maze, array, i, j, si, sj)

s = 0
for i in range(N):
    for j in range(M):
        if (array[i][j] == 0):
            s += 1
print(s)