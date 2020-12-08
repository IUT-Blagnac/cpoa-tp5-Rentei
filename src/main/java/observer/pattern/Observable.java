package observer.pattern;

import java.util.Vector;

/**
 * An abstract class for all Observable subjects
 */
public abstract class Observable {

	/**
	 * Constructs an Observable object
	 */
	public Observable() {
		this.observers = new Vector<Observer>();
	}

	/**
	 * Attach to this Subject
	 * 
	 * @param o the Observer that wishes to attach
	 */
	public void attach(Observer o) {
		this.observers.addElement(o);
	}

	/**
	 * Detach from this Subject
	 * 
	 * @param o
	 *            the Observer that wishes to detach
	 */
	public void detach(Observer o) {
		for (int i = 0; i < observers.size(); i++) {
			if (observers.elementAt(i).equals(o))
				observers.removeElementAt(i);
		}
	}
	

	/**
	 * Notify all Observers that Subject has changed
	 */
	public void notifyObservers() {
		for (int i = 0; i < observers.size(); i++) {
			Observer observer = observers.elementAt(i);
			observer.update(this);
		}
	}

	/**
	 * Notify all Observers that Subject has changed
	 */
	public void notifyObservers(Object param) {
		for (int i = 0; i < observers.size(); i++) {
			Observer observer = observers.elementAt(i);
			observer.update(param);
		}
	}

	/**
	 * Notify all Observers that Subject has changed
	 */
	public void notifyObservers(Object param, Observer.ObserverType type) {
		for (int i = 0; i < observers.size(); i++) {
			Observer observer = observers.elementAt(i);
			if (observer.getTypes().contains(type))
				observer.update(param);
		}
	}


	/**
	 * Pull updated data from this Subject
	 * 
	 * @return the updated data from the Subject
	 */
	public abstract Object getUpdate();

	protected Vector<Observer> observers;
}