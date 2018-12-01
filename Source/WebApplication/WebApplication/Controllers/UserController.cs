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
                            {
                                idea.User.Team_id.GetValueOrDefault();
                            }
                            else
                            {
                                idea.User.Team_id = 0;
                            }
                            //idea.Subscriptions.Where(x => x.User_id == Convert.ToInt32(Session["UserID"]) && x.Idea_id == idea.Id).FirstOrDefault();
                            idea.Subscriptions.ToList();
                            idea.Comments = context.Comments.Where(x => x.Idea_id == idea.Id && x.Active == true).ToList();
                            if (idea.Comments.Count > 0)
                            {
                                foreach (Comment comment in idea.Comments)
                                {
                                    comment.User.Username.First();
                                }
                            }
                            idea.Likes = context.Likes.Where(x => x.Idea_id == idea.Id && x.Active == true).ToList();
                            if(idea.Likes.Count > 0)
                            {
                                foreach (Like like in idea.Likes)
                                {
                                    like.User.Username.First();
                                }
                            }
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
            if (Session["UserID"] != null)
                return RedirectToAction("Index");
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

                    if(ModelState.IsValid)
                    {
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
                            idea.Subscriptions.ToList();
                            idea.Comments = context.Comments.Where(x => x.Idea_id == idea.Id && x.Active == true).ToList();
                            if (idea.Comments.Count > 0)
                            {
                                foreach (Comment comment in idea.Comments)
                                {
                                    comment.User.Username.First();
                                }
                            }
                            idea.Likes = context.Likes.Where(x => x.Idea_id == idea.Id && x.Active == true).ToList();
                            if (idea.Likes.Count > 0)
                            {
                                foreach (Like like in idea.Likes)
                                {
                                    like.User.Username.First();
                                }
                            }
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

        public ActionResult AddSuccessStories(int idea_id)
        {
            using (var context = new ENSE496Entities())
            {
                if (Session["UserID"] != null)
                {
                    Idea idea = context.Ideas.Where(x => x.Id == idea_id).FirstOrDefault();
                    idea.OnSuccessStories = true;
                    context.SaveChanges();
                    return Redirect(Request.UrlReferrer.ToString());
                }
                else
                {
                    return RedirectToAction("Login");
                }
            }
        }

        public ActionResult RemoveSuccessStories(int idea_id)
        {
            using (var context = new ENSE496Entities())
            {
                if (Session["UserID"] != null)
                {
                    Idea idea = context.Ideas.Where(x => x.Id == idea_id).FirstOrDefault();
                    idea.OnSuccessStories = false;
                    context.SaveChanges();
                    return Redirect(Request.UrlReferrer.ToString());
                }
                else
                {
                    return RedirectToAction("Login");
                }
            }
        }

        public ActionResult SuccessStories()
        {
            using (var context = new ENSE496Entities())
            {
                if (Session["UserID"] != null)
                {
                    string type = Session["UserType"].ToString();
                    int userId = Convert.ToInt32(Session["UserID"]);
                    var successIdeas = context.Ideas.Where(x => x.Status == "Approved").ToList();

                    if(type!="superapprover")
                    {
                        successIdeas = null;
                        successIdeas = context.Ideas.Where(x => x.OnSuccessStories == true).ToList();
                    }

                    if (successIdeas!=null && successIdeas.Count > 0)
                    {
                        foreach (Idea idea in successIdeas)
                        {
                            idea.User.Username.First();
                            if (idea.User.Team_id.HasValue)
                                idea.User.Team_id.GetValueOrDefault();
                            else
                                idea.User.Team_id = 0;
                            idea.Subscriptions.ToList();
                            idea.Comments = context.Comments.Where(x => x.Idea_id == idea.Id && x.Active == true).ToList();
                            if (idea.Comments.Count > 0)
                            {
                                foreach (Comment comment in idea.Comments)
                                {
                                    comment.User.Username.First();
                                }
                            }
                            idea.Likes = context.Likes.Where(x => x.Idea_id == idea.Id && x.Active == true).ToList();
                            if (idea.Likes.Count > 0)
                            {
                                foreach (Like like in idea.Likes)
                                {
                                    like.User.Username.First();
                                }
                            }
                        }
                    }
                    //}
                    return View(successIdeas);
                }
                else
                {
                    return RedirectToAction("Login");
                }

            }
        }

        public ActionResult DeleteIdea(int id) {
            using (var context = new ENSE496Entities()) {
                context.Status_log.RemoveRange(context.Status_log.Where(x => x.Idea_id == id).ToList());
                context.Likes.RemoveRange(context.Likes.Where(x => x.Idea_id == id).ToList());
                context.Comments.RemoveRange(context.Comments.Where(x => x.Idea_id == id).ToList());
                context.Subscriptions.RemoveRange(context.Subscriptions.Where(x => x.Idea_id == id).ToList());
                context.Ideas.Remove(context.Ideas.Where(x => x.Id == id).FirstOrDefault());
                //context.Status_log.Remove(context.Status_log.Where(x => x.Idea_id == id).FirstOrDefault());
                //context.Ideas.Where(x => x.Id == id).FirstOrDefault().Active = false;
                context.SaveChanges();
                return RedirectToAction("Index");
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
                if (ModelState.IsValid)
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

                    if (idea.User_id != statusLog.User_id) //checks to see if status change was made by someone other than who submitted the idea
                    {
                        Notification notification = new Notification();
                        notification.Recipient_id = idea.User_id;
                        notification.Message = Session["Username"].ToString() + " has parked your idea. (Idea #" + statusLog.Idea_id.ToString() + ")";
                        notification.Active = true;
                        context.Notifications.Add(notification);
                    }
                    if (context.Subscriptions.Where(x => x.Idea_id == statusLog.Idea_id).Any())
                    {
                        var subs = context.Subscriptions.Where(x => x.Idea_id == statusLog.Idea_id).ToList();
                        foreach (Subscription sub in subs)
                        {
                            Notification notification = new Notification();
                            notification.Recipient_id = sub.User_id;
                            notification.Message = Session["Username"].ToString() + " has parked an idea you are subscribed to. (Idea #" + statusLog.Idea_id.ToString() + ")";
                            notification.Active = true;
                            context.Notifications.Add(notification);
                        }
                    }
                    context.SaveChanges();
                    return RedirectToAction("Index");
                }
                return View();
            }
        }


        public ActionResult PlanIdea(int id) {
            return View();
        }

        public  ActionResult PlanIdea(Status_log statusLogParam)
        {
            using (var context = new ENSE496Entities())
            {
                if (ModelState.IsValid)
                {
                    Idea idea = context.Ideas.Where(x => x.Id == statusLogParam.Idea_id).FirstOrDefault();
                    Status_log statusLog = new Status_log();
                    statusLog.Current_status = "Planned";
                    statusLog.Previous_status = idea.Status;
                    statusLog.Idea_id = statusLogParam.Idea_id;
                    statusLog.User_id = Convert.ToInt32(Session["UserID"]);
                    statusLog.Description = statusLogParam.Description;
                    context.Ideas.Where(x => x.Id == statusLogParam.Idea_id).FirstOrDefault().Status = "Planned";
                    context.Status_log.Add(statusLog);

                    if (idea.User_id != statusLog.User_id) //checks to see if status change was made by someone other than who submitted the idea
                    {
                        Notification notification = new Notification();
                        notification.Recipient_id = idea.User_id;
                        notification.Message = Session["Username"].ToString() + " has planned your idea. (Idea #" + statusLog.Idea_id.ToString() + ")";
                        notification.Active = true;
                        context.Notifications.Add(notification);
                    }
                    if (context.Subscriptions.Where(x => x.Idea_id == statusLog.Idea_id).Any())
                    {
                        var subs = context.Subscriptions.Where(x => x.Idea_id == statusLog.Idea_id).ToList();
                        foreach (Subscription sub in subs)
                        {
                            Notification notification = new Notification();
                            notification.Recipient_id = sub.User_id;
                            notification.Message = Session["Username"].ToString() + " has planned an idea you are subscribed to. (Idea #" + statusLog.Idea_id.ToString() + ")";
                            notification.Active = true;
                            context.Notifications.Add(notification);
                        }
                    }
                    context.SaveChanges();
                    return RedirectToAction("Index");
                }
                return View();
            }
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
                if(ModelState.IsValid)
                {
                    context.Ideas.Where(x => x.Id == ideaParam.Id).First().Title = ideaParam.Title;
                    context.Ideas.Where(x => x.Id == ideaParam.Id).First().Description = ideaParam.Description;
                    //if (ideaParam.User_id != Convert.ToInt32(Session["UserID"])) //checks to see if edit was made by someone other than who submitted the idea
                    //{
                    //    Notification notification = new Notification();
                    //    notification.Recipient_id = ideaParam.User_id;
                    //    notification.Message = Session["Username"].ToString() + " has edited your idea. (Idea #" + ideaParam.Id.ToString() + ")";
                    //    notification.Active = true;
                    //    context.Notifications.Add(notification);
                    //}
                    //if (context.Subscriptions.Where(x => x.Idea_id == ideaParam.Id).Any())
                    //{
                    //    var subs = context.Subscriptions.Where(x => x.Idea_id == ideaParam.Id).ToList();
                    //    foreach (Subscription sub in subs)
                    //    {
                    //        Notification notification = new Notification();
                    //        notification.Recipient_id = sub.User_id;
                    //        notification.Message = Session["Username"].ToString() + " has edited an idea you are subscribed to. (Idea #" + ideaParam.Id.ToString() + ")";
                    //        notification.Active = true;
                    //        context.Notifications.Add(notification);
                    //    }
                    //}
                    context.SaveChanges();
                    //if (ideaParam.User_id != statusLog.User_id) //checks to see if edit was made by someone other than who submitted the idea
                    //{
                    //    Notification notification = new Notification();
                    //    notification.Recipient_id = idea.User_id;
                    //    notification.Message = Session["Username"].ToString() + " has parked your idea. (Idea #" + statusLog.Idea_id.ToString() + ")";
                    //    notification.Active = true;
                    //    context.Notifications.Add(notification);
                    //}
                    return RedirectToAction("Index");
                }
                return View();
          
            }
        }


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
                if (idea.User_id != statusLog.User_id) //checks to see if status change was made by someone other than who submitted the idea
                {
                    Notification notification = new Notification();
                    notification.Recipient_id = idea.User_id;
                    notification.Message = Session["Username"].ToString() + " has declined your idea. (Idea #" + statusLog.Idea_id.ToString() + ")";
                    notification.Active = true;
                    context.Notifications.Add(notification);
                }
                if (context.Subscriptions.Where(x => x.Idea_id == statusLog.Idea_id).Any())
                {
                    var subs = context.Subscriptions.Where(x => x.Idea_id == statusLog.Idea_id).ToList();
                    foreach (Subscription sub in subs)
                    {
                        Notification notification = new Notification();
                        notification.Recipient_id = sub.User_id;
                        notification.Message = Session["Username"].ToString() + " has declined an idea you are subscribed to. (Idea #" + statusLog.Idea_id.ToString() + ")";
                        notification.Active = true;
                        context.Notifications.Add(notification);
                    }
                }
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
                    if (String.IsNullOrEmpty(commentParam.Comment1))
                    {
                        TempData["UserMessage"] = new MessageViewModel() { CssClassName = "alert-danger", Message = "You cannot leave the comment field empty..." };
                        return RedirectToAction("ViewIdea", new { id = commentParam.Idea_id });
                    }
                    else
                    {
                        Idea idea = context.Ideas.Where(x => x.Id == commentParam.Idea_id).FirstOrDefault();
                        Comment newComment = new Comment();
                        newComment.Idea_id = commentParam.Idea_id;
                        newComment.Comment1 = commentParam.Comment1;
                        newComment.User_id = Convert.ToInt32(Session["UserID"]);
                        newComment.Submitted_on = DateTime.Now;
                        newComment.Active = true;
                        context.Comments.Add(newComment);
                        if (newComment.User_id != idea.User_id) //checks to see if status change was made by someone other than who submitted the idea
                        {
                            Notification notification = new Notification();
                            notification.Recipient_id = idea.User_id;
                            notification.Message = Session["Username"].ToString() + " has commented on your idea. (Idea #" + newComment.Idea_id.ToString() + ")";
                            notification.Active = true;
                            context.Notifications.Add(notification);
                        }
                        if (context.Subscriptions.Where(x => x.Idea_id == commentParam.Idea_id).Any())
                        {
                            var subs = context.Subscriptions.Where(x => x.Idea_id == commentParam.Idea_id).ToList();
                            foreach (Subscription sub in subs)
                            {
                                Notification notification = new Notification();
                                notification.Recipient_id = sub.User_id;
                                notification.Message = Session["Username"].ToString() + " has commented on an idea you are subscribed to. (Idea #" + commentParam.Idea_id.ToString() + ")";
                                notification.Active = true;
                                context.Notifications.Add(notification);
                            }
                        }
                        context.SaveChanges();
                        return RedirectToAction("ViewIdea", new { id = commentParam.Idea_id });
                    }
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
                    return Redirect(Request.UrlReferrer.ToString());
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
                    context.Likes.Where(x => x.User_id == userId && x.Idea_id == idea_id).First().Active = false;
                    context.Likes.RemoveRange(context.Likes.Where(x => x.User_id == userId && x.Idea_id == idea_id).ToList());
                    context.SaveChanges();
                    return Redirect(Request.UrlReferrer.ToString());
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
                                idea.Subscriptions.ToList();
                                idea.Comments = context.Comments.Where(x => x.Idea_id == idea.Id && x.Active == true).ToList();
                                if (idea.Comments.Count > 0)
                                {
                                    foreach (Comment comment in idea.Comments)
                                    {
                                        comment.User.Username.First();
                                    }
                                }
                                idea.Likes = context.Likes.Where(x => x.Idea_id == idea.Id && x.Active == true).ToList();
                                if (idea.Likes.Count > 0)
                                {
                                    foreach (Like like in idea.Likes)
                                    {
                                        like.User.Username.First();
                                    }
                                }
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
                                idea.Subscriptions.ToList();
                                idea.Comments = context.Comments.Where(x => x.Idea_id == idea.Id && x.Active == true).ToList();
                                if (idea.Comments.Count > 0)
                                {
                                    foreach (Comment comment in idea.Comments)
                                    {
                                        comment.User.Username.First();
                                    }
                                }
                                idea.Likes = context.Likes.Where(x => x.Idea_id == idea.Id && x.Active == true).ToList();
                                if (idea.Likes.Count > 0)
                                {
                                    foreach (Like like in idea.Likes)
                                    {
                                        like.User.Username.First();
                                    }
                                }
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
                if (ModelState.IsValid)
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
                    if (idea.User_id != statusLog.User_id) //checks to see if status change was made by someone other than who submitted the idea
                    {
                        Notification notification = new Notification();
                        notification.Recipient_id = idea.User_id;
                        notification.Message = Session["Username"].ToString() + " has approved your idea. (Idea #" + statusLog.Idea_id.ToString() + ")";
                        notification.Active = true;
                        context.Notifications.Add(notification);
                    }
                    if (context.Subscriptions.Where(x => x.Idea_id == statusLog.Idea_id).Any())
                    {
                        var subs = context.Subscriptions.Where(x => x.Idea_id == statusLog.Idea_id).ToList();
                        foreach (Subscription sub in subs)
                        {
                            Notification notification = new Notification();
                            notification.Recipient_id = sub.User_id;
                            notification.Message = Session["Username"].ToString() + " has approved an idea you are subscribed to. (Idea #" + statusLog.Idea_id.ToString() + ")";
                            notification.Active = true;
                            context.Notifications.Add(notification);
                        }
                    }
                    context.SaveChanges();
                    return RedirectToAction("Index");
                }
                return View();
            }
        }


        public ActionResult Subscribe(int idea_id)
        {

            using (var context = new ENSE496Entities())
            {
                if (Session["UserID"] != null)
                {
                    int userId = Convert.ToInt32(Session["UserID"]);
                    //if (context.Subscriptions.Where(x => x.User_id == userId && x.Idea_id == idea_id).Any()) //checks if user has any inactive likes already stored in DB
                    //{
                    //    context.Subscriptions.Where(x => x.User_id == userId && x.Idea_id == idea_id).First().Active = true;
                    //}
                    //else
                    //{
                        Subscription subscription = new Subscription();
                        subscription.Idea_id = idea_id;
                        subscription.User_id = userId;
                        subscription.Active = true;
                        context.Subscriptions.Add(subscription);
                    //}
                    context.SaveChanges();
                    return Redirect(Request.UrlReferrer.ToString());
                }
                return RedirectToAction("Index");
            }
        }

        public ActionResult Unsubscribe(int idea_id)
        {

            using (var context = new ENSE496Entities())
            {
                if (Session["UserID"] != null)
                {
                    int userId = Convert.ToInt32(Session["UserID"]);
                    //var subs = context.Subscriptions.Where(x => x.User_id == userId && x.Idea_id == idea_id).ToList();
                    //context.Subscriptions.Where(x => x.User_id == userId && x.Idea_id == idea_id);
                    context.Subscriptions.RemoveRange(context.Subscriptions.Where(x => x.User_id == userId && x.Idea_id == idea_id).ToList());
                    context.SaveChanges();
                    return Redirect(Request.UrlReferrer.ToString());
                }
                return RedirectToAction("Index");
            }
        }

        public ActionResult SubscribedIdeas()
        {
            using (var context = new ENSE496Entities())
            {
                if (Session["UserID"] != null)
                {
                    //var subbedIdeas = context.Subscriptions.Where(x => x.User_id == Convert.ToInt32(Session["UserID"])).ToList();
                    int userId = Convert.ToInt32(Session["UserID"]);
                    var ideas = context.Ideas.Where(x => x.Subscriptions.Any(y => y.User_id == userId)).ToList();
                    //var ideas = context.Ideas.Where(x => true).ToList();
                    //if (ideas.Count > 0)
                    //{
                    foreach (Idea idea in ideas)
                    {
                        idea.User.Username.First();
                        if (idea.User.Team_id.HasValue)
                            idea.User.Team_id.GetValueOrDefault();
                        else
                            idea.User.Team_id = 0;
                        idea.Subscriptions.ToList();
                        idea.Comments = context.Comments.Where(x => x.Idea_id == idea.Id && x.Active == true).ToList();
                        if (idea.Comments.Count > 0)
                        {
                            foreach (Comment comment in idea.Comments)
                            {
                                comment.User.Username.First();
                            }
                        }
                        idea.Likes = context.Likes.Where(x => x.Idea_id == idea.Id && x.Active == true).ToList();
                        if (idea.Likes.Count > 0)
                        {
                            foreach (Like like in idea.Likes)
                            {
                                like.User.Username.First();
                            }
                        }
                    }
                    //}
                    return View(ideas);
                }
                else
                {
                    return RedirectToAction("Login");
                }
            }
        }

        
        public ActionResult Notifications()
        {
            using (var context = new ENSE496Entities())
            {
                if (Session["UserID"] != null)
                {
                    int userId = Convert.ToInt32(Session["UserID"]);
                    var notifictaions = context.Notifications.Where(x => x.Recipient_id == userId).ToList();
                    //if (ideas.Count > 0)
                    //{
                    //    foreach (Idea idea in ideas)
                    //    {
                    //        idea.User.Username.First();
                    //        if (idea.User.Team_id.HasValue)
                    //        {
                    //            idea.User.Team_id.GetValueOrDefault();
                    //        }
                    //        else
                    //        {
                    //            idea.User.Team_id = 0;
                    //        }
                    //        //idea.Subscriptions.Where(x => x.User_id == Convert.ToInt32(Session["UserID"]) && x.Idea_id == idea.Id).FirstOrDefault();
                    //        idea.Subscriptions.ToList();
                    //    }
                    //}
                    return View(notifictaions);
                }
                else
                {
                    return RedirectToAction("Login");
                }
            }
        }

        public ActionResult GetNotificationCount()
        {
            using (var context = new ENSE496Entities())
            {
                int userId = Convert.ToInt32(Session["UserID"]);
                var count = context.Notifications.Where(x => x.Recipient_id == userId).Count();
                return PartialView(count);
            }
        }

        public ActionResult DismissNotification(int id)
        {
            using (var context = new ENSE496Entities())
            {

                var notification = context.Notifications.Where(x => x.Id == id).FirstOrDefault();
                if(notification !=null)
                {
                    context.Notifications.Remove(notification);
                    context.SaveChanges();
                }
                return RedirectToAction("Notifications");
            }
        }



    }
}
    