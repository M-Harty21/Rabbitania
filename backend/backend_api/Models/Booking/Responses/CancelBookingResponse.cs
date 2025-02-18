﻿using System.Net;

namespace backend_api.Models.Booking.Responses
{
    public class CancelBookingResponse
    {
        /// <summary>
        ///     Will return status code response to confirm if a booking
        ///     was indeed cancelled or not
        ///     + Status code return 200 (Ok) or
        ///     + Status code return 400 (Bad request) 
        /// </summary>
        private HttpStatusCode _response;

        public CancelBookingResponse(HttpStatusCode response)
        {
            _response = response;
        }

        public HttpStatusCode Response
        {
            get => _response;
            set => _response = value;
        }
    }
}