advpm__Advologix_Global_Options__c go = advpm__Advologix_Global_Options__c.getOrgDefaults();
go.advpm__Enable_Billings_for_Timekeeping__c = true;
update go;

advpm__AdvoLogix_Billing_Preview_Actions_List__c ap = new advpm__AdvoLogix_Billing_Preview_Actions_List__c();
ap.advpm__Action_Code__c = 'selecteddata';
ap.Name = 'Send to Accounting Seed';
ap.advpm__Order__c = 2;
insert ap;

Account ac = new Account(Name='ACME');
insert ac;

advpm__Matter__c m = new advpm__Matter__c(advpm__Primary_Account__c=ac.Id, Name='Acme Matter');
insert m;

advpm__Timekeeper__c tk = new advpm__Timekeeper__c(Name='John Doe', advpm__Staff__c=UserInfo.getUserId());
insert tk;

advpm__Time__c t = new advpm__Time__c(advpm__Matter__c=m.Id, advpm__Timekeeper__c=tk.Id, advpm__Time_In_Hours__c=10, advpm__Rate_Amount__c=150, advpm__Entry_Date__c=Date.today().addDays(-4), advpm__Billing_Disposition__c='Bill');
insert t;

advpm__Expense__c e = new advpm__Expense__c(advpm__Matter__c=m.Id, advpm__Incurred_By__c=tk.Id, advpm__Expense_Amount__c=100, advpm__Expense_Date__c=Date.today().addDays(-2), advpm__Billing_Disposition__c='Bill');
insert e;