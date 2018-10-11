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
            using (var context = new ENSE496Entities()) {
                if (Session["UserID"] != null) {

                    var ideas = context.Ideas.Where(x => true).ToList();
                    if(ideas.Count > 0)
                    {
                        foreach(Idea idea in ideas)
                        {
                            idea.User.Username.First();
                        }
                    }
                    return View(ideas);
                }
                else {
                    return RedirectToAction("Login");
                }
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
                            Session["UserType"] = user.Type.ToString();
                            return RedirectToAction("Index");
                        }
                    }
                }
                TempData["UserMessage"] = new MessageViewModel() { CssClassName = "alert-danger", Message = "You have entered an invalid username or password. Please try again" };
                return RedirectToAction("Login");
            }
        }

        public ActionResult Logout()
        {
            Session.Abandon();
            return RedirectToAction("Login");
        }



        public ActionResult Dashboard()
        {
            return View();
        }

        [HttpGet]
        public ActionResult CreateIdea()
        {
            return View();
        }

        [HttpPost]
        public ActionResult CreateIdea(Idea ideaParam)
        {
            using (var context = new ENSE496Entities()) {
                if (Session["UserID"] != null) {
                    if ((String.IsNullOrEmpty(ideaParam.Title)) || (String.IsNullOrEmpty(ideaParam.Description))) {
                        TempData["UserMessage"] = new MessageViewModel() { CssClassName = "alert-danger", Message = "You have left either the title or description empty" };
                        return RedirectToAction("CreateIdea");
                    }
                    else if (ideaParam.Title.Length > 255) {
                        TempData["UserMessage"] = new MessageViewModel() { CssClassName = "alert-danger", Message = "The title must be less than 256 characters" };
                        return RedirectToAction("CreateIdea");
                    }
                    else {
                        Idea newIdea = new Idea();
                        newIdea.Title = ideaParam.Title;
                        newIdea.Description = ideaParam.Title;
                        newIdea.User_id = Convert.ToInt32(Session["UserID"]);
                        newIdea.Status = "Pending";
                        context.Ideas.Add(newIdea);
                        context.SaveChanges();
                        return RedirectToAction("Index");
                    }
                }
                return View();
            }
        }

        public ActionResult MyIdeas()
        {
            using (var context = new ENSE496Entities())
            {
                if (Session["UserID"] != null)
                {
                    int UserID = Convert.ToInt32(Session["UserID"]);
                    var ideas = context.Ideas.Where(x => x.User_id == UserID).ToList();
                    if (ideas.Count > 0)
                    {
                        foreach (Idea idea in ideas)
                        {
                            idea.User.Username.First();
                        }
                    }
                    return View(ideas);
                }
                else
                {
                    return RedirectToAction("Login");
                }
            }
        }

        public ActionResult SubscribedIdeas()
        {
            return View();
        }

        public ActionResult SuccessStories()
        {
            return View();
        }

        public ActionResult DeleteIdea(int id) {
            using (var context = new ENSE496Entities()) {
                context.Ideas.Remove(context.Ideas.Where(x => x.Id == id).FirstOrDefault());
                context.SaveChanges();
                return RedirectToAction("Index");
            }               
        }
    }
}
    