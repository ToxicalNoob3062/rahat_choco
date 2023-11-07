// will create an instance of chocolate box by making the given grid centered on screen!
class ChocoBox { 
    //the box is nothing but the collection of choco-cell!
    public ChocoCell[] box;
    
    //box measurements
    public int rows;
    public int cols;
    public int cellSize;
    
    //statically shared arrays
    public int[] flavors;
    public String[] shapes;
    
    //constructor function 
    public ChocoBox(int rows , int cols, int cellSize, int[] flavors , String[] shapes) {
        this.rows = rows;
        this.cols = cols;
        this.cellSize = cellSize; 
        this.flavors = flavors;
        this.shapes = shapes;
        this.box = new ChocoCell[this.rows * this.cols]; //linearization of 2D to 1D!
        this.drawBox();
    }
    
    // this function fillthe chocolate box with choco - cells as it is empty intially!
    //TC: O(rows*cols)
    public void drawBox() {
        int gridWidth = this.cols * this.cellSize;
        int gridHeight = this.rows * this.cellSize;
        
        //Calculate the top left corner of the grid
        int startX = (width - gridWidth) / 2;
        int startY = (height - gridHeight) / 2;
        
        for (int i = 0; i < this.rows; i++) {
            for (int j = 0; j < this.cols; j++) {
                // Calculate the position of each choco-cell
                int x = startX + j * this.cellSize;
                int y = startY + i * this.cellSize;
                
                //calculate index inwhich it will be stored of the choco-box!
                int k = i * this.cols + j; //#linearization of 2D to 1D
                
                //fill the index of the chocobox with the choco-cell!
                this.box[k] = new ChocoCell(x,y,80,this.flavors,this.shapes);
            }
        }
    }
    //this will find the active cell inside the chocolate-box which is hovered!
    public int findActiveCell() {
        int gridWidth = this.cols * this.cellSize;
        int gridHeight = this.rows * this.cellSize;
        
        //Calculate the top leftcorner of the grid
        int startX = (width - gridWidth) / 2;
        int startY = (height - gridHeight) / 2;
        
        // Check if the cursor is outside of the grid
        if (mouseX < startX || mouseX >= startX + gridWidth || mouseY < startY || mouseY >= startY + gridHeight) {
            return - 1; // Cursor is outside the grid
        }
        
        // Calculate the grid position (i and j) based on mouseX and mouseY
        int gridX = (mouseX - startX) / this.cellSize;
        int gridY = (mouseY - startY) / this.cellSize;
        
        // Calculate the index k
        int k = gridY * cols + gridX;
        
        return k;
    }
}