﻿using System.Threading.Tasks;
using backend_api.Models.Booking.Requests;
using backend_api.Models.Booking.Responses;

namespace backend_api.Services.Booking
{
    public interface IBookingService
    {
        /// <summary>
        ///     Create booking service that checks the request object
        ///     and makes sure all checks pass
        /// </summary>
        /// <param name="request"></param>
        /// <returns> CreateBookingResponse </returns>
        Task<CreateBookingResponse> CreateBooking(CreateBookingRequest request);
        
        Task<CancelBookingResponse> CancelBooking(CancelBookingRequest request);
        
        Task<UpdateBookingResponse> UpdateBooking(UpdateBookingRequest request);

        Task<GetBookingResponse> ViewBooking(GetBookingRequest request);
        
        Task<GetAllBookingsResponse> ViewAllBookings(GetAllBookingsRequest request);
    }
}