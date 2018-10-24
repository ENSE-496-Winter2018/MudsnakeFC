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
                        newIdea.Description = ideaParam.Description;
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
                context.Status_log.Remove(context.Status_log.Where(x => x.Idea_id == id).FirstOrDefault());
                context.SaveChanges();
                return RedirectToAction("MyIdeas");
            }               
        }

        [HttpGet]
        public ActionResult ParkIdea(int id)
        {
            using (var context = new ENSE496Entities())
            {
                Idea idea = context.Ideas.Where(x => x.Id == id).FirstOrDefault();
                Status_log statusLog = new Status_log();
                statusLog.Idea_id = id;
                return View(statusLog);
            }
        }

        [HttpPost]
        public ActionResult ParkIdea(Status_log statusLogParam)
        {
            using (var context = new ENSE496Entities())
            {
                Idea idea = context.Ideas.Where(x => x.Id == statusLogParam.Idea_id).FirstOrDefault();
                Status_log statusLog = new Status_log();
                statusLog.Current_status = "Parked";
                statusLog.Previous_status = idea.Status;
                statusLog.Idea_id = statusLogParam.Idea_id;
                statusLog.User_id = Convert.ToInt32(Session["UserID"]);
                statusLog.Description = statusLogParam.Description;
                context.Ideas.Where(x => x.Id == statusLogParam.Idea_id).FirstOrDefault().Status = "Parked";
                context.Status_log.Add(statusLog);
                context.SaveChanges();
                return RedirectToAction("Index");
            }
        }

        //zains code
        //public ActionResult ParkIdea(int id) {
        //    using (var context = new ENSE496Entities()) {
        //        context.Ideas.Where(x => x.Id == id).FirstOrDefault().Status = "Parked";
        //        context.SaveChanges();
        //        return RedirectToAction("Index");
        //    }
        //}

        public ActionResult PlanIdea(int id) {
            return View();
        }

        [HttpGet]
        public ActionResult EditIdea() {
            return View();
        }

        [HttpPost]
        public ActionResult EditIdea(Idea ideaParam) {
            using (var context = new ENSE496Entities()) {
            /****Need the Id to change the correct record in the db*/ 
                //context.Ideas.Where(x => x.Id == ideaParam.Id).FirstOrDefault().Status = "Pending";
                //context.Ideas.Where(x => x.Id == ideaParam.Id).FirstOrDefault().Title = ideaParam.Title;
                //context.Ideas.Where(x => x.Id == ideaParam.Id).FirstOrDefault().Description  = ideaParam.Description;
            //****
                context.SaveChanges();
                return RedirectToAction("Index");
            }
        }

        // zains code
        //public ActionResult DeclineIdea(int id) {
        //    using (var context = new ENSE496Entities()) {
        //        context.Ideas.Where(x => x.Id == id).FirstOrDefault().Status = "Declined";
        //        context.SaveChanges();
        //        return RedirectToAction("Index");
        //    }
        //}

        [HttpGet]
        public ActionResult DeclineIdea(int id)
        {
            using (var context = new ENSE496Entities())
            {
                Idea idea = context.Ideas.Where(x => x.Id == id).FirstOrDefault();
                Status_log statusLog = new Status_log();
                statusLog.Idea_id = id;
                return View(statusLog);
            }
        }

        [HttpPost]
        public ActionResult DeclineIdea(Status_log statusLogParam)
        {
            using (var context = new ENSE496Entities())
            {
                Idea idea = context.Ideas.Where(x => x.Id == statusLogParam.Idea_id).FirstOrDefault();
                Status_log statusLog = new Status_log();
                statusLog.Current_status = "Declined";
                statusLog.Previous_status = idea.Status;
                statusLog.Idea_id = statusLogParam.Idea_id;
                statusLog.User_id = Convert.ToInt32(Session["UserID"]);
                statusLog.Description = statusLogParam.Description;
                context.Ideas.Where(x => x.Id == statusLogParam.Idea_id).FirstOrDefault().Status = "Declined";
                context.Status_log.Add(statusLog);
                context.SaveChanges();
                return RedirectToAction("Index");
            }
        }
    }
}
    