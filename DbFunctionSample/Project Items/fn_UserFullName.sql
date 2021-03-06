ALTER function [dbo].[fn_UserFullName] (@userid uniqueidentifier) 
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

