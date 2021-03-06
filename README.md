How to use SQL scalar-valued functions in LINQ to Entities queries:

1.Create a custom function in your database

 Example:

	create function [dbo].[fn_UserFullName] (@userid uniqueidentifier) 
	returns varchar(210)
	as 
	begin
		declare @fullname varchar(210)
	
		select	@fullname = case when (p.MiddleName is null) or (p.MiddleName = '') 
							then p.FirstName + ' ' + p.Surname 
							else p.FirstName + ' ' + p.MiddleName + ' ' + p.Surname 
							end
		from Users u
		inner join Persons p on u.Personid = p.Personid
		where	u.Userid = @userid	
	
		return (@fullname);
	end;

2. Install EntityFramework.CodeFirstStoreFunctions nuget package

    Nuget: https://www.nuget.org/packages/EntityFramework.CodeFirstStoreFunctions/ 
    Source code and example: https://codefirstfunctions.codeplex.com/ 

3. Create your mapped-to function using DbFunctionAttribute with the hard coded schema name CodeFirstDatabaseSchema 

Example:

	public class UserDbFunction
	{
		[DbFunction("CodeFirstDatabaseSchema", "fn_UserFullName")]
		public static string FnUserFullName(Guid userId)
		{
			throw new NotSupportedException();
		}
	}

4. Override the OnModelCreating method and add the custom convention into Conventions configuration.

Example:

	protected override void OnModelCreating(DbModelBuilder modelBuilder)
	{
		modelBuilder.Conventions.Add(new FunctionsConvention("dbo", typeof(UserDbFunction)));

		//...
	}

5. Call the custom function.

Example:

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

Output:

	Top 3 users:
	Email Address: Sean.Landlord@example.com - Full Name: Sean Paul
	Email Address: barbara.tenant@example.com - Full Name: Barbara Santa
	Email Address: charmaine.delegate@example.com - Full Name: Charmaine Sheh

	'Barbara Santa' email address: barbara.tenant@example.com
