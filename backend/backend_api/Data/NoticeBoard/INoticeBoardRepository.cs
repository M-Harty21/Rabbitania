﻿using System.Collections.Generic;
using System.Threading.Tasks;
using backend_api.Models.NoticeBoard.Requests;
using backend_api.Models.NoticeBoard.Responses;

namespace backend_api.Data.NoticeBoard
{
    public interface INoticeBoardRepository
    {
        Task<AddNoticeBoardThreadResponse> AddNoticeBoardThread(AddNoticeBoardThreadRequest request);

        Task<List<Models.NoticeBoard.NoticeBoard>> RetrieveAllNoticeBoardThreads(RetrieveNoticeBoardThreadsRequest request);

        Task<DeleteNoticeBoardThreadResponse> DeleteNoticeBoardThread(DeleteNoticeBoardThreadRequest request);

        Task<EditNoticeBoardThreadResponse> EditNoticeBoardThread(EditNoticeBoardThreadRequest request);

        Task<IncreaseEmojiResponse> IncreaseEmoji(IncreaseEmojiRequest request);
        Task<DecreaseEmojiResponse> DecreaseEmoji(DecreaseEmojiRequest request);
    }
}