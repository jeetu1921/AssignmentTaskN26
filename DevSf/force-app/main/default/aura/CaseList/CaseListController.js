({
	doInit : function(component, event, helper) {
        //Step1: This method will get method from Apex class
		var action = component.get('c.getCaseList');
        //Step2: setParam is use to set the parameter into apex class
        action.setParams({
            ids:component.get('v.recordId'),
        }); 
        action.setCallback (this,function(response){
            var responseValue = response.getReturnValue();
            console.log('responseValue',responseValue);
            component.set('v.caseList',responseValue);
        });
        //Step3: This will 
        $A.enqueueAction(action,false);
	},
    doRedirect: function(component, event, helper) {
        var eventSource = event.getSource();
        var id = eventSource.get('v.name');
        var navEvt = $A.get("e.force:navigateToSObject");
            navEvt.setParams({
              "recordId": id,
              "slideDevName": "detail"
            });
            navEvt.fire();
    },
})