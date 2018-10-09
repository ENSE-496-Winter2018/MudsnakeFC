using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebApplication.Models;
using WebApplication.ViewModels;

namespace WebApplication.Controllers
{
    public class UserController : Controller
    {
        // GET: User
        public ActionResult Index()
        {
            if (Session["UserID"] != null)
            {
                return View();
            }
            else
            {
                return RedirectToAction("Login");
            }
        }

        [HttpGet]
        public ActionResult Login()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Login(User userParam)
        {
            using (var context = new ENSE496Entities())
            {
                if (!string.IsNullOrEmpty(userParam.Username) && !string.IsNullOrEmpty(userParam.Hashed_password))
                {
                    var user = context.Users.Where(u => u.Username == userParam.Username).FirstOrDefault();
                    if (user != null)
                    {
                        if (user.Hashed_password == userParam.Hashed_password)
                        {
                            Session["UserID"] = user.Id.ToString();
                            Session["Username"] = user.Username.ToString();
                            return RedirectToAction("Index");
                        }
                    }
                }
                TempData["UserMessage"] = new MessageViewModel() { CssClassName = "alert-danger", Message = "You have entered an invalid username or password. Please try again" };
                return RedirectToAction("Login");
            }
        }
    }
}
    