using System;
using System.Linq;
using DbFunctionSample.DbFunctions;
using DbFunctionSample.Persistence;

namespace DbFunctionSample
{
    internal class Program
    {
        private static void Main(string[] args)
        {
            var dbContext = new SampleDataModel();

            //EXAMPLE 1: use sql scalar user defined function in projection 
            var userProfiles = dbContext.Users.Select(x => new {EmailAddress = x.EmailAddress, FullName = UserDbFunction.FnUserFullName(x.Userid)}).Take(3).ToList();

            Console.WriteLine("Top 3 users:");
            foreach (var userProfile in userProfiles)
            {
                Console.WriteLine($"Email Address: {userProfile.EmailAddress} - Full Name: {userProfile.FullName}");
            }

            //EXAMPLE 2: use sql scalar user defined function in restriction (where clause)
            //Find 'Barbara Santa' email address
            var user = dbContext.Users.FirstOrDefault(x => UserDbFunction.FnUserFullName(x.Userid).Equals("Barbara Santa", StringComparison.OrdinalIgnoreCase));
            Console.WriteLine(Environment.NewLine + $"'Barbara Santa' email address: {user?.EmailAddress}");

            Console.ReadLine();
        }
    }
}
