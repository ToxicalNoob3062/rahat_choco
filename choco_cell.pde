//this classis about managing a chcolate box cell and the chocolate inside it
//thats why its choco - cell!
//Every method in this class has time complexity of O(1);
class ChocoCell{ 
    //pysical look of a cell
    public float x;
    public float y;
    public int size;
    
    //properties of chcolate that a cell will contain!
    public int flavorId = 4;
    public int shapeId = 3;
    public boolean visible = false;
    
    //choices(statically shared arrays)
    public int[]flavors;
    public String[] shapes;
    
    //constructor function
    public ChocoCell(float x, float y , int size, int[] flavors , String[] shapes) {
        this.x = x;
        this.y = y;
        this.size = size;
        this.flavors = flavors;
        this.shapes = shapes;
        this.drawCell();
    }
    
    //hepls to draw the choco - cell by help of other methods & functions!
    public void drawCell() {
        
        //set a strong border around the cell
        strokeWeight(3);
        stroke(255,255,255);
        
        //depending on cursor state the cellcolor will be red or black!
        if (this.containsCursor()) fill(color(255,102,102));//cell is selected!
        else fill(color(0,0,0));//unselectedcell!
        
        //draw the cell wih square shape by decided colors, size and cordinates!
        square(this.x,this.y,this.size);
        
        //select chocolate color and shape and put it inside the cell if it has visbility!
        if (this.visible)  this.drawChoco(this.flavors[this.flavorId],this.shapes[this.shapeId]);
    }
    
    //helps to decide wether mouse is insideor not of the cell!
    public boolean containsCursor() {
        if (mouseX > this.x && mouseX < this.x + this.size && mouseY > this.y && mouseY < this.y + this.size) {
            return true;
        }
        else return false;
    }
    //switches shapes on keyboard events
    public void switchShape(boolean next) {
        //next shape
        if (next) {
            this.shapeId = this.shapeId>= this.shapes.length - 1 ? 0 : this.shapeId + 1;
        }
        //prev shape
        else{
            this.shapeId = this.shapeId<= 0 ? this.shapes.length - 1 : this.shapeId - 1;
        }
        this.drawCell();
    }
    
    //switches flavors(colors) on keyboard event
    public void switchFlavor(boolean next) {
        //next flavor
        if (next) {
            this.flavorId = this.flavorId>= this.flavors.length - 1 ? 0 : this.flavorId + 1;
        }
        //prev flavor
        else{
            this.flavorId = this.flavorId <= 0 ? this.flavors.length - 1 : this.flavorId - 1;
        }
        this.drawCell();
    }
    
    //switches visbility on clicking of space bar!
    public void switchVisibility() {
        this.visible = !this.visible;
        this.drawCell();
    }
    
    //takes the flavor and shape and draws the chcolate inside the choco - cell!!
    void drawChoco(int flavor , String shape) {
        int padding = floor(this.size * 0.18); //varibale to set cell offset!(18% of cellSize)
        int halfSize = this.size / 2;
        fill(flavor);
        strokeWeight(2);
        stroke(255,255,255);
        switch(shape) {
            case"round":
            circle(this.x + halfSize, this.y + halfSize,this.size - padding);
            break;
            case"square":
            square(this.x + padding,this.y + padding,this.size - (2 * padding));
            break;
            case"elliptical":
            ellipse(this.x + halfSize, this.y + halfSize, this.size - (padding * 2), this.size - (padding));
            break;
            case"triangular":
            triangle(this.x + halfSize,this.y + padding,this.x + padding,this.y + this.size - padding ,this.x + this.size - padding,this.y + this.size - padding);
            break;
            case"oblong":
            rect(this.x + padding,this.y + (padding / 2),this.size - (2 * padding),this.size - 2 * (padding / 2));
            break;
        }
    }
}
