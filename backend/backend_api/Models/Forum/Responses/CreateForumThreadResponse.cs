﻿using System.Net;
using backend_api.Exceptions.Forum;

namespace backend_api.Models.Forum.Responses
{
    public class CreateForumThreadResponse
    {
        private HttpStatusCode _response;

        public HttpStatusCode Response
        {
            get => _response;
            set => _response = value;
        }

        public CreateForumThreadResponse(HttpStatusCode response)
        {
            _response = response;
        }
    }
}