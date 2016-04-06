import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.net.URL;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

/**
 * The test class ObserverTest.
 *
 * @author  (your name)
 * @version (a version number or a date)
 */
public class ObserverTest
{
    /**
     * Default constructor for test class ObserverTest
     */
	
	public static String finalString = null;

	
    public ObserverTest()
    {
    }

    /**
     * Sets up the test fixture.
     *
     * Called before every test case method.
     */
    @Before
    public void setUp()
    {
    	finalString = "";
    }

    /**
     * Tears down the test fixture.
     *
     * Called after every test case method.
     */
    @After
    public void tearDown() throws UnsupportedEncodingException
    {
    	URL url;
    	try {
    		finalString = finalString.replace(" ", "%20");
			url = new URL("https://jumly.herokuapp.com/api/diagrams?data=" + finalString);
			InputStream in = new BufferedInputStream(url.openStream());
			 ByteArrayOutputStream out = new ByteArrayOutputStream();
			 byte[] buf = new byte[1024];
			 int n = 0;
			 while (-1!=(n=in.read(buf)))
			 {
			    out.write(buf, 0, n);
			 }
			 out.close();
			 in.close();
			 byte[] response = out.toByteArray();

			 FileOutputStream fos = new FileOutputStream("./sequence_diagram.png");
			 fos.write(response);
			 fos.close();
			 System.out.println("File created.");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	
    	
    	
		 

    }


	@Test
    public void test1()
    {
        TheEconomy s = new TheEconomy();
        Pessimist p = new Pessimist(s);
        Optimist o = new Optimist(s);
        s.attach(p);
        s.attach(o);
        s.setState("The New iPad is out today");
        s.setState("Hey, Its Friday!");
        p.showState();
        o.showState();
    }
}

