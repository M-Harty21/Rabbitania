﻿using System.Collections;
using System.Collections.Generic;
using System.Net;
using backend_api.Exceptions.Forum;
using backend_api.Models.Forum.Requests;

namespace backend_api.Models.Forum.Responses
{
    public class RetrieveForumThreadsResponse
    {
        private IEnumerable<ForumThreads> _forumThreads;
        private HttpStatusCode _code;
        
        public RetrieveForumThreadsResponse(IEnumerable<ForumThreads> threads, HttpStatusCode code)
        {
            this._forumThreads = threads;
            _code = code;
        }

        public RetrieveForumThreadsResponse(HttpStatusCode code)
        {
            _code = code;
        }

        public IEnumerable<ForumThreads> ForumThreads
        {
            get => _forumThreads;
            set => _forumThreads = value;
        }
        
        public HttpStatusCode Code
        {
            get => _code;
            set => _code = value;
        }
    }
}