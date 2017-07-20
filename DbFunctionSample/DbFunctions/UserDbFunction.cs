using System;
using System.Data.Entity;

namespace DbFunctionSample.DbFunctions
{
    public class UserDbFunction
    {
        [DbFunction("CodeFirstDatabaseSchema", "fn_UserFullName")]
        public static string FnUserFullName(Guid userId)
        {
            throw new NotSupportedException();
        }

    }
}
