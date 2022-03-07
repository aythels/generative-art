import java.util.Random;

LineModelManager manager = null;
boolean done = false;
int frameCount = 0;

void setup() {
    size(1080, 1080);
    manager = new LineModelManager();

    manager.create(parseInt(1080/2) + 1, parseInt(1080/2), 'E');
    manager.create(parseInt(1080/2), parseInt(1080/2), 'W');
}
  
void draw() {
    background(0);
    manager.update();
    manager.render();

    if (!manager.doneRendering()) { 
        println("saving");
        saveFrame("new/" + frameCount + ".jpg"); //STOP WHEN ALL LINES ARE DISABLED AND DONE
    }
    frameCount += 1;
}

public class LineModelManager {
    private ArrayList<LineModel> rowLineModels = new ArrayList<LineModel>();
    private ArrayList<LineModel> colLineModels = new ArrayList<LineModel>();
    
    public boolean doneRendering() {
        if (!done) return false;
        for (LineModel l : rowLineModels) if (!l.disable && l.length != 0) return false;
        for (LineModel l : colLineModels) if (!l.disable && l.length != 0) return false;

        println("done rendering");
        return true;
    }

    public LineModel create(int x, int y, char dir) {

        // creation limit
        if (done) return null;
        if ((colLineModels.size() + rowLineModels.size()) > 5000) {
          done = true;
        }

        LineModel newLine = new LineModel(x, y, dir);

        if (dir == 'N' || dir == 'S') colLineModels.add(newLine);
        else if (dir == 'W' || dir == 'E') rowLineModels.add(newLine);

        return newLine;
    }

    public void delete(LineModel lineModel) {
        if (lineModel.dir == 'W' || lineModel.dir == 'E') {
            rowLineModels.remove(lineModel);
        } else if (lineModel.dir == 'N' || lineModel.dir == 'S'){
            colLineModels.remove(lineModel);
        }
    }

    public void update() {
        for (int i = 0; i < rowLineModels.size(); i++) {
            LineModel line = rowLineModels.get(i);

            // delete the line if it is stuck                   //TODO FIX THIS
            if (line.disable && line.length == 0) { 
                this.delete(line);
                continue;
            }

            // don't update disabled lines
            if (line.disable) continue;
            
            // disable line updating if it intersects
            if (line.intersects(colLineModels)) {
                line.disable = true;
                continue;
            }

            // disable line updating if it is out of page
            if (!this.isInPage(line)) {
                line.disable = true;
                continue;
            }
        
            line.update();    
        }

        for (int i = 0; i < colLineModels.size(); i++) {
            LineModel line = colLineModels.get(i);

            // delete the line if it is stuck
            if (line.disable && line.length == 0) {
                this.delete(line);
                continue;
            }

            // don't update disabled lines
            if (line.disable) continue;

            // disable line updating if it intersects
            if (line.intersects(rowLineModels)) {
                line.disable = true;
                continue;
            }

            // disable line updating if it is out of page
            if (!this.isInPage(line)) {
                line.disable = true;
                continue;
            }
        
            line.update();    
        }

    }
    
    public void render() {
      
        for (LineModel l : rowLineModels) l.render();
        for (LineModel l : colLineModels) l.render();
    }

    public void switchRandom(LineModel lineModel) {
        // TODO FIX

        char choices[] = new char[2];
        if (lineModel.dir == 'N' || lineModel.dir == 'S') { 
          choices[0] = 'W';
          choices[1] = 'E';
        } else if (lineModel.dir == 'W' || lineModel.dir == 'E') {
          choices[0] = 'N';
          choices[1] = 'S';
        }
        
        
        char newDir = choices[new Random().nextInt(choices.length)];

        PVector point = this.getInternalPoint(lineModel);

        int xDiff = 0;
        int yDiff = 0;
        
        if (newDir == 'N')      yDiff -= 1;
        else if (newDir == 'S') yDiff += 1;
        else if (newDir == 'W') xDiff -= 1;
        else if (newDir == 'E') xDiff += 1;

        // create the new line
        LineModel newLine = this.create((int) point.x + xDiff, (int) point.y + yDiff, newDir);
        if (newLine != null) newLine.recursion = lineModel.recursion + 1;
    }

    public PVector getInternalPoint(LineModel lineModel) {
        PVector endPoint = lineModel.getEndPoint(lineModel.length);

        if (lineModel.dir == 'N' || lineModel.dir == 'S') {
            int min = (int) Math.min(lineModel.y, endPoint.y);
            int max = (int) Math.max(lineModel.y, endPoint.y);

            return new PVector(lineModel.x, getRandomNumberInRange(min, max));
        } else if (lineModel.dir == 'W' || lineModel.dir == 'E') {
            int min = (int) Math.min(lineModel.x, endPoint.x);
            int max = (int) Math.max(lineModel.x, endPoint.x);

            return new PVector(getRandomNumberInRange(min, max), lineModel.y);
        }
        
        return null;

    }

    public boolean isInPage (LineModel lineModel) {
        PVector endPoint = lineModel.getEndPoint(lineModel.length);
        if (lineModel.x >= 0 && endPoint.x <= 1080 && 
            lineModel.y >= 0 && lineModel.y <= 1080)
            return true;

        return false;
    }
}

public class LineModel {
    public int x;
    public int y;
    public char dir;
    public int length = 0;

    public boolean disable = false;

    public int recursion = 0;
    public int maxRecursion = 4 + getRandomNumberInRange(0, 1);   //removing the random means dominance in one direction

    public int  counter = 0;
    public int maxCounter = 100;

    public LineModel(int x, int y, char dir) {
        this.x = x;
        this.y = y;
        this.dir = dir;
    }

    public void render() {

        // Recurse new line
        if (this.recursion < maxRecursion) {
            if (counter >= maxCounter) {
                counter = 0;
                manager.switchRandom(this); 
            }
            counter += 1;
        }

        stroke(255);
        strokeWeight(1);

        PVector endPoint = this.getEndPoint(this.length);
        line(this.x, this.y, endPoint.x, endPoint.y);
    }

    public void update() {
        this.length += 1;
    }

    // UTILITY

    public boolean intersects (ArrayList<LineModel> allLineModels) {
        // TODO CHECK IF ON TOP

        PVector endPoint = this.getEndPoint(this.length);
        PVector endPointNext = this.getEndPoint(this.length + 1);

        if (this.dir == 'N' || this.dir == 'S') {
            for (int i = 0; i < allLineModels.size(); i++) {
                LineModel checkLine = allLineModels.get(i);
                PVector checkLineEndPoint = checkLine.getEndPoint(checkLine.length);
                
                if (endPointNext.y == checkLine.y || endPoint.y == checkLine.y) {

                    int min = (int) Math.min(checkLine.x, checkLineEndPoint.x);
                    int max = (int) Math.max(checkLine.x, checkLineEndPoint.x);
        
                    if (this.x >= min && this.x <= max) return true;

                }
            }

        } else if (this.dir == 'W' || this.dir == 'E') {
            for (int i = 0; i < allLineModels.size(); i++) {
                LineModel checkLine = allLineModels.get(i);
                PVector checkLineEndPoint = checkLine.getEndPoint(checkLine.length);

                if (endPointNext.x == checkLine.x || endPoint.x == checkLine.x) {

                    int min = (int) Math.min(checkLine.y, checkLineEndPoint.y);
                    int max = (int) Math.max(checkLine.y, checkLineEndPoint.y);
        
                    if (this.y >= min && this.y <= max) return true;
            
                }
            }
        }

        return false;
    }

    public PVector getEndPoint(int length) {
        if (this.dir == 'N')      return new PVector(this.x, this.y - length);
        else if (this.dir == 'S') return new PVector(this.x, this.y + length);
        else if (this.dir == 'W') return new PVector(this.x - length, this.y);
        else if (this.dir == 'E') return new PVector(this.x + length, this.y);
        
        return null;
    }
}

int getRandomNumberInRange(int min, int max) {
    max = max + 1;
    
    if (min >= max) {
      throw new IllegalArgumentException("max must be greater than min");
    }

    Random r = new Random();
    return r.nextInt((max - min) + 1) + min;
}
