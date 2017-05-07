
class Board:
    def __init__(self):
        self.b  = [[0 for x in range(3)] for y in range(3)] #creates a 3x3 matrix
        self.current = {1:'X',2:'O',0:' '} #stores the players and its symbols
        self.curr_player = 1

    def getCurrentPlayer(self):
        return self.curr_player

    def __str__(self): #prints the board
        string = ""
        for i in range(len(self.b)):
            for j in range(len(self.b)):
                if j is 2:
                    s = " "
                else:
                    s = "|"
                string = string + " " + self.current[self.b[i][j]] + " " + s
##                if self.b[i][j] == 0:
##                    string = string+" "*3 + s
##                elif self.b[i][j] == 1:
##                    string = string+" X "+ s
##                else:
##                    string = string+ " O " +s 
            if i is not 2:
                string = string + "\n-----------\n"


        return string

    def possibleMoves(self): #returns the possible moves
        #O(n^2)
        l = []
        for i in range(len(self.b)):
            for j in range(len(self.b)):
                if self.b[i][j] is 0:
                    l.append((i,j))
        return l        
    def getField(self, c, r):#returns a smaller board
        col = c + 1
        row = r + 1
        smallBoard = [[0 for x in range(col)] for y in range(row)]
        for i in range(row):
            for j in range(col):
                smallBoard[i][j] = self.b[i][j]
        return smallBoard

    def makeMove(self, row, col): #makes the move if it is a valid move
                                  #other wise raises an exception
        if self.b[row][col] is not 0:
            raise Exception("Invalid Move")
        self.b[row][col] = self.curr_player
        if self.curr_player is 1:
            self.curr_player = 2
        else:
            self.curr_player = 1

    def undoMove(self, row, col): #undoes the move
        self.b[row][col] = 0
        if self.curr_player is 2: #changes the turn
            self.curr_player = 1
        else:
            self.curr_player = 2
            
    def isWin(self, player): #checks is player win
        if player is not 1 and player is not 2: #raises a exception
                                                #if invalid player entered
            raise Exception("Invalid Player")

        win = [player]*len(self.b)
        
        for i in self.b:
            if win == i:
                return True
        for j in range(len(self.b)):
            store =[]
            for i in self.b:
                store.append(i[j])
            if  win == store:
                return True
        
        dia1 = [self.b[0][0],self.b[1][1],self.b[2][2]]
        dia2 = [self.b[0][2],self.b[1][1],self.b[2][0]]
        if win == dia1 or win == dia2:
            return True
        
        return False
        
    def isFull(self):
        for i in self.b:
            for j in i:
                if j is 0:
                    return False
        return True
    
    def isOver(self):
        if self.isWin(1) or self.isWin(2):
            return True
        elif self.isFull():
            return True
        else:
            return False

    def getResult(self):
        if self.isWin(1):
            return 1
        elif self.isWin(2):
            return 2
        else:
            return 0

    def reset(self): #resets the board and curr_player
        self.b  = [[0 for x in range(3)] for y in range(3)]
        self.curr_player = 1





