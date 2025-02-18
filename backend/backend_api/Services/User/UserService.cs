﻿using System;
using System.Collections.Generic;
using System.Net;
using System.Threading.Tasks;
using backend_api.Data.User;
using backend_api.Exceptions.Notifications;
using backend_api.Exceptions.User;
using backend_api.Models.Auth.Requests;
using backend_api.Models.User;
using backend_api.Models.User.Requests;
using backend_api.Models.User.Responses;
using backend_api.Services.Notification;
using Castle.Core.Internal;
using Newtonsoft.Json.Linq;

namespace backend_api.Services.User
{
    public class UserService: IUserService
    {
        private readonly IUserRepository _userRepository;
      
        public UserService(IUserRepository userRepo)
        {
            _userRepository = userRepo;
        }

        //Logical functions
        public void verifyLogin()
        {
            
        }

        public async Task<CreateUserResponse> CreateUser(GoogleSignInRequest request)
        {
            if (request != null && request.Email!= null && request.Email.Length > 0)
            {
                return await _userRepository.CreateUser(request);
            }
            
            else
            {
                if (request == null)
                {
                    throw new InvalidUserRequestException("Create User request is null");

                }
                else
                {
                    throw new InvalidUserEmailRequest("Create user email is empty");

                }
            }
        }

        public async Task<GetUserResponse> getUser(GetUserRequest request)
        {
            //TODO: implement GetUSerResponse to use the jwt token from google login API
            //JsonWebToken token = request.getToken();
            //String email = token.getEmail();
            if (request == null || request.getName() == null || request.getSurname() == null)
            {
                throw new InvalidUserRequestException("Get User request is null");
            }
            String name = request.getName();
           
            //search for user
            try
            {
                Models.User.Users user = _userRepository.GetUser(name).Result[0];
                GetUserResponse response = new GetUserResponse(user, name, user.EmployeeLevel, user.IsAdmin, user.UserDescription, user.UserId, user.PhoneNumber, user.UserRole, user.UserImgUrl, user.OfficeLocation, user.PinnedUserIds);
                return response;
            }
            catch (Exception e)
            {
                throw new InvalidUserRequestException(e.Message);
            }
            
        }
        public async Task<GetUserResponse> GetUserByEmail(GetUserByEmailRequest request)
        {
            if (request == null)
            {
                throw new InvalidUserRequestException("Request is null");
            }

            if (string.IsNullOrEmpty(request.Email))
            {
                throw new InvalidUserEmailRequest("User email is null in request object");
            }

            try
            {
                var user = await _userRepository.GetUserByEmail(request.Email);
                return new GetUserResponse(user, user.Name,user.EmployeeLevel,user.IsAdmin,user.UserDescription,user.UserId,user.PhoneNumber,user.UserRole,user.UserImgUrl,user.OfficeLocation,user.PinnedUserIds);
            }
            catch (Exception e)
            {
                throw new InvalidUserEmailRequest("User does not exist with email: "+request.Email);
            }
        }
        public async Task<EditProfileResponse> EditProfile(EditProfileRequest request)
        {
            if (request == null)
            {
                throw new InvalidUserRequestException("Request object cannot be null");
            }
            if (request.UserId <= 0)
            {
                throw new InvalidUserIdException("UserID is invalid");
            }

            try
            {
                return await _userRepository.EditProfile(request);
            }
            catch (Exception e)
            {
                throw new InvalidUserRequestException(e.Message);
            }
            
        }
        
        public async Task<ViewProfileResponse> ViewProfile(ViewProfileRequest request)
        {
            if (request == null)
            {
                throw new InvalidUserRequestException("Request object cannot be null");
            }
            if (request.UserId <= 0)
            {
                throw new InvalidUserIdException("Error Missing UserID");
            }
            
            ViewProfileResponse returnObject = await _userRepository.ViewProfile(request);
            if (returnObject.name == null)
            {
                throw new InvalidUserRequestException("User does not exist");
            }

            return returnObject;
        }

        public async Task<GetUserProfilesResponse> GetUserProfiles(GetUserProfilesRequest request)
        {
            if (request == null )
            {
                throw new InvalidUserRequestException("Request object cannot be null");
            }
            try
            {
                return await _userRepository.GetUserProfiles();
            }
            catch (Exception e)
            {
                throw new InvalidUserRequestException("Users do not exist");
            }
        }

        public List<string> GetAllUserEmails()
        {
            var response = _userRepository.GetAllUserEmails();
            if (response.IsNullOrEmpty())
            {
                throw new Exception("Error with user emails");
            }

            return response;
        }

        public async Task<MakeUserAdminResponse> MakeUserAdmin(MakeUserAdminRequest request)
        {
            if (request == null)
            {
                throw new InvalidUserRequestException("Request object cannot be null");
            }

            if (request.UserId.Equals(null) || request.UserId <= 0)
            {
                throw new InvalidUserIdException("Error Missing UserID");
            }
            
            return await _userRepository.MakeUserAdmin(request);
        }

        public async Task<CheckAdminStatusResponse> CheckAdmin(CheckAdminStatusRequest request)
        {
            if (request == null)
            {
                throw new InvalidUserRequestException("Request is null");
            }

            if (request.UserEmail == null || request.UserEmail.Length <= 0)
            {
                throw new InvalidUserRequestException("Request email is null or empty");
            }

            var email = request.UserEmail;
            try
            {
                var user = await _userRepository.GetUserByEmail(email);
                if (user.IsAdmin)
                {
                    return new CheckAdminStatusResponse(true, HttpStatusCode.OK);
                }
                else
                {
                    return new CheckAdminStatusResponse(false, HttpStatusCode.OK);
                }
            }
            catch (Exception e)
            {
                return new CheckAdminStatusResponse(HttpStatusCode.BadRequest);
            }
        }

    }
}