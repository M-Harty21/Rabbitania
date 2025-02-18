﻿using Microsoft.Build.Framework;

namespace backend_api.Models.Chat.Requests
{
    public class AgoraAuthRequest
    {
        
        [Required] 
        public string channel { get; set; }

        [Required] public dynamic uid { get; set; } = 0;

        public uint expiredTokens { get; set; } = 0;
    }
}