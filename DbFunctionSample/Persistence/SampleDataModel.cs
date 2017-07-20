using System.Data.Entity;
using CodeFirstStoreFunctions;
using DbFunctionSample.DbFunctions;
using DbFunctionSample.Entities;

namespace DbFunctionSample.Persistence
{
    public class SampleDataModel : DbContext
    {
        public SampleDataModel()
            : base("name=SampleDataModel")
        {
            Configuration.LazyLoadingEnabled = false;
            Database.SetInitializer<SampleDataModel>(null);
        }

        public virtual DbSet<Person> Persons { get; set; }
        public virtual DbSet<User> Users { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Conventions.Add(new FunctionsConvention("dbo", typeof(UserDbFunction)));

            modelBuilder.Entity<Person>()
                .Property(e => e.FirstName)
                .IsUnicode(false);

            modelBuilder.Entity<Person>()
                .Property(e => e.MiddleName)
                .IsUnicode(false);

            modelBuilder.Entity<Person>()
                .Property(e => e.Surname)
                .IsUnicode(false);

            modelBuilder.Entity<User>()
                .Property(e => e.EmailAddress)
                .IsUnicode(false);

            modelBuilder.Entity<User>()
                .Property(e => e.PasswordHash)
                .IsUnicode(false);
        }
    }
}
