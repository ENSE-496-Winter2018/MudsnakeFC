using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;

namespace WebApplication.Models
{
    public class IdeaMetaData
    {
        [Required(ErrorMessage ="Please enter a title")]
        public string Title;

        [Required(ErrorMessage = "Please enter a description")]
        public string Description;
    }
}