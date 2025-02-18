﻿using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using backend_api.Models.User;

namespace backend_api.Models.Forum
{
    public class Forums : IForum
    {
        public Forums(string forumTitle, int userId, DateTime CreatedDate)
        {
            this.ForumTitle = forumTitle;
            this.UserId = userId;
            this.CreatedDate = CreatedDate;
        }

        public Forums()
        {
            
        }
        
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int ForumId { get; set; }
        
        public string ForumTitle { get; set; }
        
        public DateTime CreatedDate { get; set; }
        
        public int UserId { get; set; }
        public Users User { get; set; }

        
    }
}