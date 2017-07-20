using System;
using System.ComponentModel.DataAnnotations;

namespace DbFunctionSample.Entities
{
    public class User
    {
        public Guid Userid { get; set; }

        public Guid Personid { get; set; }

        [Required]
        [StringLength(100)]
        public string EmailAddress { get; set; }

        [Required]
        public string PasswordHash { get; set; }

        public virtual Person Person { get; set; }
    }
}
