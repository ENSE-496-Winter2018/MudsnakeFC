using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;

namespace WebApplication.Models
{
    public class CommentMetaData
    {
        [Required(ErrorMessage = "Please enter a comment")]
        public string Comment1;

    }
}