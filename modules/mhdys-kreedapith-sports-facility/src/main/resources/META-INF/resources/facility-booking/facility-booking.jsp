<%@ include file="../init.jsp"%>
<%@page import="mhdys.kreedapith.sports.facility.constants.MhdysKreedapithSportsFacilityPortletKeys"%>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

<portlet:resourceURL id="<%=MhdysKreedapithSportsFacilityPortletKeys.GET_DISTRICT_BY_DIVISION%>" var="getDistrictByDivisionURL" />
<portlet:resourceURL id="<%=MhdysKreedapithSportsFacilityPortletKeys.GET_COMPLEX_BY_TALUKA_URL%>" var="getComplexByTalukaURL" />
<portlet:resourceURL id="<%=MhdysKreedapithSportsFacilityPortletKeys.CANCEL_BOOKING%>" var="cancelBookingURL" />
<portlet:resourceURL id="<%=MhdysKreedapithSportsFacilityPortletKeys.GET_SPORTS_COMPLEX_BY_DISTRICT%>" var="getFacilitySportsCompexByDistrictURL" />
<portlet:resourceURL id="<%=MhdysKreedapithSportsFacilityPortletKeys.GET_FACILITY_BY_SPORTS_COMPLEX%>" var="getFacilityBySportsComplexURL" />
<portlet:resourceURL id="<%=MhdysKreedapithSportsFacilityPortletKeys.SAVE_FACILITY_BOOKING%>" var="saveFacilityBookingURL" />

<style>
:root {
	--primary-color: #0d6efd;
	--secondary-color: #6c757d;
}

.error-container{
	color: red;
}

body {
	background-color: #f8f9fa;
	font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto,
		Oxygen, Ubuntu, Cantarell, sans-serif;
}

.header {
	background: white;
	border-bottom: 1px solid #dee2e6;
	padding: 1.5rem 0;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
}

.header-icon {
	font-size: 2rem;
	color: var(--primary-color);
}

.facility-card {
	height: 100%;
	transition: transform 0.2s, box-shadow 0.2s;
	border: 1px solid #dee2e6;
}

.facility-card:hover {
	transform: translateY(-4px);
	box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
}

.facility-image {
	height: 200px;
	object-fit: cover;
	width: 100%;
}

.badge-unavailable {
	position: absolute;
	top: 10px;
	right: 10px;
}

.info-item {
	display: flex;
	align-items: center;
	gap: 0.5rem;
	margin-bottom: 0.5rem;
	color: #6c757d;
}

.info-item i {
	font-size: 1rem;
}

.booking-summary {
	background-color: #f8f9fa;
	padding: 1rem;
	border-radius: 0.375rem;
	margin-top: 1rem;
}

.calendar-container {
	max-width: 100%;
	margin: 1rem 0;
}

.calendar-grid {
	display: grid;
	grid-template-columns: repeat(7, 1fr);
	gap: 0.25rem;
	margin-top: 0.5rem;
}

.calendar-day {
	aspect-ratio: 1;
	display: flex;
	align-items: center;
	justify-content: center;
	border: 1px solid #dee2e6;
	border-radius: 0.25rem;
	cursor: pointer;
	background: white;
	transition: all 0.2s;
}

.calendar-day:hover:not(.disabled):not(.other-month) {
	background-color: #fff;
	border-color: var(--primary-color);
	color: #000;
}

.calendar-day.selected {
	background-color: #26268E;
	color: white;
}

.calendar-day.disabled {
	background-color: #f8f9fa;
	color: #adb5bd;
	cursor: not-allowed;
}

.calendar-day.other-month {
	color: #adb5bd;
}

.calendar-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 1rem;
}

.calendar-weekday {
	text-align: center;
	font-weight: 600;
	color: #6c757d;
	padding: 0.5rem 0;
	font-size: 0.875rem;
}

.toast-container {
	position: fixed;
	top: 20px;
	right: 20px;
	z-index: 9999;
}

.toast {
	min-width: 300px;
}

.empty-state {
	text-align: center;
	padding: 3rem 1rem;
	color: #6c757d;
}

.empty-state i {
	font-size: 4rem;
	opacity: 0.5;
	margin-bottom: 1rem;
}

.booking-type-tabs {
	margin-bottom: 1.5rem;
}

.booking-details-icon {
	font-size: 0.875rem;
	color: #6c757d;
}
.common-forms-div .card .card-footer .btn {
    background-color: #861f41;
    border-color: #861f41;
    color: #fff;
    font-size: 13px;
    padding: 10px 20px;
    font-family: Poppins-Meduim;
    border-radius: 6px;
    margin: 0px 0px 0px 0px;
}
.booking-text{
	color: #26268E;
}
.mybooking-btn{
	color: #ffffff;
}
.text-muted {
    color: #D9D9D9 !important;
}
.badge{
    background-color: #26268E;
}
.nav-link{
    color: #26268E ;
}



</style>

<div class="common-forms-div">
    <div class="container">
    <div class="card shadow border-0">
		<div class="toast-container" id="toastContainer"></div>

		    <!-- Header -->
     <div class="card-header d-flex justify-content-between align-items-center back-btn-cn">
          <h5 class="mb-0">
             <liferay-ui:message key="facility-booking" />
          </h5>
          <div>
              <a href="/group/guest/sports-facility" class="btn btn-primary btn-sm rounded-pill back-btn-cn" ><i class="bi bi-arrow-left-circle mr-1"></i><liferay-ui:message key="back" /></a>
          </div>
     </div> 
    <!-- Main Content -->
	<main class="container my-4">
        <!-- Tabs -->
        <ul class="nav nav-tabs mb-4" id="mainTabs" role="tablist">
            <li class="nav-item" role="presentation">
                <span class="nav-link active" id="facilities-tab" data-bs-toggle="tab" 
                        data-bs-target="#facilities" type="button" role="tab">
                    <i class="bi bi-building me-2"></i><liferay-ui:message key="facilities" />
                </span>
            </li>
            <li class="nav-item" role="presentation">
                <span class="nav-link" id="bookings-tab" data-bs-toggle="tab" 
                        data-bs-target="#bookings" type="button" role="tab">
                    <i class="bi bi-calendar-check me-2"></i><liferay-ui:message key="my-bookings" /><span id="bookingCount" class="badge ms-2">${bookingCount}</span>
                </span>
            </li>
        </ul>
        <!-- Tab Content -->
        <div class="tab-content" id="mainTabsContent">
            
            <!-- Facilities Tab -->
            <div class="tab-pane fade show active" id="facilities" role="tabpanel">
                
                 <!-- Division And District Selection -->
            <div class="row">
            	<div class="col-md-6">
                    <div class="form-group">
                       <label for="division" class="form-label"><liferay-ui:message key="facility-type" /><sup class="text-danger">*</sup></label>
                       <select  id="facility-type" name="facility-type" class="form-control">
                           <option value=""><liferay-ui:message key="select" /></option>
                           <%-- <option value="state"><liferay-ui:message key="state" /></option> --%>
                           <option value="Division"><liferay-ui:message key="division" /></option>
                           <option value="District"><liferay-ui:message key="district" /></option>
                           <option value="Taluka"><liferay-ui:message key="taluka" /></option>
                       </select>
                       <p class="error-container" id="facility-type-error"></p>
                   </div>
                 </div>
            	<div class="col-md-6 d-none divisiondiv">
                    <div class="form-group">
                       <label for="division" class="form-label"><liferay-ui:message key="division" /><sup class="text-danger">*</sup></label>
                       <select id="division" name="division" class="form-control">
                           <option value=""><liferay-ui:message key="select-division" /></option>
                          	  <c:forEach items="${divisions}" var="division">
                       			<option value="${division.divisionId}">${division.divisionName_en}</option>
                       		</c:forEach>	
                       </select>
                       <p class="error-container" id="division-error"></p>
                   </div>
                 </div>
                 <div class="col-md-6 d-none districtdiv">
                    <div class="form-group">
                       <label for="district" class="form-label"><liferay-ui:message key="district" /><sup class="text-danger">*</sup></label>
                        <select id="district" name="district" class="form-control">
                            <option value=""><liferay-ui:message key="select-district" /></option>
                       	 		 <%-- <c:forEach items="${districts}" var="districts">
                        			<option value="${districts.districtId}">${districts.districtName_en}</option>
                        		</c:forEach>	 --%>
                        </select>
						<p class="error-container" id="district-error"></p>
	                </div>
                 </div>
                 <div class="col-md-6 d-none talukadiv">
                    <div class="form-group">
                       <label for="taluka" class="form-label"><liferay-ui:message key="taluka" /><sup class="text-danger">*</sup></label>
                        <select id="taluka" name="taluka" class="form-control">
                            <option value=""><liferay-ui:message key="select-taluka" /></option>
                        </select>
						<p class="error-container" id="taluka-error"></p>
	                </div>
                 </div>
                 
                 <div class="col-md-6 d-none complexdiv">
                    <div class="form-group">
                       <label for="Facility location" class="form-label"><liferay-ui:message key="facility-location" /><sup class="text-danger">*</sup></label>
                        <select id="facility-location" name="facility-location" class="form-control">
	                            <option value=""><liferay-ui:message key="select-complex" /></option>
    								                   	 	
                        </select>
						<p class="error-container" id="district-error"></p>
	                </div>
                 </div>
                 
            </div>
            <!-- Division And District Selection -->
                
           <div class="row g-4 d-none" id="facilitiesGrid">
            
            
            
            
            
            </div>
           </div>

            
            
            <!-- Bookings Tab -->
            <div class="tab-pane fade" id="bookings" role="tabpanel">
                <div class="card">
                    <div class="card-header">
                        <h5 class="mb-0"><liferay-ui:message key="my-bookings" /></h5>
                        <!-- <small class="text-muted">Manage your facility bookings</small> -->
                    </div>
                   	<div class="card-body" id="bookingsContainer">
								<c:choose>
									<c:when test="${not empty facilityBookingList}">
											<table class="table table-hover">
												<thead>
						                            <tr>
						                                <th><liferay-ui:message key="facility"/></th>
						                                <th><liferay-ui:message key="type" /></th>
						                                <th><liferay-ui:message key="date-and-time" /></th>
						                                <th><liferay-ui:message key="customer" /></th>
						                                <th><liferay-ui:message key="fees-amount" /></th>
						                                <th><liferay-ui:message key="fees-status" /></th>
						                                <th><liferay-ui:message key="status" /></th>
						                                <th class="text-end"><liferay-ui:message key="actions" /></th>
						                            </tr>
						                        </thead>
						                        <tbody>
					                        		 <c:forEach items="${facilityBookingList}" var="facilityBooking" varStatus="bookingCount">
					                        		 		<tr>
					                        		 			<td>${facilityBooking.sportCourt}</td>
						                        		 		 <td><span class="badge mybooking-btn">${facilityBooking.type}</span></td>
						                        		 		 <td>
						                                        	<div class="small">
						                                                <div class="mb-1">
						                                                    <i class="bi bi-calendar3 booking-details-icon me-2"></i>${facilityBooking.date}
						                                                </div>
						                                            </div>
						                                        </td>
						                                        <td>
						                                            <div class="small">
						                                                <div class="mb-1"> <i class="bi bi-person booking-details-icon"></i>${facilityBooking.name}</div>
						                                                <div class="text-black text-truncate" style="max-width: 150px;"><i class="bi bi-envelope booking-details-icon"></i>${facilityBooking.email}</div>
						                                                <div class="text-black"><i class="bi bi-telephone booking-details-icon"></i> ${facilityBooking.contact}</div>
						                                            </div>
						                                        </td>
						                                         <td>${facilityBooking.fees}</td>
						                                          <td>Paid</td>
						                                           <td>
						                                           <c:choose>
						                                           		<c:when test="${facilityBooking.bookingStatus==0}">
						                                           			<span class="badge bg-warning">Pending</span>
						                                           		</c:when>
						                                           		<c:when test="${facilityBooking.bookingStatus==1}">
						                                           			<span class="badge badge bg-success">Approved</span>
						                                           		</c:when>
						                                           		<c:when test="${facilityBooking.bookingStatus==9}">
						                                           			<span class="badge bg-danger">Rejected</span>
						                                           		</c:when>
						                                           		<c:otherwise>
						                                           		</c:otherwise>	
						                                           </c:choose>
						                                           </td>
						                                            <td class="text-end">
							                                            <c:choose>
							                                            	<c:when test="${facilityBooking.bookingStatus==1}">
							                                            		<button class="btn btn-sm btn-outline-danger" disabled="disabled">
							                                               			<i class="bi bi-trash"></i>
							                                            		</button>	
							                                            	</c:when>
							                                            	<c:otherwise>
								                                            	<button class="btn btn-sm btn-outline-danger" onclick="deleteBooking('${facilityBooking.facilityBookingId}')">
								                                               		 <i class="bi bi-trash"></i>
								                                            	</button>
							                                            	</c:otherwise>
							                                            
							                                            </c:choose>
							                                            
							                                            
							                                        </td>
					                        		 		</tr>
					                        		 </c:forEach>
						                        </tbody>
											</table>
									</c:when>
									<c:otherwise>
										 <div class="empty-state">
						                        <i class="bi bi-calendar-x"></i>
						                        <p><liferay-ui:message key="you-havent-made-any-bookings-yet" />.<br><liferay-ui:message key="browse-facilities-and-make-your-first-booking" />!</p>
						                    </div>
									</c:otherwise>
								</c:choose>		                   
                	</div>
                </div>
            </div>
            
        </div>
    </main>

    <!-- Booking Modal -->
    <div class="modal fade" id="bookingModal" tabindex="-1" aria-labelledby="bookingModalLabel" aria-hidden="true">
        <form name="bookingfm" id="bookingfm" method="POST" enctype="multipart/form-data" autocomplete="off">
	        <input type="hidden" name="bookingFacilityName" value="" id="bookingFacilityName"/>
	        <input type="hidden" name="bookingFacilityId" value="" id="bookingFacilityId"/>
	        <input type="hidden" name="bookingFacilityCourt" value="" id="bookingFacilityCourt"/>
	        <input type="hidden" name="totalFinalAmount" value="" id="totalFinalAmount"/>
        	
        	<!-- changes -->
        		<input type="hidden" name="bookingAssosicationHourlyFees" id="bookingAssosicationHourlyFees" value="">
              	<input type="hidden" name="bookingAssosicationDailyFees" id="bookingAssosicationDailyFees" value="">
              	<input type="hidden" name="bookingAssosicationMonthlyFees" id="bookingAssosicationMonthlyFees" value="">
               	<input type="hidden" name="bookingOtherSportsHourlyFees" id="bookingOtherSportsHourlyFees" value="">
               	<input type="hidden" name="bookingOtherSportsDailyFees" id="bookingOtherSportsDailyFees" value="">
               	<input type="hidden" name="bookingOtherSportsMonthlyFees" id="bookingOtherSportsMonthlyFees" value="">
               	<input type="hidden" name="bookingNonSportsHourlyFees" id="bookingNonSportsHourlyFees" value="">
               	<input type="hidden" name="bookingNonSportsDailyFees" id="bookingNonSportsDailyFees" value="">
               	<input type="hidden" name="bookingNonSportsMonthlyFees" id="bookingNonSportsMonthlyFees" value="">
               	<input type="hidden" name="bookingIndividualHourlyFees" id="bookingIndividualHourlyFees" value="">
               	<input type="hidden" name="bookingIndividualDailyFees" id="bookingIndividualDailyFees" value="">
               	<input type="hidden" name="bookingIndividualMonthlyFees" id="bookingIndividualMonthlyFees" value="">
               	<input type="hidden" name="bookingACFees" id="bookingACFees" value="">
               	<input type="hidden" name="bookingArenaLightFees" id="bookingArenaLightFees" value="">
               	<input type="hidden" name="isAcHourlyChecked" id="isAcHourlyChecked" value="false">
               	<input type="hidden" name="isArenaLightChecked" id="isArenaLightChecked" value="false">
               	<input type="hidden" name="facilityLevelVal" id="facilityLevelVal" value="">
               	<input type="hidden" name="divisionVal" id="divisionVal" value="">
               	<input type="hidden" name="districtVal" id="districtVal" value="">
               	<input type="hidden" name="talukaVal" id="talukaVal" value="">
        	<!-- changes -->
        	
        	
        <div class="modal-dialog modal-lg modal-dialog-scrollable">
            <div class="card shadow border-0 modal-content">
                <div class="modal-header  d-flex justify-content-between align-items-center back-btn-cn">
                    <div>
                        <h5 class="modal-title text-white" id="bookingModalLabel"><liferay-ui:message key="book-facility" /></h5>
                        <small class="text-muted"><liferay-ui:message key="choose-your-booking-type-and-fill-in-the-details" /></small>
                    </div>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                
                  <div class="card-body px-3">
                    <!-- Booking Type Tabs -->
                    <div class="mb-4">
                        <label class="form-label fw-bold"><liferay-ui:message key="booking-type" /></label>
                        <ul class="nav nav-pills booking-type-tabs" id="bookingTypeTabs" role="tablist">
                            <li class="nav-item flex-fill bookingType" role="presentation">
                                <button class="nav-link active w-100" id="hourly-tab" data-bs-toggle="pill" 
                                        data-bs-target="#hourly" type="button" role="tab">
                                   <liferay-ui:message key="hourly-rental" />
                                </button>
                            </li>
                            <li class="nav-item flex-fill bookingType mx-3" role="presentation">
                                <button class="nav-link w-100" id="daily-tab" data-bs-toggle="pill" 
                                        data-bs-target="#daily" type="button" role="tab">
                                    <liferay-ui:message key="daily-subscription" />
                                </button>
                            </li>
                             <li class="nav-item flex-fill bookingType" role="presentation">
                                <button class="nav-link w-100" id="monthly-tab" data-bs-toggle="pill" 
                                        data-bs-target="#monthly" type="button" role="tab">
                                    <liferay-ui:message key="monthly-subscription" />
                                </button>
                            </li>
                        </ul>
                    </div>

                    <div class="tab-content" id="bookingTypeContent">
                        <div class="tab-pane fade show active" id="hourly" role="tabpanel">
                            <!-- Date Selection -->
                            <div class="mb-4">
                                <label class="form-label fw-bold">
                                    <i class="bi bi-calendar3 me-2"></i><liferay-ui:message key="select-date" />
                                </label>
                                <div id="calendar" class="calendar-container"></div>
                            </div>

                            <!-- Time Selection -->
                            <div class="row mb-4">
                                <div class="col-md-6">
                                    <label for="startTime" class="form-label fw-bold">
                                        <i class="bi bi-clock me-2"></i><liferay-ui:message key="start-time" />
                                    </label>
                                    <select class="form-select" id="startTime" name="startTime">
                                        <!-- Time options will be inserted by JavaScript -->
                                         <option value=""><liferay-ui:message key="select" /></option>
                                        <option value="06:00">06:00</option>
                                        <option value="07:00">07:00</option>
                                        <option value="08:00">08:00</option>
                                        <option value="09:00">09:00</option>
                                        <option value="10:00">10:00</option>
                                        <option value="11:00">11:00</option>
                                        <option value="12:00">12:00</option>
                                        <option value="13:00">13:00</option>
                                        <option value="14:00">14:00</option>
                                        <option value="15:00">15:00</option>
                                        <option value="16:00">16:00</option>
                                        <option value="17:00">17:00</option>
                                        <option value="18:100">18:00</option>
                                        <option value="19:00">19:00</option>
                                        <option value="20:00">20:00</option>
                                        <option value="21:00">21:00</option>
                                        <option value="22:00">22:00</option>
                                    </select>
                                     <p class="error-container" id="startTime-error"></p>
                                </div>
                                <div class="col-md-6">
                                    <label for="endTime" class="form-label fw-bold">
                                        <i class="bi bi-clock me-2"></i><liferay-ui:message key="end-time" />
                                    </label>
                                    <select class="form-select" id="endTime" name="endTime">
                                         <option value=""><liferay-ui:message key="select" /></option>
                                        <!--<option value="07:00">07:00</option>
                                        <option value="08:00">08:00</option>
                                        <option value="09:00">09:00</option>
                                        <option value="10:00" selected="selected">10:00</option>
                                        <option value="11:00">11:00</option>
                                        <option value="12:00">12:00</option>
                                        <option value="13:00">13:00</option>
                                        <option value="14:00">14:00</option>
                                        <option value="15:00">15:00</option>
                                        <option value="16:00">16:00</option>
                                        <option value="17:00">17:00</option>
                                        <option value="18:100">18:010</option>
                                        <option value="19:00">19:00</option>
                                        <option value="20:00">20:00</option>
                                        <option value="21:00">21:00</option>
                                        <option value="22:00">22:00</option> -->
                                    </select>
                                    <p class="error-container" id="endTime-error"></p>
                                </div>
                                <div class="col-md-6">
                                	<label for="BookingFor" class="form-label fw-bold">
                                        <liferay-ui:message key="booking-for" />
                                    </label>
                                     <select class="form-select" id="BookingFor" name="BookingFor">
                                     	 <option value=""><liferay-ui:message key="select"/></option>
                                     	 <option value="Association & Federation"><liferay-ui:message key="association-federation" /></option>
                                     	 <option value="Other Sports Events"><liferay-ui:message key="other-sports-events" /></option>
                                     	 <option value="Non Sports Events"><liferay-ui:message key="non-sports-events" /></option>
                                     	 <option value="Individal"><liferay-ui:message key="individal" /></option>
                                     </select>
                                     <p class="error-container" id="BookingFor-error"></p>
                                </div>
                                <div class="col-md-6 ">
                                     <label for="BookingFor" class="form-label fw-bold">
                                        Optional
                                    </label>
								  <div class="d-flex align-items-center gap-3">  
								    <div>
								      <input type="checkbox" name="arenalights-hourly" id="arenalights-hourly" value="arenalights-hourly">
								      <label for="arenalights-hourly" class="form-label fw-bold"><liferay-ui:message key="arena-lights" /></label>
								    </div>
								    <div>
								       <input type="checkbox" name="ac-hourly" value="ac-hourly" id="ac-hourly">
								       <label for="ac-hourly" class="form-label fw-bold"><liferay-ui:message key="ac"/></label>
								    </div>
								  </div>
								</div>
                            
                            </div>
                        </div>
                        <!-- Daily Tab Starts -->
                        <div class="tab-pane fade" id="daily" role="tabpanel">
                            <div class="mb-4">
                                <label class="form-label fw-bold">
                                    <i class="bi bi-calendar3 me-2"></i><liferay-ui:message key="start-date" />
                                </label>
                                <div id="calendar-daily" class="calendar-container"></div>
                            </div>
                             <div class="row mb-4">
                            <div class="col-md-6">
                                	<label for="dayBookingFor" class="form-label fw-bold">
                                         <liferay-ui:message key="booking-for" />
                                    </label>
                                     <select class="form-select" id="dayBookingFor" name="dayBookingFor">
                                     	 <option value=""><liferay-ui:message key="select"/></option>
                                     	 <option value="Association & Federation"><liferay-ui:message key="association-federation" /></option>
                                     	 <option value="Other Sports Events"><liferay-ui:message key="other-sports-events" /></option>
                                     	 <option value="Non Sports Events"><liferay-ui:message key="non-sports-events" /></option>
                                     	 <option value="Individal"><liferay-ui:message key="individal" /></option>
                                     </select>
                                     <p class="error-container" id="dayBookingFor-error"></p>
                                </div>
                                  <div class="col-md-6 px-5">
                                   <label for="BookingFor" class="form-label fw-bold">
                                        Optional
                                    </label>
								  <div class="d-flex align-items-center gap-3">
								    <div>
								     	<input type="checkbox" name="arenalights-daily" value="arenalights-daily" id="arenalights-daily">
                                		<label for="arenalights-daily" class="form-label fw-bold">
	                                      <liferay-ui:message key="arena-lights" />
	                                    </label>
								    </div>
								    <div>
								        <input type="checkbox" name="ac-daily" value="ac-daily" id="ac-daily">
                                	<label for="ac-daily" class="form-label fw-bold">
                                       <liferay-ui:message key="ac"/>
                                    </label>
								    </div>
								  </div>
								</div>
                        
                                <div class="col-md-6">
                                	<label for="bookingFor" class="form-label fw-bold">
                                       <liferay-ui:message key="no-of-days" />
                                    </label>
                                     <select class="form-select" id="nofodays" name="nofodays">
                                     	 <option value=""><liferay-ui:message key="select"/></option>
                                     	<c:forEach var="i" begin="1" end="30">
								            <option value="${i}">${i}</option>
								        </c:forEach>
                                     </select>
                                     <p class="error-container" id="nofodays-error"></p>
                             </div>
                                </div>
                        </div>
                        <!-- Daily Tab Ends -->
                        
                        <!-- Monthly Tab Starts-->
                        <div class="tab-pane fade" id="monthly" role="tabpanel">
                            <!-- Date Selection for Monthly -->
                            <div class="mb-4">
                                <label class="form-label fw-bold">
                                    <i class="bi bi-calendar3 me-2"></i><liferay-ui:message key="start-date" />
                                </label>
                                <div id="calendar-monthly" class="calendar-container"></div>
                            </div>
                            <div class="row mb-4">
                            <div class="col-md-6">
                                	<label for="monthBookingFor" class="form-label fw-bold">
                                       <liferay-ui:message key="booking-for" />
                                    </label>
                                     <select class="form-select" id="monthBookingFor" name="monthBookingFor">
                                     	 <option value=""><liferay-ui:message key="select"/></option>
                                     	 <option value="Association & Federation"><liferay-ui:message key="association-federation" /></option>
                                     	 <option value="Other Sports Events"><liferay-ui:message key="other-sports-events" /></option>
                                     	 <option value="Non Sports Events"><liferay-ui:message key="non-sports-events" /></option>
                                     	 <option value="Individal"><liferay-ui:message key="individal" /></option>
                                     </select>
                                      <p class="error-container" id="monthBookingFor-error"></p>
                             </div>
                               <div class="col-md-6 px-5">
                                <label for="BookingFor" class="form-label fw-bold">
                                        Optional
                                    </label>
								  <div class="d-flex align-items-center gap-3">
								    <div>
								     	<input type="checkbox" name="arenalights-monthly" value="arenalights-monthly" id="arenalights-monthly">
                                	    <label for="arenalights-monthly" class="form-label fw-bold"> <liferay-ui:message key="arena-lights" /></label>
								    </div>
								    <div>
								       <input type="checkbox" name="ac-monthly" value="ac-monthly" id="ac-monthly">
                                	  <label for="ac-monthly" class="form-label fw-bold"><liferay-ui:message key="ac"/></label>
								    </div>
								  </div>
								</div>
                             <div class="col-md-6">
                                	<label for="noofmonth" class="form-label fw-bold">
                                       <liferay-ui:message key="no-of-month" />
                                    </label>
                                     <select class="form-select" id="noofmonth" name="noofmonth">
                                     	 <option value=""><liferay-ui:message key="select"/></option>
                                     	<c:forEach var="i" begin="1" end="12">
								            <option value="${i}">${i}</option>
								        </c:forEach>
                                     </select>
                                      <p class="error-container" id="noofmonth-error"></p>
                             </div>
                             </div>
                        </div>
                          <!-- Monthly Tab Ends-->
                    </div>
                    <!-- Customer Information -->
                    <div class="mb-4">
                        <h6 class="fw-bold mb-3"><liferay-ui:message key="customer-information" /></h6>
                        <div class="mb-3">
                            <label for="customerName" class="form-label"><liferay-ui:message key="full-name" /></label>
                            <input type="text" class="form-control" name="customerName" id="customerName" placeholder="<liferay-ui:message key="enter-your-name"/>" required>
                        	<p class="error-container" id="customerName-error"></p>
                        </div>
                        <div class="mb-3">
                            <label for="customerEmail" class="form-label"><liferay-ui:message key="email" /></label>
                            <input type="email" class="form-control" name="customerEmail" id="customerEmail" placeholder="<liferay-ui:message key="enter-your-email" />" required>
                        	<p class="error-container" id="customerEmail-error"></p>
                        </div>
                        <div class="mb-3">
                            <label for="customerPhone" class="form-label"><liferay-ui:message key="phone-number" /></label>
                            <input type="text" onkeypress="if(this.value.length==10) return false;" oninput="this.value = this.value.replace(/\D+/g, '')"   class="form-control" name="customerPhone" id="customerPhone" placeholder="<liferay-ui:message key="enter-your-phone-number"/>" required>
                        	<p class="error-container" id="customerPhone-error"></p>
                        </div>
                        <!-- Additional Field  -->
                        <div class="mb3 d-none ammunitionlicenseCls">
									  <div class="form-group">
									    <label>
								            <liferay-ui:message key="firearm-and-ammunition-license" />
								            <sup class="text-danger licenseDocCls d-none">*</sup>
								            <em class="bi bi-info-circle-fill" title="<liferay-ui:message key="allowed-only-pdf-file" />"></em>
								        </label>
	                            		 <div class="custom-file">
						                    <input type="file" class="custom-file-input" id="licenseDoc" name="licenseDoc"
						                        onchange="handleFileUpload(event, 'licenseDoc', 'dprDocumentNewPreviewContainer', 'dprDocumentNewPreviewLink', 'dprDocumentNewDeleteButton')"> 
						                    <label class="custom-file-label" for="customFile">
						                        <liferay-ui:message key="choose-file" />
						                    </label>
						                </div>
						            <div class="ownerProofid d-none mt-3" id="dprDocumentNewPreviewContainer">
						                <a class="dprDocumentCls" id="dprDocumentNewPreviewLink" href="" target="_blank"
						                    style="flex-grow: 1; text-decoration: none; white-space: nowrap;overflow: hidden; max-width: 200px; color: #26268E;"></a>
						                <button type="button" id="dprDocumentNewDeleteButton" class="dprDocumentUploadBtn close"
						                    aria-label="Close" onclick="deleteFile('dprDocumentNewPreviewContainer', 'licenseDoc')">
						                    <span aria-hidden="true" class="text-danger"><em class="bi bi-x-circle-fill"></em></span>
						                </button>
									  </div>
									</div>
									<p class="error-container" id="dpr_doc-error"></p>
                         </div>
                        <!-- Additional Field  -->
                        <div class="mb-3">
                            <button type="button" class="form-control" name="show-booking-summary" id="show-booking-summary"><liferay-ui:message key="show-booking-summary" /></button>
                            <button type="button" class="form-control d-none" name="hide-booking-summary" id="hide-booking-summary"><liferay-ui:message key="hide-booking-summary" /></button>
                        </div>
                   
                    <!-- Booking Summary -->
					<div class="booking-summary d-none">
						<h6 class="fw-bold mb-3"><liferay-ui:message key="booking-summary" /></h6>
						<div id="bookingSummary" class="booking-text">
							<p class="mb-1">
								<liferay-ui:message key="facility" />: <strong><span id="facilitySelected"></span></strong>
							</p>
							<p class="mb-1">
								<liferay-ui:message key="booking-for" />: <strong><span id="facilityBookingFor"></span></strong>
							</p>
							<p class="mb-1">
								<liferay-ui:message key="type" />: <strong><span id="subscriptionSelected"></span></strong>
							</p>
							<p class="mb-1">
								<liferay-ui:message key="date" />: <strong><span id="dateSelected"></span></strong>
							</p>
							<p class="mb-1" id="timeP"><liferay-ui:message key="time" />: <span id="timeSelected"></span></p><!-- for hourly -->
							<p class="mb-1" id="durationP"><liferay-ui:message key="duration" />: <span id="durationSelected"></span></p><!-- for monthly -->
							<hr>
							<p class="mb-0">
								<strong><liferay-ui:message key="total-amount" />: <span id="amountSelected"></span></strong>
							</p>
						</div>
					</div>
				</div>
                <div class="card-footer">
                    <button type="button" class="btn btn-secondary" id="cancelPopup" data-bs-dismiss="modal"><liferay-ui:message key="cancel" /></button>
                    <button type="button" class="btn btn-primary" id="confirmBookingBtn"><liferay-ui:message key="confirm-booking" /></button>
                </div>
            </div>
        </div>
        </form>
    </div>
</div>
</div>    
</div>    
    
<!-- Bootstrap 5 JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    
<script>
let selectedDate = new Date();
let currentMonth = new Date();



//Single file upload
	function handleFileUpload(event, id, filePreviewContainer, filePreviewLink, deleteBtn) {
  
	    $("#dprDocPath").val(0);
  
	    const fileInput = event.target;
	    const file = fileInput.files[0]; // Get the uploaded file
	    const previewContainer = document.getElementById(filePreviewContainer);
	    const previewLink = document.getElementById(filePreviewLink);
	    const deleteButton = document.getElementById(deleteBtn);

	    previewContainer.classList.add('d-none');
	    previewContainer.classList.remove('d-flex');
	    previewLink.textContent = '';
	    previewLink.href = '';
	    deleteButton.dataset.filename = '';
	    
	    if (file && $('#' + id).val() !== '' && (typeof $('#' + id).valid === 'function' ? $('#' + id).valid() : true)) {   
	        const fileName = file.name;

	        previewContainer.classList.remove('d-none');
	        previewContainer.classList.add('d-flex');

	        previewLink.textContent = fileName;
	        previewLink.href = URL.createObjectURL(file); 
	        previewLink.target = "_blank";
	        
	        Object.assign(previewLink.style, {
	            textDecoration: "none",
	           // wordWrap: "break-word",
	           // whiteSpace: "normal",
	          //  overflow: "hidden",
	          //  maxWidth: "200px"
	        });

	        deleteButton.dataset.filename = fileName; // Store file name in button dataset
	    }
	}
	
	function deleteFile(filePreviewContainer,id) {
	    const previewContainer = document.getElementById(filePreviewContainer);
	    const fileInput = document.getElementById(id);

	    fileInput.value = "";
		$(".custom-file-input").siblings(".custom-file-label").addClass("selected").html(" <liferay-ui:message key='choose-file' />"); 
	    previewContainer.classList.add('d-none');
	    previewContainer.classList.remove('d-flex');
	}

// Initialize
document.addEventListener('DOMContentLoaded', function() {
    initializeCalendar();
});


function deleteBooking(bookingId){
	if (!confirm('Are you sure you want to cancel this booking?')) return;
	if(bookingId>0){
		$.ajax({
			type: "POST",
			datatype:"json",
	        url: '${cancelBookingURL}', 
	        data: {
	        	bookingId:bookingId 
	        },
			async : false,
	        success: function(data) {
	            	console.log("inside  cancel booking succeess :: "+data);
	            	var response=JSON.parse(data);
	            	if(response.message=="success"){
	            		 location.reload();
	            	}
	        },error:function(resp){
	        	console.log("inside  cancel booking error :: ");
	        }
		});
	}
	
	
   //showToast('Booking Cancelled', 'Your booking has been cancelled successfully.', 'info');
}  


 $(document).ready(function(){
    	   console.log("Document Ready:::");
    	   
    	   $('#facility-type').change(function(){
    		   console.log("facility-type change function");
    		   var selectedFacilityType=$(this).val();	
    		   console.log("selectedFacilityType :::" +selectedFacilityType);
    		   if(selectedFacilityType){
    			   if(selectedFacilityType=='Division'){
        			   $('.divisiondiv').removeClass('d-none'); 
        			   
        			   $('.complexdiv').addClass('d-none'); 
        			   $('.districtdiv').addClass('d-none'); 
        			   $('.talukadiv').addClass('d-none'); 
        			   $('#division').prop('selectedIndex',0);
        			   $('#district').prop('selectedIndex',0);
        			   $('#taluka').prop('selectedIndex',0);
        			   $('#facilitiesGrid').html('').addClass('d-none');
        		   }else if(selectedFacilityType=='District'){
        			   $('.divisiondiv').removeClass('d-none'); 
        			   $('.districtdiv').removeClass('d-none');
        			   $('.complexdiv').addClass('d-none');
        			   $('.talukadiv').addClass('d-none'); 
        			   $('#division').prop('selectedIndex',0);
        			   $('#district').prop('selectedIndex',0);
        			   $('#taluka').prop('selectedIndex',0);
        			   $('#facility-location').prop('selectedIndex',0);
        			   $('#facilitiesGrid').html('').addClass('d-none');
        		   }else if(selectedFacilityType=='Taluka'){
        			   $('.divisiondiv').removeClass('d-none'); 
        			   $('.districtdiv').removeClass('d-none'); 
        			   $('.talukadiv').removeClass('d-none');
        			   $('.complexdiv').addClass('d-none');
        			   $('#division').prop('selectedIndex',0);
        			   $('#district').prop('selectedIndex',0);
        			   $('#taluka').prop('selectedIndex',0);
        			   $('#facility-location').prop('selectedIndex',0);
        			   $('#facilitiesGrid').html('').addClass('d-none');
        		   }
    		   }else{
    			   $('.divisiondiv').addClass('d-none'); 
    			   $('.districtdiv').addClass('d-none'); 
    			   $('.talukadiv').addClass('d-none'); 
    			   $('.complexdiv').addClass('d-none');
    			   $('#division').prop('selectedIndex',0);
    			   $('#district').prop('selectedIndex',0);
    			   $('#taluka').prop('selectedIndex',0);
    			   $('#facility-location').prop('selectedIndex',0);
    			   $('#facilitiesGrid').html('').addClass('d-none');
    		   }
    	   });
    	   
    	   
    	   
    	 //change event of division
   		$('#division').change(function(e){
   			console.log("Division change function ::::");
   			var id=$(this).val();
   			console.log("division id :::"+id);
   			
   			var facilitytypeSelected=$("#facility-type").val();
   			console.log("facilitytypeSelected:::"+facilitytypeSelected);
   			
   			var fetch='';
   			if(facilitytypeSelected=="Division" && facilitytypeSelected!=''){
   				fetch='complex'
   			}else if((facilitytypeSelected=="District" || facilitytypeSelected=="Taluka") && facilitytypeSelected!=''){
   				fetch='District'
   			}
   			console.log("fetch ::"+fetch);
   			if(id!=null && id>0){
   				document.getElementById("division-error").textContent = "";
   				$.ajax({
   	     			type: "POST",
   	     			datatype:"json",
   	     	        url: '${getDistrictByDivisionURL}', 
   	     	        data: {
   	     	        	divisionId:id,
   	     	        facilityLevel:facilitytypeSelected,
   	     	    			fetch:fetch
   	     	        },
   	     			async : false,
   	     	        success: function(data) {
   	     	            	console.log("inside  division succeess :: "+data);
   	     	            	var response=JSON.parse(data);
   	     	            	
   	     	            	if(fetch=='District'){
	   	     	            	if(response!=null && response.length>0){
	   	     	            		var distrivchtml="";
	   	     	            		$.each(response,function(k,v){
	   	     	            			//console.log("k::",k);
	   	     	            			//console.log("v::",v);
	   	     	            			distrivchtml=distrivchtml+'<option value="'+v.id+'">'+v.name+'</option>'
	   	     	            		});
	   	     	            		$('#district').html('').append('<option value=""><liferay-ui:message key="select-district" /></option>').append(distrivchtml);
	   	     	            		$('#facility-location').html('').append('<option value=""><liferay-ui:message key="select-complex" /></option>');
	   	     	            	 	$('#facilitiesGrid').html('').addClass('d-none');
	   	     	            	}else{
		   	     	            	$('#district').html('').append('<option value=""><liferay-ui:message key="select-district" /></option>').append(distrivchtml);
	   	     	            		$('#facility-location').html('').append('<option value=""><liferay-ui:message key="select-complex" /></option>');
	   	     	            	 	$('#facilitiesGrid').html('').addClass('d-none');
	   	     	            	}
   	     	            	}else if(fetch=='complex'){
   	     	            		$('.complexdiv').removeClass('d-none');
   	     	            	var response=JSON.parse(data);
   	     	            	console.log("inside  response.length :: "+response.length);
   	     	            	
   	     	            		if(response!=null && response.length>0){
   	     	            			var facilityhtml="";
   	     	            			$.each(response,function(k,v){
   	     	            			facilityhtml=facilityhtml+'<option value="'+v.name+'">'+v.name+'</option>'
   	     	            			});
   	     	            			$('#facility-location').html('').append('<option value=""><liferay-ui:message key="select-complex" /></option>').append(facilityhtml);
   	     	            			$('#facilitiesGrid').html('').addClass('d-none');
   	     	            		}else{
   	     	            			$('#district').html('').append('<option value=""><liferay-ui:message key="select-district" /></option>');
   	     	            			$('#facility-location').html('').append('<option value=""><liferay-ui:message key="select-complex" /></option>');
   	     	            			$('#facilitiesGrid').html('').addClass('d-none');
   	     	            		}
   	     	            	}
   	     	        },error:function(resp){
   	     	        	console.log("inside  division error :: ");
   	     	        }
   	     		});
   			}else{
   				var distrivchtml='<option value=""><liferay-ui:message key="select-district" /></option>'
   				$('#district').html('').append(distrivchtml);;
   			}
   		});
    	   
    	
    	 //Change of district get the complex
   		$('#district').change(function(e){
   			console.log("district change function ::::");
   			var id=$(this).val();
   			console.log("district id :::"+id);
   			
   			
   			var facilitytypeSelected=$("#facility-type").val();
   			console.log("facilitytypeSelected:::"+facilitytypeSelected);
   			
   			var fetch='';
   			if((facilitytypeSelected=="District") && facilitytypeSelected!=''){
   				fetch='complex'
   			}else if(facilitytypeSelected=="Taluka" && facilitytypeSelected!=''){
   				fetch='Taluka'
   			}
   			
   			if(id!=null && id>0){
   				document.getElementById("district-error").textContent = "";
   				$.ajax({
   	     			type: "POST",
   	     			datatype:"json",
   	     	        url: '${getFacilitySportsCompexByDistrictURL}', 
   	     	        data: {
   	     	        	districtId:id,
   	     	        	facilityLevel:facilitytypeSelected,
   	     	        	fetch:fetch
   	     	        },
   	     			async : false,
   	     	        success: function(data) {
   	     	            	console.log("inside  facility succeess :: "+data);
   	     	            	console.log("inside  length :: "+data.length);
   	     	            	var response=JSON.parse(data);
   	     	            	console.log("inside  response.length :: "+response.length);
   	     	            if(fetch=='complex'){
		   	     	           	 if(response!=null && response.length>0){
			     	            		var facilityhtml="";
			     	            		$.each(response,function(k,v){
			     	            		facilityhtml=facilityhtml+'<option value="'+v.name+'">'+v.name+'</option>'
			     	            		});
			     	            		$('#facility-location').html('').append('<option value=""><liferay-ui:message key="select-complex" /></option>').append(facilityhtml);
			     	            }else{
			     	            	$('#facility-location').html('').append('<option value=""><liferay-ui:message key="select-complex" /></option>');
			     	            }
		   	     	         $('.complexdiv').removeClass('d-none');    	 
   	     	            }else if(fetch=='Taluka'){
   	     	            	//$().removeClass();
	   	     	            	if(response!=null && response.length>0){
		     	            		var talukaHtml="";
		     	            		$.each(response,function(k,v){
		     	            			//console.log("k::",k);
		     	            			//console.log("v::",v);
		     	            			talukaHtml=talukaHtml+'<option value="'+v.id+'">'+v.name+'</option>'
		     	            		});
		     	            		$('#taluka').html('').append('<option value=""><liferay-ui:message key="select-taluka" /></option>').append(talukaHtml);
		     	            	}else{
		     	            		$('#taluka').html('').append('<option value=""><liferay-ui:message key="select-taluka" /></option>');
		     	            	}
   	     	        		$('.talukaDiv').removeClass('d-none');
   	     	            }
   	     	            
   	     	        },error:function(resp){
   	     	        	console.log("inside  facility error :: ");
   	     	        }
   	     		});
   			}else{
   				var distrivchtml='<option value=""><liferay-ui:message key="select-district" /></option>'
   				//$('#district').html('').append(distrivchtml);;
   			}
   		});
    	 
    	 
   		$('#taluka').change(function(e){
   				console.log("taluka change event :::");
   				
   				var talukaId=$(this).val();
   				console.log("selected taluka :::"+talukaId);
   				
   				var facilitytypeSelected=$("#facility-type").val();
   				console.log("facilitytypeSelected taluka :::"+facilitytypeSelected);
   				
   				if(talukaId > 0){
   				 	$('.complexdiv').removeClass('d-none');
   				 //getComplexByTalukaURL
   				 //======================================================================================================================================
   					 $.ajax({
   	     			type: "POST",
   	     			datatype:"json",
   	     	        url: '${getComplexByTalukaURL}', 
   	     	        data: {
   	     	       	 talukaId:talukaId,
   	     	        },
   	     			async : false,
   	     	        success: function(data) {
   	     	            	console.log("inside  facility succeess :: "+data);
   	     	            	//console.log("inside  length :: "+data.length);
   	     	            	var response=JSON.parse(data);
   	     	            	console.log("inside  response.length :: "+response.length);
		   	     	           	 if(response!=null && response.length>0){
			     	            		var facilityhtml="";
			     	            		$.each(response,function(k,v){
			     	            		facilityhtml=facilityhtml+'<option value="'+v.name+'">'+v.name+'</option>'
			     	            		});
			     	            		$('#facility-location').html('').append('<option value=""><liferay-ui:message key="select-complex" /></option>').append(facilityhtml);
			     	            	}else{
			     	            		$('#facility-location').html('').append('<option value=""><liferay-ui:message key="select-complex" /></option>');
			     	            	}
		   	     	         $('.complexdiv').removeClass('d-none');    	 
   	     	        },error:function(resp){
   	     	        	console.log("inside  facility error :: ");
   	     	        }
   	     		});
   				 //======================================================================================================================================
   				}else{
   				 $('.complexdiv').addClass('d-none');
   				 
   				}
   		});
    	 
    	 
    	//Onchange of complex get the available facility
   		$('#facility-location').change(function(e){
   			console.log("facility-location change function ::::");
   			var complexName=$(this).val();
   			console.log("facility-location value :::"+complexName);
   			var facilitytypeSelected=$("#facility-type").val();
				console.log("facilitytypeSelected taluka :::"+facilitytypeSelected);
   			if(complexName!=null){
   				//document.getElementById("district-error").textContent = "";
   				$.ajax({
   	     			type: "POST",
   	     			datatype:"json",
   	     	        url: '${getFacilityBySportsComplexURL}', 
   	     	        data: {
   	     	        	facilityComplexName:complexName,
   	     	       	 facilitytypeSelected:facilitytypeSelected
   	     	        	
   	     	        },
   	     			async : false,
   	     	        success: function(data) {
   	     	            	console.log("inside  facility succeess :: "+data);
   	     	            	var response=JSON.parse(data);
   	     	            	
   	     	            	console.log("response :::"+response);
   	     	            	
   	     	            	if(response!=null && response.length>0){
	   	     	            	var facilityHtml="";
   	     	            		
   	     	            		$.each(response,function(k,v){
	   	     	            			console.log("k::"+k);
	   	     	            			console.log("v::"+v);
	   	     	            			console.log("v.imageUrl::"+v.imageUrl);
	   	     	            			
	   	     	            			//temp showing 1 image
	   	     	            			var image=v.imageUrl;
	   	     	            			
	   	     	            			console.log("image ::::" +image);
	   	     	            			
	   	     	            			var previewURL='';
	   	     	            			if(image.length>0 && (image[0].previewURL!='' || image[0].previewURL!=null)){
	   	     	            				previewURL=image[0].previewURL;
	   	     	            			}
	   	     	            			
	   	     	            			
	   	     	            		facilityHtml=facilityHtml+'<div class="col-md-6 col-lg-4">'+
								   	                         	'<input type="hidden" name="facilityName" id="facilityName_'+v.id+'" value="'+v.name+'">'+
								   	                         	'<input type="hidden" name="facilityCourt" id="facilityCourt_'+v.id+'" value="'+v.court+'">'+
								   	                         	'<input type="hidden" name="imageUrl" id="imageUrl_'+v.id+'" value="'+v.imageUrl+'">'+
								   	                         	'<input type="hidden" name="assosicationHourlyFees" id="assosicationHourlyFees_'+v.id+'" value="'+v.assosicationHourlyFees+'">'+
								   	                         	'<input type="hidden" name="assosicationDailyFees" id="assosicationDailyFees_'+v.id+'" value="'+v.assosicationDailyFees+'">'+
								   	                         	'<input type="hidden" name="assosicationMonthlyFees" id="assosicationMonthlyFees_'+v.id+'" value="'+v.assosicationMonthlyFees+'">'+
								   	                         	'<input type="hidden" name="otherSportsHourlyFees" id="otherSportsHourlyFees_'+v.id+'" value="'+v.otherSportsHourlyFees+'">'+
								   	                         	'<input type="hidden" name="otherSportsDailyFees" id="otherSportsDailyFees_'+v.id+'" value="'+v.otherSportsDailyFees+'">'+
								   	                         	'<input type="hidden" name="otherSportsMonthlyFees" id="otherSportsMonthlyFees_'+v.id+'" value="'+v.otherSportsMonthlyFees+'">'+
								   	                         	'<input type="hidden" name="nonSportsHourlyFees" id="nonSportsHourlyFees_'+v.id+'" value="'+v.nonSportsHourlyFees+'">'+
								   	                         	'<input type="hidden" name="nonSportsDailyFees" id="nonSportsDailyFees_'+v.id+'" value="'+v.nonSportsDailyFees+'">'+
								   	                         	'<input type="hidden" name="nonSportsMonthlyFees" id="nonSportsMonthlyFees_'+v.id+'" value="'+v.nonSportsMonthlyFees+'">'+
								   	                         	'<input type="hidden" name="indevidualHourlyFees" id="indevidualHourlyFees_'+v.id+'" value="'+v.indevidualHourlyFees+'">'+
								   	                         	'<input type="hidden" name="indevidualDailyFees" id="indevidualDailyFees_'+v.id+'" value="'+v.indevidualDailyFees+'">'+
								   	                         	'<input type="hidden" name="indevidualMonthlyFees" id="indevidualMonthlyFees_'+v.id+'" value="'+v.indevidualMonthlyFees+'">'+
								   	                         	'<input type="hidden" name="acFees" id="acFees_'+v.id+'" value="'+v.acFees+'">'+
								   	                         	'<input type="hidden" name="arenaLightFees" id="arenaLightFees_'+v.id+'" value="'+v.arenaLightFees+'">'+
	   	     	            									'<div class="card facility-card">'+
								   	                             '<div class="position-relative">'+
								   	                                '<img src="'+previewURL+'" class="facility-image card-img-top" alt="'+v.name+'">'+
								   	                             	'</div>'+
								   	                            ' <div class="card-body">'+
								   	                                '<h5 class="card-title">'+v.name+'</h5>'+
								   	                                 '<p class="card-text text-muted">'+v.courtNameNumber+'</p>'+
								   	                                 /* '<p class="card-text text-muted">'+v.court+'</p>'+ */
								   	                                 /* '<div class="info-item">'+
								   	                                    ' <i class="bi bi-people-fill"></i>'+
								   	                                    ' <span>Capacity: 20 people</span>'+
								   	                                ' </div>'+ */
								   	                                 /* '<div class="info-item">'+
								   	                                   '  <i class="bi bi-clock-fill"></i>'+
								   	                                   '  <span>$45/hour</span>'+
								   	                                ' </div>'+
								   	                                 '<div class="info-item">'+
								   	                                    ' <i class="bi bi-calendar-month-fill"></i>'+
								   	                                    ' <span>$2500/month</span>'+
								   	                                ' </div>'+ */
								   	                            ' </div>'+
								   	                             '<div class="card-footer">'+
								   	                                ' <button class="btn btn-primary w-100" onclick="openBookingModal('+v.id+')"><liferay-ui:message key="book-now" /></button>'+
								   	                             '</div>'+
								   	                         '</div>'+
								   	                     '</div>';
	   	     	           		 });
   	     	            	}
   	     	            	$('#facilitiesGrid').html('').append(facilityHtml).removeClass("d-none");
   	     	        },error:function(resp){
   	     	        	console.log("inside  facility error :: ");
   	     	        }
   	     		});
   			}else{
   				var distrivchtml='<option value=""><liferay-ui:message key="select-district" /></option>'
   				$('#district').html('').append(distrivchtml);;
   			}
   		});
    	   
    	   
    	$(document).on('click','.btn-close',function(){
    		console.log("close modal cicked");
    		$('#bookingModal').modal('toggle');
             $('.modal-backdrop').remove();
             setTimeout(function () {
            			 $('#bookingModal').modal('hide'); 
            		 }, 500);
    	});
    	
    	$(document).on('click','#cancelPopup',function(){
    		console.log("close modal cicked");
    		$('#bookingModal').modal('toggle');
             $('.modal-backdrop').remove();
             setTimeout(function () {
            			 $('#bookingModal').modal('hide'); 
            		 }, 500);
    	});
    	
    	
   	//Confirm booking
   	$(document).on('click','#confirmBookingBtn',function(e){
	    		console.log("confirm booking  clicked :::::");
	    		var errorMessage=[];
	    		var bookingType=$('.bookingType').find('.active').attr("id");
	    		
	    		//calculate booking
	    		calculateBooking();
	    		
	    		var seledate=selectedDate.toISOString();
	    		var bookingType=$('.bookingType').find('.active').attr("id");
	    		
	    		console.log("bookingType ::::"+bookingType);
	    		console.log("seledate ::::"+seledate);
	    		
	    		 const form = document.getElementById("bookingfm");	
	    		 const formData = new FormData(form); 
	    		 formData.append("bookingDate",seledate);
	    		 formData.append("bookingType",bookingType);
	    		 //formData.append("isAcHourlyChecked",isAcHourlyChecked);
	    		 
				//saveFacilityBookingURL
				if(bookingType == "hourly-tab"){
					
					errorMessage=validateHourlyTab(errorMessage);
					
					
				}else if(bookingType == "daily-tab"){
					errorMessage=validateDailyTab(errorMessage);
				}else if(bookingType == "monthly-tab"){
					errorMessage=validateMonthlyTab(errorMessage);
				}				
				
				console.log("errorMessage :::"+errorMessage);
				//e.preventDefault();
				
				if(errorMessage.length==0){
					$.ajax({
		 		        type: "POST",
		 		        url: "${saveFacilityBookingURL}",
		 		        data: formData,
		 		        contentType : false,
		 				cache : false,
		 				processData : false,
		 		        success: function(data){
				 		    console.log("Data ::::"+data);   
		 		        	
		 		        	/*  if (data === "success") {
				 		            var msg = '<span class="text-success"><liferay-ui:message key="details-submitted-successfully"/></span>';
				 		            if(mode == "edit"){
				 		            	msg = '<span class="text-success"><liferay-ui:message key="the-details-are-updated-successfully"/></span>';
				 		            }
				 		            $('#success-message').html(msg);
				 		            $('#submitBtn').prop('disabled', true);
				 		            $("#saveConstructionModal").modal('show');
				 		        } else {
				 		            var msg = '<span class="text-danger"><liferay-ui:message key="the-details-are-failed-to-submit"/></span>';
				 		            $('#success-message').html(msg);
				 		            $("#saveConstructionModal").modal('show');
				 		        } */
				 		   	location.reload();
		 		    	 }
		 		    });
				}else{
					e.preventDefault();
				}
	    	});
    	
    		
   			//Show booking button event
			$('#show-booking-summary').click(function(){
				
				calculateBooking();
				
   				$('.booking-summary').removeClass('d-none');
   				$('#show-booking-summary').addClass("d-none");
   				$('#hide-booking-summary').removeClass("d-none");
   			});
   			
   			$('#hide-booking-summary').click(function(){
   				$('.booking-summary').addClass('d-none');
   				$('#show-booking-summary').removeClass("d-none");
   				$('#hide-booking-summary').addClass("d-none");
   			});
    	   
   			
   			
   			$(document).on('keyup','#customerEmail',function(){
   				var pattern = /^\b[A-Z0-9._%-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b$/i;
   				var emailValue=$(this).val();
   				if(emailValue){
   					if(!pattern.test(emailValue)){
   						document.getElementById("customerEmail-error").textContent ='<liferay-ui:message key="please-enter-a-valid-email" />';
   					}else{
   						document.getElementById("customerEmail-error").textContent ='';
   					}
   				}else{
   					document.getElementById("customerEmail-error").textContent ='<liferay-ui:message key="please-enter-email" />';
   				}
   			});
   			
   			//Time change function 
   			$('#startTime').change(function(){
   				var startTime=$(this).val();
   				console.log("startTime :::"+startTime);
   				if(startTime){
   					var start = parseInt(startTime.split(':')[0]);
   					console.log("start ::::"+start);
   					var endHtml="";
   					for(var i=start+1;i<=22;i++){
   						endHtml=endHtml+'<option value="'+i+':00">'+i+':00</option>';
   					}
   					$('#endTime').html('').append('<option value=""><liferay-ui:message key="select" /></option>').append(endHtml);
   				}else{
   					$('#endTime').html('').append('<option value=""><liferay-ui:message key="select" /></option>');
   				}
   				
   			});
   			
   			
   			
   			
       });
       
       function validateDailyTab(errorMessage){
    	   console.log("inside validateDailyTab :");
    	   
    	   var BookingFor=$("#dayBookingFor").val();
		   if(!BookingFor){
    		   document.getElementById("dayBookingFor-error").textContent = '<liferay-ui:message key="please-select-booking-for" />';
    		   errorMessage.push('<liferay-ui:message key="select-booking-for" />');
    		   $('#dayBookingFor').focus();
    	   }else{
    		   document.getElementById("dayBookingFor-error").textContent = '';
    	   }
		   
		   var nofodays=$("#nofodays").val();
		   if(!nofodays){
    		   document.getElementById("nofodays-error").textContent = '<liferay-ui:message key="please-select-no-of-days" />';
    		   errorMessage.push('<liferay-ui:message key="please-select-no-of-days" />');
    		   $('#nofodays').focus();
    	   }else{
    		   document.getElementById("nofodays-error").textContent = '';
    	   }
    	   
    	   var customerName=$("#customerName").val();
		   if(!customerName){
    		   document.getElementById("customerName-error").textContent = '<liferay-ui:message key="please-enter-name" />';
    		   errorMessage.push('<liferay-ui:message key="please-enter-name" />');
    		   $('#customerName').focus();
    	   }else{
    		   document.getElementById("customerName-error").textContent = '';
    	   }
		   
		   
		   var customerEmail=$("#customerEmail").val();
		   if(!customerEmail){
    		   document.getElementById("customerEmail-error").textContent = '<liferay-ui:message key="please-enter-email" />';
    		   errorMessage.push('<liferay-ui:message key="please-enter-email" />');
    		   $('#customerEmail').focus();
    	   }else{
    		   document.getElementById("customerEmail-error").textContent = '';
    	   }
		   
		   var customerPhone=$("#customerPhone").val();
		   if(!customerPhone){
    		   document.getElementById("customerPhone-error").textContent = '<liferay-ui:message key="please-enter-contact" />';
    		   errorMessage.push('<liferay-ui:message key="please-enter-email" />');
    		   $('#customerPhone').focus();
    	   }else{
    		   document.getElementById("customerPhone-error").textContent = '';
    	   }
		   
		   
		   var bookingFacilityName=$('#bookingFacilityName').val();
    	   if(bookingFacilityName.toLowerCase().startsWith('shooting')){
    		   validateDocument(errorMessage);
    	   }
		   
		   
    	return errorMessage;   
       
       }
       
		function validateMonthlyTab(errorMessage){
			 console.log("inside validateMonthlyTab :");
			 var BookingFor=$("#monthBookingFor").val();
			   if(!BookingFor){
	    		   document.getElementById("monthBookingFor-error").textContent = '<liferay-ui:message key="please-select-booking-for" />';
	    		   errorMessage.push('<liferay-ui:message key="select-booking-for" />');
	    		   $('#monthBookingFor').focus();
	    	   }else{
	    		   document.getElementById("monthBookingFor-error").textContent = '';
	    	   }
			   
			   var noofmonth=$("#noofmonth").val();
			   if(!noofmonth){
	    		   document.getElementById("noofmonth-error").textContent = '<liferay-ui:message key="please-select-no-of-months" />';
	    		   errorMessage.push('<liferay-ui:message key="please-select-no-of-days" />');
	    		   $('#noofmonth').focus();
	    	   }else{
	    		   document.getElementById("noofmonth-error").textContent = '';
	    	   }
			 
			 var customerName=$("#customerName").val();
			   if(!customerName){
	    		   document.getElementById("customerName-error").textContent = '<liferay-ui:message key="please-enter-name" />';
	    		   errorMessage.push('<liferay-ui:message key="please-enter-name" />');
	    		   $('#customerName').focus();
	    	   }else{
	    		   document.getElementById("customerName-error").textContent = '';
	    	   }
			   
			   
			   var customerEmail=$("#customerEmail").val();
			   if(!customerEmail){
	    		   document.getElementById("customerEmail-error").textContent = '<liferay-ui:message key="please-enter-email" />';
	    		   errorMessage.push('<liferay-ui:message key="please-enter-email" />');
	    		   $('#customerEmail').focus();
	    	   }else{
	    		   document.getElementById("customerEmail-error").textContent = '';
	    	   }
			   
			   var customerPhone=$("#customerPhone").val();
			   if(!customerPhone){
	    		   document.getElementById("customerPhone-error").textContent = '<liferay-ui:message key="please-enter-contact" />';
	    		   errorMessage.push('<liferay-ui:message key="please-enter-email" />');
	    		   $('#customerPhone').focus();
	    	   }else{
	    		   document.getElementById("customerPhone-error").textContent = '';
	    	   }
			   
			   var bookingFacilityName=$('#bookingFacilityName').val();
	    	   if(bookingFacilityName.toLowerCase().startsWith('shooting')){
	    		   validateDocument(errorMessage);
	    	   }
	    	return errorMessage;   
       }
       
       function validateHourlyTab(errorMessage){
    	   console.log("inside validateHourlyTab :");
    	   var startTime=$("#startTime").val();
    	   var bookingFacilityName=$('#bookingFacilityName').val();
    	   console.log("startTime ::" +startTime);
    	   
    	   console.log("bookingFacilityName ===========================::" +bookingFacilityName);
    	   if(bookingFacilityName.toLowerCase().startsWith('shooting')){
    		   //validate  document as well
    		   console.log("validate document ================================");
    		   validateDocument(errorMessage);
    	   }
    	   
    	   if(!startTime){
    		   document.getElementById("startTime-error").textContent = '<liferay-ui:message key="select-start-time" />';
    		   errorMessage.push('<liferay-ui:message key="select-start-time" />');
    		   $('#startTime').focus();
    	   }else{
    		   document.getElementById("startTime-error").textContent = '';
    	   }
    	   
    	   
		   var endTime=$("#endTime").val();
		   if(!endTime){
    		   document.getElementById("endTime-error").textContent = '<liferay-ui:message key="select-end-time" />';
    		   errorMessage.push('<liferay-ui:message key="select-end-time" />');
    		   $('#endTime').focus();
    	   }else{
    		   document.getElementById("endTime-error").textContent = '';
    	   }
		   
		   var BookingFor=$("#BookingFor").val();
		   if(!BookingFor){
    		   document.getElementById("BookingFor-error").textContent = '<liferay-ui:message key="please-select-booking-for" />';
    		   errorMessage.push('<liferay-ui:message key="select-booking-for" />');
    		   $('#BookingFor').focus();
    	   }else{
    		   document.getElementById("BookingFor-error").textContent = '';
    	   }
		   
		   var customerName=$("#customerName").val();
		   if(!customerName){
    		   document.getElementById("customerName-error").textContent = '<liferay-ui:message key="please-enter-name" />';
    		   errorMessage.push('<liferay-ui:message key="please-enter-name" />');
    		   $('#customerName').focus();
    	   }else{
    		   document.getElementById("customerName-error").textContent = '';
    	   }
		   
		   
		   var customerEmail=$("#customerEmail").val();
		   if(!customerEmail){
    		   document.getElementById("customerEmail-error").textContent = '<liferay-ui:message key="please-enter-email" />';
    		   errorMessage.push('<liferay-ui:message key="please-enter-email" />');
    		   $('#customerEmail').focus();
    	   }else{
    		   document.getElementById("customerEmail-error").textContent = '';
    	   }
		   
		   var customerPhone=$("#customerPhone").val();
		   if(!customerPhone){
    		   document.getElementById("customerPhone-error").textContent = '<liferay-ui:message key="please-enter-contact" />';
    		   errorMessage.push('<liferay-ui:message key="please-enter-email" />');
    		   $('#customerPhone').focus();
    	   }else{
    		   document.getElementById("customerPhone-error").textContent = '';
    	   }
    	return errorMessage;   
       }
       
       
       function validateDocument(errorMessage){
    	   console.log("Validate documet called :::");
    		var dprDocs=$("#licenseDoc")[0].files[0];
    		var fileValue=$('#dprDocumentPreviewLink').text();
    	   
    		if(dprDocs){
			 	//console.log("dprDocs:::" +dprDocs);
				var dprdoc=$('#licenseDoc')[0];
				var dprdocSize = $("#licenseDoc")[0].files[0].size;
				var dprdoclength=$('#licenseDoc')[0].files.length;
				 var maxSize = 2*1024*1024; // 2 MB
				 //console.log("dprdocSize 2:::" +dprdocSize);
				 //console.log("maxSize> :::" +dprdocSize>maxSize);
				var allowedExtensions = /(\.pdf)$/i;
			
			 if(dprdoclength==0){
		        	//console.log("inside if dpr");
		        	document.getElementById("dpr_doc-error").textContent = "<liferay-ui:message key='please-upload-license' />";
		    		errorMessage.push("<liferay-ui:message key='please-upload-license' />");
		    		$(this).focus();
		        }else if (!allowedExtensions.exec(dprdoc.files[0].name)) {
		        	//console.log("inside else  if dpr");
		        	document.getElementById("dpr_doc-error").textContent = "<liferay-ui:message key='please-select-pdf-file-only' />";
		    		errorMessage.push("<liferay-ui:message key='please-select-pdf-file-only' />");
		    		
		        }else if (dprdocSize>maxSize) {
		        	//console.log("inside else  if dpr");
		        	document.getElementById("dpr_doc-error").textContent = "<liferay-ui:message key='select-document-size-less-than-2-mb' />";
		    		errorMessage.push("<liferay-ui:message key='select-document-size-less-than-2-mb' />");
		        }else{
		        	document.getElementById("dpr_doc-error").textContent = "";
		        }
			}else{
				document.getElementById("dpr_doc-error").textContent = "<liferay-ui:message key='please-upload-license' />";
	    		errorMessage.push("<liferay-ui:message key='please-upload-license' />");
	    		$(this).focus();
			}
    		
    		
       }
       
       
       
       
       // Open Booking Modal
       function openBookingModal(facilityId) {
    	   var facilityName=$('#facilityName_'+facilityId).val();
    	   var facilityCourt=$('#facilityCourt_'+facilityId).val();
    	   var assosicationHourlyFees=$('#assosicationHourlyFees_'+facilityId).val();
    	   var assosicationDailyFees=$('#assosicationDailyFees_'+facilityId).val();
    	   var assosicationMonthlyFees=$('#assosicationMonthlyFees_'+facilityId).val();
    	   var otherSportsHourlyFees=$('#otherSportsHourlyFees_'+facilityId).val();
    	   var otherSportsDailyFees=$('#otherSportsDailyFees_'+facilityId).val();
    	   var otherSportsMonthlyFees=$('#otherSportsMonthlyFees_'+facilityId).val();
    	   var nonSportsHourlyFees=$('#nonSportsHourlyFees_'+facilityId).val();
    	   var nonSportsDailyFees=$('#nonSportsDailyFees_'+facilityId).val();
    	   var nonSportsMonthlyFees=$('#nonSportsMonthlyFees_'+facilityId).val();
    	   var indevidualHourlyFees=$('#indevidualHourlyFees_'+facilityId).val();
    	   var indevidualDailyFees=$('#indevidualDailyFees_'+facilityId).val();
    	   var indevidualMonthlyFees=$('#indevidualMonthlyFees_'+facilityId).val();
    	   var acFees=$('#acFees_'+facilityId).val();
    	   var arenaLightFees=$('#arenaLightFees_'+facilityId).val();
    	   
    	   
    	   $('.booking-summary').addClass('d-none');
			$('#show-booking-summary').removeClass("d-none");
			$('#hide-booking-summary').addClass("d-none");
    	   
    	   
    	   
    	   if(facilityName.toLowerCase().startsWith('shooting')){
    		   $('.licenseDocCls').removeClass('d-none');
    		   $('.ammunitionlicenseCls').removeClass('d-none');
    	   }else{
    		   $('.ammunitionlicenseCls').addClass('d-none');
    		   $('.licenseDocCls').addClass('d-none');
    	   }
    	   
    	   
    	   console.log("selected facilityName ::" +facilityName);
    	   
    	   $("#facilityLevelVal").val($('#facility-type').val());
    	   $("#divisionVal").val($('#division').val());
    	   $("#districtVal").val($('#district').val());
    	   $("#talukaVal").val($('#taluka').val());
    	   $('#bookingModalLabel').text(facilityName);
    	   $("#bookingFacilityId").val(facilityId);
    	   $("#bookingFacilityName").val(facilityName);
    	   $("#bookingFacilityCourt").val(facilityCourt);
    	   $("#bookingAssosicationHourlyFees").val(assosicationHourlyFees);
    	   $("#bookingAssosicationDailyFees").val(assosicationDailyFees);
    	   $("#bookingAssosicationMonthlyFees").val(assosicationMonthlyFees);
    	   $("#bookingOtherSportsHourlyFees").val(otherSportsHourlyFees);
    	   $("#bookingOtherSportsDailyFees").val(otherSportsDailyFees);
    	   $("#bookingOtherSportsMonthlyFees").val(otherSportsMonthlyFees);
    	   $("#bookingNonSportsHourlyFees").val(nonSportsHourlyFees);
    	   $("#bookingNonSportsDailyFees").val(nonSportsDailyFees);
    	   $("#bookingNonSportsMonthlyFees").val(nonSportsMonthlyFees);
    	   $("#bookingIndividualHourlyFees").val(indevidualHourlyFees);
    	   $("#bookingIndividualDailyFees").val(indevidualDailyFees);
    	   $("#bookingIndividualMonthlyFees").val(indevidualMonthlyFees);
    	   $("#bookingACFees").val(acFees);
    	   $("#bookingArenaLightFees").val(arenaLightFees);
    	   
    	   $('#arenalights-hourly').prop("checked",false);
    	   $('#ac-hourly').prop("checked",false);
    	   $('#arenalights-daily').prop("checked",false);
    	   $('#ac-daily').prop("checked",false);
    	   $('#arenalights-monthly').prop("checked",false);
    	   $('#ac-monthly').prop("checked",false);
    	   
    	   
    	   //Clear all previous data on model
    	   $('#BookingFor-error').text('');
    	   $('#customerName-error').text('');
    	   $('#customerEmail-error').text('');
    	   $('#customerPhone-error').text('');
    	   $('#dayBookingFor-error').text('');
    	   $('#monthBookingFor-error').text('');
    	   $('#noofmonth-error').text('');
    	   
    	   $('#nofodays-error').text('');
    	   $('#dpr_doc-error').text('');
    	   $('#customerName').val('');
    	   $('#customerEmail').val('');
    	   $('#customerPhone').val('');
    	   $('#dprDocumentNewPreviewContainer').removeClass('d-flex');
    	   $('#dprDocumentNewPreviewContainer').addClass('d-none');
    	   $('#dprDocumentNewPreviewLink').prop('href','');
    	   $(".custom-file-input").siblings(".custom-file-label").addClass("selected").html(" <liferay-ui:message key='choose-file' />"); 
    	   
    	   $('#BookingFor').prop('selectedIndex',0);
    	   $('#dayBookingFor').prop('selectedIndex',0);
    	   $('#monthBookingFor').prop('selectedIndex',0);
    	   $('#noofmonth').prop('selectedIndex',0);
    	   $('#nofodays').prop('selectedIndex',0);
    	   $('#startTime').prop('selectedIndex',0);
    	   $('#endTime').html('').append('<option value=""><liferay-ui:message key="select" /></option>');
    	   
    	   /*   selectedFacility = facilities.find(f => f.id === facilityId);
           if (!selectedFacility) return;
           
           document.getElementById('bookingModalLabel').textContent = `Book ${selectedFacility.name}`;
           
           // Reset form
           document.getElementById('customerName').value = '';
           document.getElementById('customerEmail').value = '';
           document.getElementById('customerPhone').value = '';
           document.getElementById('startTime').value = '09:00';
           document.getElementById('endTime').value = '10:00';
           
           // Reset to hourly tab
           document.getElementById('hourly-tab').click();
           bookingType = 'hourly';
           
           // Reset date to today
           selectedDate = new Date();
           currentMonth = new Date();
           initializeCalendar();
           
           updateBookingSummary(); */
           // Reset date to today
           selectedDate = new Date();
           currentMonth = new Date();
           initializeCalendar();
           
           var modal = new bootstrap.Modal(document.getElementById('bookingModal'));
           modal.show();
       }
       
       // Initialize Calendar
       function initializeCalendar() {
           console.log("inside initialize calander");
    	   renderCalendar('calendar', currentMonth);
           renderCalendar('calendar-daily', currentMonth);
           renderCalendar('calendar-monthly', currentMonth);
       }
       
       
       
       // Render Calendar
       function renderCalendar(containerId, month) {
           
    	   console.log("inside render calender containerId::"+containerId);
    	   
    	   const container = document.getElementById(containerId);
    	   
    	   
    	   console.log("inside container ::"+container);
    	   
           const year = month.getFullYear();
           const monthIndex = month.getMonth();
           
           const firstDay = new Date(year, monthIndex, 1);
           const lastDay = new Date(year, monthIndex + 1, 0);
           const prevLastDay = new Date(year, monthIndex, 0);
           
           const firstDayOfWeek = firstDay.getDay();
           const lastDate = lastDay.getDate();
           const prevLastDate = prevLastDay.getDate();
           
           const monthNames = ["January", "February", "March", "April", "May", "June",
                             "July", "August", "September", "October", "November", "December"];
           
           var clickfwfn="changeMonth('"+containerId+"', -1)";
           var clickbcfn="changeMonth('"+containerId+"', 1)";
           
           var calendarHTML = '<div class="calendar-header">'+
                   '<button class="btn btn-sm btn-outline-primary" onclick="'+clickfwfn+'">'+
                       '<i class="bi bi-chevron-left"></i>'+
                   '</button>'+
                   '<h6 class="mb-0">'+monthNames[monthIndex]+''+year+'</h6>'+
                   '<button class="btn btn-sm btn-outline-primary" onclick="'+clickbcfn+'">'+
                       '<i class="bi bi-chevron-right"></i>'+
                   '</button>'+
               '</div>'+
               '<div class="calendar-grid">'+
                   '<div class="calendar-weekday">Sun</div>'+
                   '<div class="calendar-weekday">Mon</div>'+
                   '<div class="calendar-weekday">Tue</div>'+
                   '<div class="calendar-weekday">Wed</div>'+
                   '<div class="calendar-weekday">Thu</div>'+
                   '<div class="calendar-weekday">Fri</div>'+
                   '<div class="calendar-weekday">Sat</div>';
           
           // Previous month days
           for (let i = firstDayOfWeek - 1; i >= 0; i--) {
               const day = prevLastDate - i;
               calendarHTML += '<div class="calendar-day other-month">'+day+'</div>';
           }
           
           // Current month days
           const today = new Date();
           today.setHours(0, 0, 0, 0);
           
           for (let day = 1; day <= lastDate; day++) {
               const currentDate = new Date(year, monthIndex, day);
               const isPast = currentDate < today;
               const isSelected = selectedDate.getDate() === day && 
                                selectedDate.getMonth() === monthIndex && 
                                selectedDate.getFullYear() === year;
               
               const classes = ['calendar-day'];
               if (isPast) classes.push('disabled');
               if (isSelected) classes.push('selected');
               
               
               if(isPast){
                   calendarHTML += '<div class="'+classes.join(' ')+'">'+day+'</div>';
               }else{
            	   calendarHTML += '<div class="'+classes.join(' ')+'"  onclick="selectDate('+year+','+monthIndex+','+day+')">'+day+'</div>';
               }
           }
           
           // Next month days
           const remainingDays = 42 - (firstDayOfWeek + lastDate);
           for (let day = 1; day <= remainingDays; day++) {
               calendarHTML += '<div class="calendar-day other-month">'+day+'</div>';
           }
           
           calendarHTML += '</div>';
           container.innerHTML = calendarHTML;
       }
       
    // Change Month
       function changeMonth(containerId, direction) {
           currentMonth = new Date(currentMonth.getFullYear(), currentMonth.getMonth() + direction, 1);
           
           console.log("inside change month direction ::::"+direction);
           console.log("inside change month containerId ::::"+containerId);
           
           renderCalendar(containerId, currentMonth);
       }

       // Select Date
       function selectDate(year, month, day) {
           selectedDate = new Date(year, month, day);
           renderCalendar('calendar', currentMonth);
           renderCalendar('calendar-daily', currentMonth);
           renderCalendar('calendar-monthly', currentMonth);
           //updateBookingSummary();
       }
       
       
       
    // Update Booking Summary
       function updateBookingSummary() {
           //if (!selectedFacility) return;
           const startTime = document.getElementById('startTime').value;
           const endTime = document.getElementById('endTime').value;
           
           let total = 0;
           let timeInfo = '';
           
           if (bookingType === 'hourly') {
               const start = parseInt(startTime.split(':')[0]);
               const end = parseInt(endTime.split(':')[0]);
               const hours = end > start ? end - start : 0;
               total = hours * selectedFacility.hourlyRate;
               timeInfo = '<p class="mb-1">Time: '+startTime+' - '+endTime+'</p>';
           } else {
               total = selectedFacility.monthlyRate;
               timeInfo = '<p class="mb-1">Duration: 1 month from start date</p>';
           }
           
           const dateStr = selectedDate.toLocaleDateString('en-US', { 
               weekday: 'long', 
               year: 'numeric', 
               month: 'long', 
               day: 'numeric' 
           });
           
           document.getElementById('bookingSummary').innerHTML = 
               '<p class="mb-1">Facility: <strong>${selectedFacility.name}</strong></p>'+
               '<p class="mb-1">Type: <strong>'+(bookingType === 'hourly' ? 'Hourly Rental' : 'Monthly Subscription')+'</strong></p>'+
               '<p class="mb-1">Date: <strong>${dateStr}</strong></p>'+timeInfo+'<hr>'+
               '<p class="mb-0"><strong>Total Amount: '+total+'</strong></p>';
       }
    
    
    
    function calculateBooking(){
    	
		    	const dateStr = selectedDate.toLocaleDateString('en-US', { 
		            weekday: 'long', 
		            year: 'numeric', 
		            month: 'long', 
		            day: 'numeric' 
		    	});
				
			var bookingType=$('.bookingType').find('.active').attr("id");
			var bookingFacilityName=$('#bookingFacilityName').val();
			
			console.log("dateStr show button:::"+dateStr);
			console.log("bookingType show button:::"+bookingType);
			
			var startTime=$("#startTime").val();
			var endTime=$("#endTime").val();
			
			
			console.log("startTime:::"+startTime);
			console.log("endTime:::"+endTime);
			var totalAmount=0;
			
			
		 	//calculate the hours for selected type
		 	//var time =
			
		 		
			
			if(bookingType == "hourly-tab"){
				
				var bookingFor=$('#BookingFor').val();
				console.log("bookingFor:::"+bookingFor);
				$("#subscriptionSelected").text("Hourly");
				$("#timeP").removeClass("d-none");
				$("#durationP").addClass("d-none");
				var start = parseInt(startTime.split(':')[0]);
				var  end = parseInt(endTime.split(':')[0]);
			 	var  hours = end > start ? end - start : 0;
			 	console.log("hours:::"+hours);
				 
				if(bookingFor== "Association & Federation"){
					var bookingAssosicationHourlyFees=$('#bookingAssosicationHourlyFees').val();
					totalAmount=hours*bookingAssosicationHourlyFees;
				}else if(bookingFor== "Other Sports Events"){
					var bookingOtherSportsHourlyFees=$('#bookingOtherSportsHourlyFees').val();
					totalAmount=hours*bookingOtherSportsHourlyFees;
				}else if(bookingFor== "Non Sports Events"){
					var bookingNonSportsHourlyFees=$('#bookingNonSportsHourlyFees').val();
					totalAmount=hours*bookingNonSportsHourlyFees;
				}else if(bookingFor== "Individal"){
					var bookingIndividualHourlyFees=$('#bookingIndividualHourlyFees').val();
					totalAmount=hours*bookingIndividualHourlyFees;
				}
				
				console.log("totalAmount in hourly before ac and arena light ::: "+totalAmount);
				
				if($('#arenalights').prop('checked')){
					console.log("Arena light is checked on hourly");
					var bookingArenaLightFees=$('#bookingArenaLightFees').val();
					totalAmount=totalAmount+(hours*bookingArenaLightFees);
				}else{
					console.log("Arena light is not  checked on hourly");
					//totalAmount=totalAmount-(hours*bookingACFees);
				}
				
				if($('#ac-hourly').prop('checked')){
					console.log("ac  is checked on hourly");
					var bookingACFees=$('#bookingACFees').val();
					totalAmount=totalAmount+(hours*bookingACFees);
					$('#isAcHourlyChecked').val(true);
				}else{
					console.log("ac light is not  checked on hourly");
				}
				
				if($('#arenalights-hourly').prop('checked')){
					console.log("arena light  is checked on hourly");
					$('#isArenaLightChecked').val(true);
					var bookingArenaLightFees=$('#bookingArenaLightFees').val();
					totalAmount=totalAmount+(hours*bookingArenaLightFees);
				}else{
					console.log("arena light is not  checked on hourly");
				}
				
				$('#totalFinalAmount').val(totalAmount);
				
				
			}else if(bookingType == "daily-tab"){
				
				console.log("Inside daily booking tab");
				var bookingFor=$('#dayBookingFor').val();
				console.log("bookingFor: day::"+bookingFor);
				$("#subscriptionSelected").text("Daily");
				$("#durationP").removeClass("d-none");
				$("#timeP").addClass("d-none");
				
				var noOfDays=$('#nofodays').val();
				
				console.log("noOfDays :::"+noOfDays);
				
				if(bookingFor== "Association & Federation"){
					var bookingAssosicationDailyFees=$('#bookingAssosicationDailyFees').val();
					totalAmount=noOfDays*bookingAssosicationDailyFees;
					
					console.log("totalAmount in af::" +totalAmount);
				}else if(bookingFor== "Other Sports Events"){
					var bookingOtherSportsDailyFees=$('#bookingOtherSportsDailyFees').val();
					totalAmount=noOfDays*bookingOtherSportsDailyFees;
				}else if(bookingFor== "Non Sports Events"){
					var bookingNonSportsDailyFees=$('#bookingNonSportsDailyFees').val();
					totalAmount=noOfDays*bookingNonSportsDailyFees;
				}else if(bookingFor== "Individal"){
					var bookingIndividualDailyFees=$('#bookingIndividualDailyFees').val();
					totalAmount=noOfDays*bookingIndividualDailyFees;
				}
				
				console.log("totalAmount in daily before ac and arena light ::: "+totalAmount);
				
				if($('#arenalights-daily').prop('checked')){
					console.log("arena light  is checked on arenalights-daily");
					$('#isArenaLightChecked').val(true);
					var bookingArenaLightFees=$('#bookingArenaLightFees').val();
					totalAmount=totalAmount+(noOfDays*24*bookingArenaLightFees);
				}else{
					console.log("arena light is not  checked on arenalights-daily");
				}
				
				
				if($('#ac-daily').prop('checked')){
					console.log("ac  is checked on daily");
					var bookingACFees=$('#bookingACFees').val();
					totalAmount=totalAmount+(noOfDays*24*bookingACFees);
					$('#isAcHourlyChecked').val(true);
				}else{
					console.log("ac light is not  checked on daily");
				}
				
				
				console.log("Final Amount  in daily tab:::" +totalAmount);
				
				$('#totalFinalAmount').val(totalAmount);
				$('#durationSelected').text(noOfDays+" days from select date");
			}else if(bookingType == "monthly-tab"){
					console.log("inside monthly tab");				
					$("#subscriptionSelected").text("Monthly");
					$("#durationP").removeClass("d-none");
					$("#timeP").addClass("d-none");
					
					var bookingFor=$('#monthBookingFor').val();
					console.log("bookingFor: day::"+bookingFor);
					
					 var noofmonth=$('#noofmonth').val();
					 console.log("noofmonth: ::"+noofmonth);
				
				if(bookingFor== "Association & Federation"){
					var bookingAssosicationMonthlyFees=$('#bookingAssosicationMonthlyFees').val();
					totalAmount=noofmonth*bookingAssosicationMonthlyFees;
					
					console.log("totalAmount in af::" +totalAmount);
				}else if(bookingFor== "Other Sports Events"){
					var bookingOtherSportsMonthlyFees=$('#bookingOtherSportsMonthlyFees').val();
					totalAmount=noofmonth*bookingOtherSportsMonthlyFees;
				}else if(bookingFor== "Non Sports Events"){
					var bookingNonSportsMonthlyFees=$('#bookingNonSportsMonthlyFees').val();
					totalAmount=noofmonth*bookingNonSportsMonthlyFees;
				}else if(bookingFor== "Individal"){
					var bookingIndividualMonthlyFees=$('#bookingIndividualMonthlyFees').val();
					totalAmount=noofmonth*bookingIndividualMonthlyFees;
				}
				
				
				console.log("totalAmount in monthly before ac and arena light ::: "+totalAmount);
				
				if($('#arenalights-monthly').prop('checked')){
					console.log("arena light  is checked on arenalights monthly");
					$('#isArenaLightChecked').val(true);
					var bookingArenaLightFees=$('#bookingArenaLightFees').val();
					totalAmount=totalAmount+(noofmonth*30*24*bookingArenaLightFees);
				}else{
					console.log("arena light is not  checked on arenalights-daily");
				}
				
				
				if($('#ac-monthly').prop('checked')){
					console.log("ac  is checked on monthly");
					var bookingACFees=$('#bookingACFees').val();
					totalAmount=totalAmount+(noofmonth*30*24*bookingACFees);
					$('#isAcHourlyChecked').val(true);
				}else{
					console.log("ac light is not  checked on daily");
				}
				$('#totalFinalAmount').val(totalAmount);
				$('#durationSelected').text(noofmonth+" months from start date");
			}
			//calculation based on the purpose of booking
		 	
			$("#facilitySelected").text(bookingFacilityName);
			$("#dateSelected").text(dateStr);
			$("#timeSelected").text(startTime+" - " +endTime);
			$("#amountSelected").text(totalAmount);
			$("#facilityBookingFor").text(bookingFor);
			
    		
			
			//
			
    }
 
       
</script>