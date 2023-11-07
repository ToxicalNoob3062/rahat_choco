//static shared arrays; (we will create these arrays only once and use them as much we want)
//just for caring about memory!
int[] timers = new int[3];

int[] flavors = new int[] {
    color(255, 255, 0), // Lemon (Yellow)
        color(255, 0, 0),   // Cherry (Red)
        color(255, 105, 180), // Strawberry (Pink)
        color(255, 165, 0), // Orange (Orange)
        color(55, 235, 52),   // Mint (Green)
        color(165, 42, 42), // Coffee (Brown)
        color(255, 255, 255) // Coconut (White)
    };

String[] shapes = new String[] {
    "round",
    "square",
    "elliptical",
    "triangular",
    "oblong"
};

//joystick for changing chocolate box size and shape (these varibales can be changed by user!)
int cellSize = 80;
int rows = 5;
int cols = 5;

// setup intial configurations for creating a chocolate box!
ChocoBox chocolateBox;
void setup() {
    size(800,800); 
    for (int i = 0;i < timers.length;i++) timers[i] = millis(); //O(3)  
    chocolateBox = new ChocoBox(rows,cols,cellSize,flavors,shapes); //O(rows*cols)
}

//here we will use the draw function to just draw the changed cell only instead of drawing all cells!
//O(1); it will remember last cell just to remove the hover effect from last selected cell! 
int lastActiveCell = -1;

void draw() {
    int k = chocolateBox.findActiveCell();
    
    if (k >= 0 && k < chocolateBox.box.length) {
        // Draw the current active cell
        chocolateBox.box[k].drawCell();
        
        if (lastActiveCell >= 0 && lastActiveCell != k) {
            // Only draw the last active cell when a new active cell is found
            chocolateBox.box[lastActiveCell].drawCell();
        }
        
        lastActiveCell = k;
    } else {
        // Cursor is outside the grid, clear the last active cell
        if (lastActiveCell >= 0) {
            chocolateBox.box[lastActiveCell].drawCell();
            lastActiveCell = -1;
        }
    }
}


// handle keypress events of keyboard in O(1) time!
void keyPressed() {
    int k = chocolateBox.findActiveCell();
    if (k >= 0 && k < chocolateBox.box.length) {
        
        //if k is in range of choclate box then thats a valid cell for modification!
        ChocoCell cell = chocolateBox.box[k];
        
        if (key == ' ' && isAllowed("toggle")) cell.switchVisibility();
        //if cell is not visible but active(hovered) then also that active cell should not recieve keyboard changes!
        if (!cell.visible) return;
        //perform the operation in desired cell according to the key pressed!
        switch(key) {
            //next flavor
            case'a':
            if (isAllowed("flavors")) cell.switchFlavor(true);
            break;
            //prev flavor
            case's':
            if (isAllowed("flavors")) cell.switchFlavor(false);
            break;
            //next shape
            case'd':
            if (isAllowed("shapes")) cell.switchShape(true);
            break;
            //prev shape
            case'f':
            if (isAllowed("shapes")) cell.switchShape(false);
            break;
        };
    }
}


//time manager functions
boolean isAllowed(String operationName) {
    switch(operationName) {
        case "flavors":
            return updateTime(0);
            case "shapes":
            return updateTime(1);
            case "toggle":
            return updateTime(2);
    }   
    return false;
}

boolean updateTime(int timerId) {
    int currentTime = millis();
    int lastExecutionTime = timers[timerId];
    int diff = currentTime - lastExecutionTime;
    if (diff > 250) {
        timers[timerId] = currentTime;
        return true;
    }
    return false;
}