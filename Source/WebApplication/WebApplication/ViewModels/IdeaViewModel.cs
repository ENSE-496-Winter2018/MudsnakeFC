using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using WebApplication.Models;

namespace WebApplication.ViewModels
{
    public class IdeaViewModel
    {
        [Key]
        public int Id { get; set; }
        public Idea Idea { get; set; }
        public List<Comment> Comments {get; set;}
        public List<Like> Likes { get; set; }
    }
}