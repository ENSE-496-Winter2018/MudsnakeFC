using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebApplication.Models;
namespace WebApplication.Controllers
{
    public class UserController : Controller
    {
        // GET: User
        public ActionResult Index()
        {
            return View();
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
                var user = context.Users.Where(u => u.Username == userParam.Username).FirstOrDefault();
                if (user.Hashed_password == userParam.Hashed_password)
                    return RedirectToAction("Index");
                else
                    return RedirectToAction("Index");
            }
        }
    }
}
    