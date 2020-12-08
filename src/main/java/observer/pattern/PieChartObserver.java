package observer.pattern;

import observer.CourseRecord;
import observer.LayoutConstants;

import javax.swing.*;
import java.awt.*;
import java.util.ArrayList;
import java.util.Random;
import java.util.Vector;

import static java.lang.Math.abs;

public class PieChartObserver extends JPanel implements Observer  {

    ArrayList<ObserverType> Types = new ArrayList<>();

    /**
     * Creates a BarChartObserver object
     *
     * @param data
     *            a CourseData object to observe
     */
    public PieChartObserver(CourseData data) {
        Types.add(ObserverType.CREATE);
        Types.add(ObserverType.UPDATE);
        Types.add(ObserverType.REMOVE);
        data.attach(this);
        this.courseData = data.getUpdate();

        this.setPreferredSize(
                new Dimension(
                        LayoutConstants.graphWidth + 2 * LayoutConstants.yOffset,
                        LayoutConstants.graphHeight + 2 * LayoutConstants.yOffset)
        );


        this.setBackground(Color.white);
    }

    /**
     * Paint method
     *
     * @param g a Graphics object on which to paint
     */
    public void paint(Graphics g) {
        super.paint(g);
        drawPie((Graphics2D) g, getBounds(), processSlices());
    }

    private Part[] processSlices() {
        Part[] slices = new Part[courseData.size()];
        for (int i = 0; i < courseData.size(); i++){
            CourseRecord record = courseData.elementAt(i);
            int hashCode = abs(record.getName().hashCode());
            Color c = new Color(hashCode%255,(hashCode+100)%255,(hashCode+200)%255,hashCode%255);
            slices[i] = new Part(record.getNumOfStudents(), c);
        }
        return slices;
    }

    /**
     * Informs this observer that the observed CourseData object has changed
     *
     * @param o the observed CourseData object that has changed
     */
    public void update(Observable o) {
        CourseData data = (CourseData) o;
        this.courseData = data.getUpdate();

        this.revalidate();
        this.repaint();
    }

    @Override
    public void update(Object o) {
        CourseRecord record = (CourseRecord) o;

        boolean doContain = false;
        for (CourseRecord courseRecord : courseData)
            if (courseRecord.getName().equals(record.getName())){
                courseRecord.setNumOfStudents(record.getNumOfStudents());
                doContain = true;
            }

        if (!doContain) // We need to add the bar
            courseData.add(record);

        this.revalidate();
        this.repaint();
    }

    @Override
    public ArrayList<ObserverType> getTypes() {
        return Types;
    }

    private Vector<CourseRecord> courseData;


    void drawPie(Graphics2D g, Rectangle area, Part[] slices) {
        double total = 0.0D;
        for (int i = 0; i < slices.length; i++) {
            total += slices[i].value;
        }
        double curValue = 0.0D;
        int startAngle = 0;
        for (int i = 0; i < slices.length; i++) {
            startAngle = (int) (curValue * 360 / total);
            int arcAngle = (int) (slices[i].value * 360 / total);

            g.setColor(slices[i].color);
            g.fillArc(area.x, area.y, area.width, area.height, startAngle, arcAngle);
            curValue += slices[i].value;
        }

    }
}

class Part {
    double value;
    Color color;

    public Part(double value, Color color) {
        this.value = value;
        this.color = color;
    }
}
