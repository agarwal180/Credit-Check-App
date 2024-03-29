({

saveRecord : function(component, event, helper) {
    var action = component.get("c.createCase");
    action.setParams({
        accid : component.get("v.recordId"),
        subject : component.get("v.Subject"),
        CreditCheckStatus : component.get("v.CreditCheckStatus")}
                    );
    action.setCallback(this, function(response){
        var state = response.getState();
        if(state == "SUCCESS"){
            var toastRef = $A.get("e.force:showToast");
            if(response.getReturnValue() == null){
                toastRef.setParams({
                    "type" : "Success",
                    "title" : "Success",
                    "message" : "New Case is Created.",
                    "mode" : "dismissible"
                });
            }
            else{
                toastRef.setParams({
                    "type" : "Error",
                    "title" : "Error",
                    "message" : response.getReturnValue(),
                    "mode" : "sticky"
                }); 
            }
            toastRef.fire();
            
            $A.get("e.force:refreshView").fire();
            var dismissActionPanel = $A.get("e.force:closeQuickAction");
            dismissActionPanel.fire();

        }
        else{
            console.log('Error during saving '+state);
        }
        
    });  
    $A.enqueueAction(action);
}
})

