package observer.pattern;

import java.util.ArrayList;

/**
 * An interface for all Observers
 */
public interface Observer {

	/**
	 * Informs this observer that an observed subject has changed
	 * 
	 * @param o the observed subject that has changed
	 */
	public void update(Observable o);

	/**
	 * Informs this observer that an observed subject has changed
	 *
	 * @param o the data subject that has changed
	 */
	public void update(Object o);

	public ArrayList<ObserverType> getTypes();

	enum ObserverType{
		CREATE, UPDATE, REMOVE
	}

}
