using System.Linq;
using System.Threading.Tasks;
using backend_api.Data.User;
using backend_api.Models.User.Requests;
using backend_api.Models.User.Responses;
using backend_api.Services.User;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace backend_api.Controllers.User
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserController : ControllerBase
    {
        private readonly IUserService _service;
        private readonly UserContext _context;

        public UserController(IUserService service, UserContext context)
        {
            this._service = service;
            this._context = context;//not needed once other endpoints are configured
        }

        /// <summary>
        ///     ** FOR ADMINS ONLY
        ///     API endpoint to Get all Users in the system
        /// </summary>
        /// <param name="request"></param>
        /// <returns>A list of users in the system</returns>
        [HttpGet]
        [Route("Admin/GetUser")]
        public GetUserResponse GetUsers([FromQuery] GetUserRequest request)
        {
            // return await _context.users.ToListAsync();
            return _service.getUser(request);
        }

        /// <summary>
        ///     API endpoint to edit a users profile.
        /// </summary>
        /// <param name="request"></param>
        /// <returns> A response </returns>
        [HttpPut]
        [Route("EditProfile")]
        public async Task<EditProfileResponse> EditProfile([FromBody] EditProfileRequest request)
        {
            return await _service.EditProfile(request);
        }
        
        /// <summary>
        ///     API endpoint to view a users profile.
        /// </summary>
        /// <param name="request"></param>
        /// <returns> A response </returns>
        [HttpGet]
        [Route("ViewProfile")]
        public async Task<ViewProfileResponse> ViewProfile([FromQuery] ViewProfileRequest request)
        {
            return await _service.ViewProfile(request);
        }
        
    }
}