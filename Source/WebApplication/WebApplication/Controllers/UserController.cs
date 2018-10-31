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
                            if (idea.User.Team_id.HasValue)
                                idea.User.Team_id.GetValueOrDefault();
                            else
                                idea.User.Team_id = 0;
                            idea.Subscriptions.Where(x => x.User_id == Convert.ToInt32(Session["UserID"])).FirstOrDefault();
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
                            if (user.Team_id.HasValue)
                                Session["TeamID"] = user.Team_id.Value;
                            else
                                Session["TeamID"] = 0;
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
        public ActionResult EditIdea(int id) {
            using (var context = new ENSE496Entities())
            {
                return View(context.Ideas.Where(x => x.Id == id).First());
            }
        }

        [HttpPost]
        public ActionResult EditIdea(Idea ideaParam) {
            using (var context = new ENSE496Entities()) {
                context.Ideas.Where(x => x.Id == ideaParam.Id).First().Title = ideaParam.Title;
                context.Ideas.Where(x => x.Id == ideaParam.Id).First().Description = ideaParam.Description;
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

        [HttpGet]
        public ActionResult ViewIdea(int id)
        {
            using (var context = new ENSE496Entities())
            {
                var ideaViewModel = new IdeaViewModel();
                ideaViewModel.Idea = context.Ideas.Where(x => x.Id == id).FirstOrDefault();
                ideaViewModel.Comments = context.Comments.Where(x => x.Idea_id == id && x.Active == true).ToList();
                if(ideaViewModel.Comments.Count > 0)
                {
                    foreach(Comment comment in ideaViewModel.Comments)
                    {
                        comment.User.Username.First();
                    }
                }
                ideaViewModel.Likes = context.Likes.Where(x => x.Idea_id == id && x.Active == true).ToList();
                return View(ideaViewModel);
            }
        }

        [HttpPost]
        public ActionResult CreateComment(Comment commentParam)
        {

            using (var context = new ENSE496Entities())
            {
                if (Session["UserID"] != null)
                {
                    //if (String.IsNullOrEmpty(commentParam.Comment1))
                    //{
                    //    TempData["UserMessage"] = new MessageViewModel() { CssClassName = "alert-danger", Message = "You have left the comment empty" };
                    //    return RedirectToAction("CreateIdea");
                    //}
                    //else
                    //{
                        Comment newComment = new Comment();
                        newComment.Idea_id = commentParam.Idea_id;
                        newComment.Comment1 = commentParam.Comment1;
                        newComment.User_id  = Convert.ToInt32(Session["UserID"]);
                        newComment.Submitted_on = DateTime.Now;
                        newComment.Active = true;
                        context.Comments.Add(newComment);
                        context.SaveChanges();
                        return RedirectToAction("ViewIdea", new { id = commentParam.Idea_id });
                    //}
                }
                return View();
            }
        }

        public ActionResult LikeIdea(int idea_id)
        {

            using (var context = new ENSE496Entities())
            {
                if (Session["UserID"] != null)
                {
                    int userId = Convert.ToInt32(Session["UserID"]);
                    if (context.Likes.Where(x => x.User_id == userId && x.Idea_id == idea_id).Any()) //checks if user has any inactive likes already stored in DB
                    {
                        context.Likes.Where(x => x.User_id == userId && x.Idea_id == idea_id).First().Active = true;
                    }
                    else
                    {
                        Like newLike = new Like();
                        newLike.Idea_id = idea_id;
                        newLike.User_id = userId;
                        newLike.Active = true;
                        context.Likes.Add(newLike);
                    }
                    context.SaveChanges();
                    return RedirectToAction("ViewIdea", new { id = idea_id });
                }
                return View();
            }
        }


        public ActionResult UnlikeIdea(int idea_id)
        {

            using (var context = new ENSE496Entities())
            {
                if (Session["UserID"] != null)
                {
                    int userId = Convert.ToInt32(Session["UserID"]);
                    //if (context.Likes.Where(x => x.User_id == Convert.ToInt32(Session["UserID"])).Any()) //checks if user has any inactive likes already stored in DB
                    //{
                    context.Likes.Where(x => x.User_id == userId && x.Idea_id == idea_id).First().Active = false;
                    context.SaveChanges();
                    //}
                    return RedirectToAction("ViewIdea", new { id = idea_id });
                }
                return View();
            }
        }


        public ActionResult PendingIdeas()
        {
            using (var context = new ENSE496Entities())
            {
                string type = Session["UserType"].ToString();
                if ((Session["UserID"] != null))
                {
                    int userId = Convert.ToInt32(Session["UserID"]);
                    int myTeamId;
                    if (context.Users.Where(x => x.Id == userId).First().Team_id.HasValue)
                    {
                        myTeamId = context.Users.Where(x => x.Id == userId).First().Team_id.Value;
                    }
                    else
                        myTeamId = 0; //if user does not have team id assigned
                    if(type == "superapprover")
                    {
                        var ideas = context.Ideas.Where(x => x.Status == "Pending" ).ToList();
                        if (ideas.Count > 0)
                        {
                            foreach (Idea idea in ideas)
                            {
                                idea.User.Username.First();
                            }
                        }
                        return View(ideas);
                    }
                    else if(type == "approver")
                    {
                        var ideas = context.Ideas.Where(x => x.Status == "Pending" && x.User.Team.Id == myTeamId).ToList();
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
                        RedirectToAction("Index");
                }
                else
                {
                    return RedirectToAction("Login");
                }
            }
            return RedirectToAction("Login");
        }


        [HttpGet]
        public ActionResult ApproveIdea(int id)
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
        public ActionResult ApproveIdea(Status_log statusLogParam)
        {
            using (var context = new ENSE496Entities())
            {
                Idea idea = context.Ideas.Where(x => x.Id == statusLogParam.Idea_id).FirstOrDefault();
                Status_log statusLog = new Status_log();
                statusLog.Current_status = "Approved";
                statusLog.Previous_status = idea.Status;
                statusLog.Idea_id = statusLogParam.Idea_id;
                statusLog.User_id = Convert.ToInt32(Session["UserID"]);
                statusLog.Description = statusLogParam.Description;
                context.Ideas.Where(x => x.Id == statusLogParam.Idea_id).FirstOrDefault().Status = "Approved";
                context.Status_log.Add(statusLog);
                context.SaveChanges();
                return RedirectToAction("Index");
            }
        }


        public ActionResult Subscribe(int idea_id)
        {

            using (var context = new ENSE496Entities())
            {
                if (Session["UserID"] != null)
                {
                    int userId = Convert.ToInt32(Session["UserID"]);
                    if (context.Subscriptions.Where(x => x.User_id == userId && x.Idea_id == idea_id).Any()) //checks if user has any inactive likes already stored in DB
                    {
                        context.Subscriptions.Where(x => x.User_id == userId && x.Idea_id == idea_id).First().Active = true;
                    }
                    else
                    {
                        Subscription subscription = new Subscription();
                        subscription.Idea_id = idea_id;
                        subscription.User_id = userId;
                        subscription.Active = true;
                        context.Subscriptions.Add(subscription);
                    }
                    context.SaveChanges();
                    return RedirectToAction("Index");
                }
                return View();
            }
        }

        public ActionResult Unsubscribe(int idea_id)
        {

            using (var context = new ENSE496Entities())
            {
                if (Session["UserID"] != null)
                {
                    int userId = Convert.ToInt32(Session["UserID"]);
                    context.Subscriptions.Where(x => x.User_id == userId && x.Idea_id == idea_id).First().Active = false;
                    context.SaveChanges();
                    return RedirectToAction("Index");
                }
                return View();
            }
        }

        public ActionResult SubscribedIdeas()
        {
            using (var context = new ENSE496Entities())
            {
                if (Session["UserID"] != null)
                {

                    var ideas = context.Ideas.Where(x => true).ToList();
                    if (ideas.Count > 0)
                    {
                        foreach (Idea idea in ideas)
                        {
                            idea.User.Username.First();
                            if (idea.User.Team_id.HasValue)
                                idea.User.Team_id.GetValueOrDefault();
                            else
                                idea.User.Team_id = 0;
                            idea.Subscriptions.Where(x => x.User_id == Convert.ToInt32(Session["UserID"])).FirstOrDefault();
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



    }
}
    