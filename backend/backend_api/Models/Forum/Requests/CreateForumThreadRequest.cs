﻿using System;

namespace backend_api.Models.Forum.Requests
{
    public class CreateForumThreadRequest
    {
        
        private int _forumThreadId;
        private string _forumThreadTitle;
        private string _forumThreadBody;
        private DateTime _createdDate;
        private string _imageUrl;
        private int _userId;
        private int _forumId;

        public CreateForumThreadRequest(int forumThreadId, string forumThreadTitle, string forumThreadBody, DateTime createdDate, string imageUrl,
            int userId, int forumId)
        {
            _forumThreadId = forumThreadId;
            _forumThreadTitle = forumThreadTitle;
            _forumThreadBody = forumThreadBody;
            _createdDate = createdDate;
            _imageUrl = imageUrl;
            _userId = userId;
            _forumId = forumId;
        }
        
        public CreateForumThreadRequest( string forumThreadTitle, string forumThreadBody, DateTime createdDate, string imageUrl,
            int userId, int forumId)
        {
            _forumThreadTitle = forumThreadTitle;
            _forumThreadBody = forumThreadBody;
            _createdDate = createdDate;
            _imageUrl = imageUrl;
            _userId = userId;
            _forumId = forumId;
        }


        public CreateForumThreadRequest()
        {
            
        }
        public int ForumThreadId
        {
            get => _forumThreadId;
            set => _forumThreadId = value;
        }

        public string ForumThreadTitle
        {
            get => _forumThreadTitle;
            set => _forumThreadTitle = value;
        }

        public string ForumThreadBody
        {
            get => _forumThreadBody;
            set => _forumThreadBody = value;
        }

        public DateTime CreatedDate
        {
            get => _createdDate;
            set => _createdDate = value;
        }

        public string ImageUrl
        {
            get => _imageUrl;
            set => _imageUrl = value;
        }

        public int UserId
        {
            get => _userId;
            set => _userId = value;
        }

        public int ForumId
        {
            get => _forumId;
            set => _forumId = value;
        }


        
        
    }
}