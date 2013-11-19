using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel.Activation;


// NOTE: If you change the class name "Service" here, you must also update the reference to "Service" in Web.config and in the associated .svc file.
[AspNetCompatibilityRequirements(RequirementsMode = AspNetCompatibilityRequirementsMode.Allowed)]
public class Service : IService
{
    public string GetData(int value)
    {
        return string.Format("You entered: {0}", value);
    }


    public string[] GetUser(string Id)
    { return new User().GetUser(Convert.ToInt32(Id)); }
}



public class User
{

    Dictionary<int, string> users = null;
    public User()
    {
        users = new Dictionary<int, string>();
        users.Add(1, "pranay");
        users.Add(2, "Krunal");
        users.Add(3, "Aditya");
        users.Add(4, "Samir");
    }

    public string[] GetUser(int Id)
    {
        var user = from u in users
                   where u.Key == Id
                   select u.Value;

        return user.ToArray<string>();
    }

}