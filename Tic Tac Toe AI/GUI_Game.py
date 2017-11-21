from tkinter import *
from Player_Class import *

class GUI_Game_Class:
    def __init__(self):
        self.window = Tk()
        # Default Player against to Player 
        self.players = {1:Human("Player1"), 2:Human("Player2")}
        self.AI = False
        self.board = Board() 
        self.window.title("TicTacToe")

        # To start first
        self.option1 = Button(self.window,
                              text="Player1 starts",
                              fg="white",
                              bg="darkblue",
                              command = lambda:self.who_start(1),
                              height = 3,
                              width = 10)
        self.option1.grid(row=0,column=0, sticky = N)

        # To start second
        self.option2 = Button(self.window,
                              text="Player2 starts",
                              fg="white",
                              bg="darkblue",
                              command = lambda:self.who_start(2),
                              height = 3,
                              width = 10)
        self.option2.grid(row=0,column=2)

        # To turn On or Off the AI
        self.option3 = Button(self.window,
                              text="AI Off",
                              fg="white",
                              bg="red",
                              command = lambda:self.ai_on_off(),
                              height = 3,
                              width = 10)
        self.option3.grid(row=0,column = 1)

        # To Exit the Game
        self.exit = Button(self.window,
                           text = "Exit",
                           fg = "white",
                           bg = "darkblue",
                           command = quit,
                           height = 1,
                           width = 2)
        self.exit.grid(row=1,column=0)

        # To reset the board
        # Reset board and re-draw it
        self.reset = Button(self.window,
                           text = "Reset",
                           fg = "white",
                           bg = "darkblue",
                           command = lambda: [self.board.reset(), self.draw()],
                           height = 1,
                           width = 4)
        self.reset.grid(row=1,column=2)

        # For printing helping messages
        self.helper = Label(self.window,
                            text="helper",
                            fg="black",
                            height = 3)
        self.helper.grid(row=1, column=1,columnspan = 1)

        # Board buttons
        self.buttons = [[None for row in range(3)] for col in range(3)]
        for row in range(3):
            for col in range(3):
                b = Button(self.window,
                            text="",
                            fg="black",
                            bg="white",
                            command = lambda row=row, col=col:self.buttonPressed(row,col), 
                            height = 5,
                            width = 10) 
                b.grid(row=row+2, column=col)
                self.buttons[row][col] = b

    def start(self):
        self.window.mainloop()
                
    def draw(self):
        # Draws the board
        for row in range(3):
            for col in range(3):
                val = self.board.b[row][col] # According the value it prints X or O or nothing
                if val is 1:
                        self.buttons[row][col]["text"] = "X"
                elif val is 2:
                        self.buttons[row][col]["text"] = "O"
                else:
                        self.buttons[row][col]["text"] = ""
                    

    def who_start(self, who):
        
        if self.AI:
            self.players[1] = Human("Player")
            self.players[2] = SmartPlayer("AI")
            
        self.helper["text"] = self.players[who].getName() + " turn"
        self.board.reset()
        self.board.curr_player = who
        if who == 2 and self.AI: # If AI is on and AI starts first,
                                 # AI makes the move.
            row, col = self.players[2].getMove(self.board) 
            self.board.makeMove(row,col)
        self.draw()
            

    def ai_on_off(self):
        
        self.AI = not self.AI
        if self.AI:
            self.option3["text"] = "AI On"
            self.option3["bg"] = "green"
            
            self.players[1] = Human("Player")
            self.players[2] = SmartPlayer("AI")
            
            if self.board.curr_player == 2 and not self.board.isOver():
                # AI plays for the player 2 if its his/her turn 
                row, col = self.players[2].getMove(self.board)
                self.board.makeMove(row,col)
                self.draw()
                if self.board.isWin(2):
                    self.helper["text"]=self.players[2].getName() + " win"
        else:
            self.option3["text"] = "AI Off"
            self.option3["bg"] = "red"
            # Back to the default form
##            self.players[1] = Human("Player1")
            self.players[2] = Human("Player2")
            

    def buttonPressed(self, row, col):
        try: # makeMove throws exception when invalid move entered
            if not self.board.isOver(): # Play until game is over
                self.board.makeMove(row,col)
                self.helper["text"] = self.players[self.board.curr_player].getName() + " turn"

                if not self.board.isOver() and self.AI: # Before AI plays check is game over
                    row, col = self.players[self.board.curr_player].getMove(self.board)
                    self.board.makeMove(row, col)
    
                self.draw()
            # Print the winner in the helper label   
            if self.board.isWin(1):
                    self.helper["text"]=self.players[1].getName() + " win"
            elif self.board.isWin(2):
                    self.helper["text"]=self.players[2].getName() + " win"
            if self.board.isFull():
                    self.helper["text"]="Tie"
                    
        except Exception as e:
            self.helper["text"] = e #Prints the Exception on helper label

g = GUI_Game_Class()
g.start()
