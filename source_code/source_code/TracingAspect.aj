
public aspect TracingAspect {

	private String signature = "";
	private String[] arr;
	private String currentClass = "ObserverTest";
	private String previousClass = "";
	private String targetClass = "";
	private String method = "";
	private String returnType = "";
	private int obs = 0;

	
	
	pointcut whatIDontWant() :  within(TracingAspect) ||
								call(* java..*.*(..)) ||
								/*call(* *.notifyObservers(..)) ||*/
								call(* *.setUp(..)) ||
								call(* *.tearDown(..));
								
	
	pointcut whatIWant()     : call(* *.*(..));
	pointcut allIWant()      : whatIWant() && !whatIDontWant();
	

	before() : initialization(*.new(..)) && within(TheEconomy) {
		String className = thisJoinPointStaticPart.getSignature().toString();
		className = className.split("\\(")[0];
		ObserverTest.finalString = ObserverTest.finalString + "@found '" + currentClass + "',->%0A";
		ObserverTest.finalString = ObserverTest.finalString + "  @create '" + className + "',%0A";
	}
	
	before() : initialization(*.new(..)) && within(Optimist) {
		String className = thisJoinPointStaticPart.getSignature().toString();
		className = className.split("\\(")[0];
		ObserverTest.finalString = ObserverTest.finalString + "@found '" + currentClass + "',->%0A";
		ObserverTest.finalString = ObserverTest.finalString + "  @create '" + className + "',%0A";     
	}
	
	before() : initialization(*.new(..)) && within(Pessimist) {
		String className = thisJoinPointStaticPart.getSignature().toString();
		className = className.split("\\(")[0];
		ObserverTest.finalString = ObserverTest.finalString + "@found '" + currentClass + "',->%0A";
		ObserverTest.finalString = ObserverTest.finalString +	"  @create '" + className + "',%0A";     
	}
	  
	before() : allIWant() {
		signature = thisJoinPoint.getSignature().toString();
		currentClass = thisJoinPoint.getThis().getClass().getName();
		arr = signature.split("[\\s\\.]+");
		returnType = arr[0];
		targetClass = arr[1];
		method = arr[2];
		method = method + ":" + returnType;
		
		if(currentClass.equals("ConcreteSubject")) currentClass = "TheEconomy";
		if(targetClass.equals("ConcreteSubject")) targetClass = "TheEconomy";
		if(targetClass.equals("Observer")) {
			if(obs == 1){
				targetClass = "Optimist";
				obs = 0;
			}else{
				targetClass = "Pessimist";
				obs = 1;
			}
		}
		
		
		if(!currentClass.equals(previousClass)){
			ObserverTest.finalString = ObserverTest.finalString + "@found '" + currentClass + "',->%0A";
		}
		
		ObserverTest.finalString = ObserverTest.finalString + "  @message '" + method + "', '" + targetClass +"',->%0A";
		previousClass = currentClass;
	}	
}