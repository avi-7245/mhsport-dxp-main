<%@page import="mhdys.kreedapith.sports.facility.constants.MhdysKreedapithSportsFacilityPortletKeys"%>
<%@ include file="/init.jsp"%>
<!-- Include Leaflet CSS & JS -->
<link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" />
<script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<portlet:resourceURL id="<%=MhdysKreedapithSportsFacilityPortletKeys.SAVE_SPORTSFACILITY_RESOURCECOMMAND %>" var="SaveSportsFacilityUrl" />
<portlet:renderURL var="redirectUrl">
    <portlet:param name="mvcRenderCommandName" value="<%=MhdysKreedapithSportsFacilityPortletKeys.REDIRECT %>" />
</portlet:renderURL>

<portlet:resourceURL id="<%=MhdysKreedapithSportsFacilityPortletKeys.GET_DISTRICTS%>" var="getDistricts" />
<portlet:resourceURL id="<%=MhdysKreedapithSportsFacilityPortletKeys.GET_TALUKAS%>" var="getTalukas" />

<div class="common-forms-div">
    <div class="container">
        <div class="row">
            <div class="card shadow border-0">
                <div class="card-header d-flex justify-content-between align-items-center back-btn-cn">
                    <h5 class="mb-0">
                        <liferay-ui:message key="facility-initiation-by-ho" />
                    </h5>
                    <div>
                        <a href="#" class="btn btn-primary btn-sm rounded-pill back-btn-cn" onclick="backOrClearUrl()"><i class="bi bi-arrow-left-circle mr-1"></i><liferay-ui:message key="back" /></a>
                    </div>
                </div>
              <form id="sportsFacilityForm" method="POST" enctype="multipart/form-data" autocomplete="off">
              <div id="sportsFacilityContainer">
 				<div class="sportsFacilityCard facilityFormSection" data-index="1">
                	<input type="hidden" id="sportsFacilityFormId" value="${sportsFacilityMaster.sportsFacilityId}">
                	<input type="hidden" name="saveBulkFacilities" value="true">
                <div class="card-body">
                    <div class="card card-background p-0">
                        <div class="personal_details">
                            <div class="card-header header-card">
                                <liferay-ui:message key="facility-initiation" />
                            </div>
                            <div class="card-body">
                               <div class="row">
                                    
                                    <div class="col-md-6">
										<div class="form-group">
											<label><liferay-ui:message key="facility-type"/><sup class="text-danger">*</sup></label>
											<select name="facilityType" id="facilityType" class="form-control" <c:if test="${mode eq 'view'}">disabled</c:if>>
												<option value=""><liferay-ui:message key="select" /></option>
												<option value="Division" <c:if test="${sportsFacilityMaster.facilityType eq 'Division'}">selected</c:if>>Division</option>
												<option value="District" <c:if test="${sportsFacilityMaster.facilityType eq 'District'}">selected</c:if>>District</option>
												<option value="Taluka" <c:if test="${sportsFacilityMaster.facilityType eq 'Taluka'}">selected</c:if>>Taluka</option>
											</select>
											 <div class="invalid-feedback"><liferay-ui:message key='please-select-facility-type' /></div>
										</div>
										
									</div>

									<div class="col-md-6">
										<div class="form-group">
											<label><liferay-ui:message key="facility-Name"/><sup class="text-danger">*</sup></label>
											<input type="text" class="form-control" name="facilityName" id="facilityName" value="${sportsFacilityMaster.facilityName }" <c:if test="${mode eq 'view' || mode eq 'edit'}">disabled</c:if>>
											  <div class="invalid-feedback"><liferay-ui:message key='please-enter-facility-name' /></div>
										</div>
									</div>
									
									<!-- Sports Court -->
									 <div class="col-md-6">
										<div class="form-group">
											<label><liferay-ui:message key="sports-court"/><sup class="text-danger">*</sup></label>
											<input type="text" class="form-control" name="sportsCourt" id="sportsCourt"
												   value="${sportsFacilityMaster.sportsCourt}"
												   <c:if test="${mode eq 'view' }">disabled</c:if>>
											<div class="invalid-feedback"><liferay-ui:message key="please-enter-sports-court" /></div>
										</div>
									</div> 
									
									<%-- <div class="col-md-6">
										<div class="form-group">
											<label><liferay-ui:message key="facility-Type"/><sup class="text-danger">*</sup></label>
											<input type="text" class="form-control facilityType" name="facilityType" id="facilityType" value="${sportsFacilityMaster.facilityType }" <c:if test="${mode eq 'view'}">disabled</c:if>>
											<div class="invalid-feedback"><liferay-ui:message key='please-enter-sport-court' /></div>
										</div>
									</div> --%>
									
									<div class="col-md-6">
										 <div class="form-group">
											<label><liferay-ui:message key="sport-names"/><sup class="text-danger">*</sup></label>
											<select name="sportsName" id="sportsName" class="form-control" <c:if test="${mode eq 'view'}">disabled</c:if>>
												<option value=""><liferay-ui:message key='select' /></option>
												<c:forEach var="sports" items="${sportsMaster}">
													<c:choose>
														<c:when test="${mode eq 'view' || mode eq 'edit'}">
														<option value="${sports.name_en}" 
													   	 <c:if test="${fn:trim(sportsFacilityMaster.sportsName) eq fn:trim(sports.name_en)}">selected</c:if>>
													   			 ${sports.name_en}
															</option>
														</c:when>
														<c:otherwise>
															<option value="${sports.name_en}" <c:if test="${sportsFacilityMaster.sportsName == sports.name_en}">selected</c:if> >${sports.name_en}</option>
														</c:otherwise>
													</c:choose>
													<%-- <c:if test="${mode eq 'view' || mode eq 'edit'}">
													</c:if> --%>
												</c:forEach>
											</select>
											<div class="invalid-feedback"><liferay-ui:message key='please-enter-sport-name' /></div>
										</div>
									</div>
									
									<div class="col-md-6">
										<div class="form-group">
											<label><liferay-ui:message key="facility-Area"/><sup class="text-danger">*</sup></label>
											<input type="text" class="form-control" name="facilityArea" id="facilityArea" value="${sportsFacilityMaster.facilityArea }" <c:if test="${mode eq 'view'}">disabled</c:if>>
											<div class="invalid-feedback"><liferay-ui:message key='please-enter-facility-area' /></div>
										</div>
									</div>
									
									<div class="col-md-6">
										<div class="form-group">
											<label><liferay-ui:message key="division"/> <sup class="text-danger">*</sup></label>
												<select class="form-control" name="division" id="division" <c:if test="${mode eq 'view'}">disabled</c:if>>
													<option value=""><liferay-ui:message key="select"/></option>
													<c:forEach var="division" items="${divisions}">
													<option value="${division.divisionId}" <c:if test="${constructionTrackerDTO.division == division.divisionId}">selected</c:if> >${division.divisionName_en}</option>
												</c:forEach>
											</select>
											<div class="invalid-feedback"><liferay-ui:message key="please-select-division" /></div>
											
										</div>
									</div>
									<div class="col-md-6">
										<div class="form-group">
											<label><liferay-ui:message key="district"/> <sup class="text-danger">*</sup></label>
										<select class="form-control" name="district" id="district" <c:if test="${mode eq 'view'}">disabled</c:if>>
										    <option value=""><liferay-ui:message key="select" /></option>
										</select>
										<div class="invalid-feedback"><liferay-ui:message key="please-select-district" /></div>
										</div>
									</div>
									<div class="col-md-6">
										<div class="form-group">
											<label><liferay-ui:message key="taluka"/> <sup class="text-danger">*</sup></label>
											<select class="form-control" name="taluka" id="taluka" <c:if test="${mode eq 'view'}">disabled</c:if>>
												<option value=""><liferay-ui:message key="select"/></option>
											</select>
											<div class="invalid-feedback"><liferay-ui:message key="please-select-taluka" /></div>
										</div>
									</div>
									
									
									
									<!-- Contact Person Email -->
									<div class="col-md-6">
										<div class="form-group">
											<label><liferay-ui:message key="contact-person-email-id"/><sup class="text-danger">*</sup></label>
											<input type="text" class="form-control" name="contactPersonEmail" id="contactPersonEmail"
												   value="${sportsFacilityMaster.contactPersonEmail}"
												   <c:if test="${mode eq 'view' }">disabled</c:if>>
											<div class="invalid-feedback"><liferay-ui:message key="please-enter-contact-person-email" /></div>
										</div>
									</div>
									
									<!-- City -->
									<div class="col-md-6">
										<div class="form-group">
											<label><liferay-ui:message key="name-of-city"/><sup class="text-danger">*</sup></label>
											<input type="text" class="form-control" name="city" id="city"
												   value="${sportsFacilityMaster.city}"
												   <c:if test="${mode eq 'view' }">disabled</c:if>>
											<div class="invalid-feedback"><liferay-ui:message key="please-enter-city-name" /></div>
										</div>
									</div>
									
									<!-- Address -->
									<div class="col-md-6">
										<div class="form-group">
											<label><liferay-ui:message key="address"/><sup class="text-danger">*</sup></label>
											<textarea class="form-control" name="address" id="address" rows="2"
													  <c:if test="${mode eq 'view' }">disabled</c:if>>${sportsFacilityMaster.address}</textarea>
											<div class="invalid-feedback"><liferay-ui:message key="please-enter-address" /></div>
										</div>
									</div>
									
									<!-- Main Type of Facility -->
									<div class="col-md-6">
										<div class="form-group">
											<label><liferay-ui:message key="main-type-of-facility"/><sup class="text-danger">*</sup></label>
											<input type="text" class="form-control" name="mainTypeOfFacility" id="mainTypeOfFacility"
												   value="${sportsFacilityMaster.mainTypeOfFacility}"
												   <c:if test="${mode eq 'view' }">disabled</c:if>>
											<div class="invalid-feedback"><liferay-ui:message key="please-enter-main-type-of-facility" /></div>
										</div>
									</div>
									
									<!-- Court Name / Number -->
									<div class="col-md-6">
										<div class="form-group">
											<label><liferay-ui:message key="court-name-number"/><sup class="text-danger">*</sup></label>
											<input type="text" class="form-control" name="courtNameNumber" id="courtNameNumber"
												   value="${sportsFacilityMaster.courtNameNumber}"
												   <c:if test="${mode eq 'view' }">disabled</c:if>>
											<div class="invalid-feedback"><liferay-ui:message key="please-enter-court-name-number" /></div>
										</div>
									</div>
									
									<!-- Available Facilities (Working / Not Working) -->
								<%-- <div class="col-md-6">
									<div class="form-group">
										<label><liferay-ui:message key="available-facilities"/><sup class="text-danger">*</sup></label>
										<div>
											<div class="form-check form-check-inline">
												<input class="form-check-input" type="radio" name="availableFacilities" id="availableFacilitiesWorking"
													   value="Working"
													   <c:if test="${sportsFacilityMaster.availableFacilities eq 'Working'}">checked</c:if>
													   <c:if test="${mode eq 'view'}">disabled</c:if>>
												<label class="form-check-label" for="availableFacilitiesWorking">
													<liferay-ui:message key="working" />
												</label>
											</div>
								
											<div class="form-check form-check-inline">
												<input class="form-check-input" type="radio" name="availableFacilities" id="availableFacilitiesNotWorking"
													   value="Not Working"
													   <c:if test="${sportsFacilityMaster.availableFacilities eq 'Not Working'}">checked</c:if>
													   <c:if test="${mode eq 'view'}">disabled</c:if>>
												<label class="form-check-label" for="availableFacilitiesNotWorking">
													<liferay-ui:message key="not-working" />
												</label>
											</div>
										</div>
										<div class="invalid-feedback"><liferay-ui:message key="please-select-available-facilities" /></div>
									</div>
								</div> --%>
								
								<div class="col-md-6">
								    <div class="form-group">
								        <label><liferay-ui:message key="available-facilities"/><sup class="text-danger">*</sup></label>
								        <select name="availableFacilities" id="availableFacilities_0" class="form-control" <c:if test="${mode eq 'view'}">disabled</c:if>>
								            <option value=""><liferay-ui:message key="select"/></option>
								            <option value="Working" <c:if test="${sportsFacilityMaster.availableFacilities eq 'Working'}">selected</c:if>> 
								                <liferay-ui:message key="working"/>
								            </option>
								            <option value="Not Working" <c:if test="${sportsFacilityMaster.availableFacilities eq 'Not Working'}">selected</c:if>> 
								                <liferay-ui:message key="not-working"/>
								            </option>
								        </select>
								        <div class="invalid-feedback"><liferay-ui:message key="please-select-available-facilities"/></div>
								    </div>
								</div>
								
									
									
								
								<!-- Not Working Reason -->
								<div class="col-md-6"
								     id="notWorkingReasonDiv_0"
								     style="<c:if test='${sportsFacilityMaster.availableFacilities ne "Not Working"}'>display:none;</c:if>">
								    <div class="form-group">
								        <label><liferay-ui:message key="not-working-reason"/><sup class="text-danger">*</sup></label>
								        <input type="text" class="form-control"
								               name="notWorkingReason"
								               id="notWorkingReason_0"
								               value="${sportsFacilityMaster.notWorkingReason}"
								               <c:if test='${mode eq "view"}'>disabled</c:if>>
								      <!--   <div class="invalid-feedback">
								            <liferay-ui:message key="please-enter-not-working-reason" />
								        </div> -->
								    </div>
								</div>
								
								<%-- <div class="col-md-6" id="notWorkingReasonDiv_0" style="display: none;">
								    <div class="form-group">
								        <label><liferay-ui:message key="not-working-reason"/><sup class="text-danger">*</sup></label>
								        <input type="text" class="form-control" name="notWorkingReason" id="notWorkingReason_0"
								               value="${sportsFacilityMaster.notWorkingReason}"
								               <c:if test="${mode eq 'view' }">disabled</c:if>>
								        <div class="invalid-feedback"><liferay-ui:message key="please-enter-not-working-reason" /></div>
								    </div>
								</div> --%>

								
								<!-- Capacity -->
								<div class="col-md-6">
									<div class="form-group">
										<label><liferay-ui:message key="capacity"/><sup class="text-danger">*</sup></label>
										<input type="number" class="form-control" name="capacity" id="capacity"
											   value="${sportsFacilityMaster.capacity}"
											   <c:if test="${mode eq 'view' }">disabled</c:if>>
										<div class="invalid-feedback"><liferay-ui:message key="please-enter-capacity" /></div>
									</div>
								</div>
								
								<!-- Remarks -->
								<div class="col-md-6">
									<div class="form-group">
										<label><liferay-ui:message key="remarks"/><sup class="text-danger">*</sup></label>
										<textarea class="form-control" name="remarks" id="remarks" rows="2"
												  <c:if test="${mode eq 'view' }">disabled</c:if>>${sportsFacilityMaster.remarks}</textarea>
										<div class="invalid-feedback"><liferay-ui:message key="please-enter-remarks" /></div>
									</div>
								</div>
									
																		
											
																		
									<div class="col-md-12">
								    <div class="form-group">
								        <label><liferay-ui:message key="Facility-Location" /><sup class="text-danger">*</sup></label><br/>
								        
								        <div class="input-group">
									        <input type="text" id="locationSearch" class="form-control" placeholder="Enter Area or City Name" <c:if test="${mode eq 'view'}">disabled</c:if>>
									        <button type="button" class="btn btn-primary" id="searchLocationBtn" onclick="searchLocation('locationSearch','map_1','locationNotFound',1)" <c:if test="${mode eq 'view'}">disabled</c:if>>Search</button>
									    </div>
									    <span class="text-danger d-block" id="locationNotFound"></span>
								        
								        <button type="button" class="btn btn-primary d-none" id="getGisLocation" onclick="getLocation()" <c:if test="${mode eq 'view'}">disabled</c:if> >
								            <liferay-ui:message key="get-GIS-location" />
								        </button>
								    </div>
								    <!-- Map Container -->
					                 <div id="map_1" class="d-none" style="height: 300px; border: 1px solid #ccc; z-index: 1;"></div>
								   </div>
									
								  <div class="col-md-6 d-none">
									    <div class="form-group">
									        <label><liferay-ui:message key="latitude" /><sup class="text-danger">*</sup></label>
									       <input type="hidden" class="form-control" name="latitude" id="latitude_1" value="${sportsFacilityMaster.latitude}" readonly />
									    </div>
									</div>
									
									<div class="col-md-6 d-none">
									    <div class="form-group">
									        <label><liferay-ui:message key="longitude" /><sup class="text-danger">*</sup></label>
									       <input type="hidden" class="form-control" name="longitude" id="longitude_1" value="${sportsFacilityMaster.longitude}" readonly />
									    </div>
									</div>
								  <!-- Map Container Ends -->
								
								<%-- <div class="col-md-6 mt-4">
									<div class="form-group">
										<label for="type"><liferay-ui:message key="type" /><sup class="text-danger">*</sup></label>
										<div class="d-flex mt-2">
										<div class="radio-text mx-4">
											<input type="checkbox" class="form-check-input typeCheckBox" name="typeCheckBox" id="type_monthly" value="Monthly Pass"
											                <c:if test="${mode eq 'view'}">disabled</c:if>>
											<label class="form-check-label mr-3" for="type_monthly"><liferay-ui:message key="monthly-pass" /></label>
										</div>
										<div>
											<input type="checkbox" class="form-check-input typeCheckBox" name="typeCheckBox" id="type_rent" value="Rent Booking"
										                <c:if test="${mode eq 'view'}">disabled</c:if>>
											<label class="form-check-label" for=type_rent><liferay-ui:message key="rent-booking" /></label>
										</div>
										</div>
										<div class="invalid-feedback" id="typeCheckBoxError"><liferay-ui:message key='please-enter-type' /></div>
									</div>
								</div>
									
								  	<div class="col-md-6 mt-4">
										<div class="form-group">
											<label><liferay-ui:message key="fees"/><sup class="text-danger">*</sup></label>
											<input type="number" step="1" min="0" class="form-control" name="fees" id="fees" value="${sportsFacilityMaster.fees }" <c:if test="${mode eq 'view'}">disabled</c:if>>
											<div class="invalid-feedback"><liferay-ui:message key='please-enter-fees' /></div>
										</div>
									</div> --%>
							</div>
							
							
							
							<div class="mt-4 universal-table">
							    <label><liferay-ui:message key="booking-details" /></label>
							    <table class="table table-bordered bookingTable">
							        <thead>
							            <tr>
							                <th><liferay-ui:message key="booking-reason" /></th>
							                <th><liferay-ui:message key="per-hour" /> (Rs)</th>
							                <th><liferay-ui:message key="per-day" /> (Rs)</th>
							                <th><liferay-ui:message key="per-month" /> (Rs)</th>
							            </tr>
							        </thead>
							        <tbody>
									    <tr>
									        <td><liferay-ui:message key="assoc-federation" /></td>
									        <td><input type="number" step="1" min="0" name="assocPerHour" class="form-control"
									                   value="${sportsFacilityMaster.assoc_fed_perHour > 0 ? sportsFacilityMaster.assoc_fed_perHour : ''}"
									                   <c:if test="${mode eq 'view'}">readonly</c:if>></td>
									        <td><input type="number" step="1" min="0" name="assocPerDay" class="form-control"
									                   value="${sportsFacilityMaster.assoc_fed_perDay > 0 ? sportsFacilityMaster.assoc_fed_perDay : ''}"
									                   <c:if test="${mode eq 'view'}">readonly</c:if>></td>
									        <td><input type="number" step="1" min="0" name="assocPerMonth" class="form-control"
									                   value="${sportsFacilityMaster.assoc_fed_perMonth > 0 ? sportsFacilityMaster.assoc_fed_perMonth : ''}"
									                   <c:if test="${mode eq 'view'}">readonly</c:if>></td>
									    </tr>
									    <tr>
									        <td><liferay-ui:message key="rent-other-sports-events" /></td>
									        <td><input type="number" step="1" min="0" name="rentOtherPerHour" class="form-control"
									                   value="${sportsFacilityMaster.rent_other_sports_perHour > 0 ? sportsFacilityMaster.rent_other_sports_perHour : ''}"
									                   <c:if test="${mode eq 'view'}">readonly</c:if>></td>
									        <td><input type="number" step="1" min="0" name="rentOtherPerDay" class="form-control"
									                   value="${sportsFacilityMaster.rent_other_sports_perDay > 0 ? sportsFacilityMaster.rent_other_sports_perDay : ''}"
									                   <c:if test="${mode eq 'view'}">readonly</c:if>></td>
									        <td><input type="number" step="1" min="0" name="rentOtherPerMonth" class="form-control"
									                   value="${sportsFacilityMaster.rent_other_sports_perMonth > 0 ? sportsFacilityMaster.rent_other_sports_perMonth : ''}"
									                   <c:if test="${mode eq 'view'}">readonly</c:if>></td>
									    </tr>
									    <tr>
									        <td><liferay-ui:message key="rent-non-sports-events" /></td>
									        <td><input type="number" step="1" min="0" name="rentNonPerHour" class="form-control"
									                   value="${sportsFacilityMaster.rent_nonsports_perHour > 0 ? sportsFacilityMaster.rent_nonsports_perHour : ''}"
									                   <c:if test="${mode eq 'view'}">readonly</c:if>></td>
									        <td><input type="number" step="1" min="0" name="rentNonPerDay" class="form-control"
									                   value="${sportsFacilityMaster.rent_nonsports_perDay > 0 ? sportsFacilityMaster.rent_nonsports_perDay : ''}"
									                   <c:if test="${mode eq 'view'}">readonly</c:if>></td>
									        <td><input type="number" step="1" min="0" name="rentNonPerMonth" class="form-control"
									                   value="${sportsFacilityMaster.rent_nonsports_perMonth > 0 ? sportsFacilityMaster.rent_nonsports_perMonth : ''}"
									                   <c:if test="${mode eq 'view'}">readonly</c:if>></td>
									    </tr>
									    <tr>
									        <td><liferay-ui:message key="individual" /></td>
									        <td><input type="number" step="1" min="0" name="indPerHour" class="form-control"
									                   value="${sportsFacilityMaster.individual_perHour > 0 ? sportsFacilityMaster.individual_perHour : ''}"
									                   <c:if test="${mode eq 'view'}">readonly</c:if>></td>
									        <td><input type="number" step="1" min="0" name="indPerDay" class="form-control"
									                   value="${sportsFacilityMaster.individual_perDay > 0 ? sportsFacilityMaster.individual_perDay : ''}"
									                   <c:if test="${mode eq 'view'}">readonly</c:if>></td>
									        <td><input type="number" step="1" min="0" name="indPerMonth" class="form-control"
									                   value="${sportsFacilityMaster.individual_perMonth > 0 ? sportsFacilityMaster.individual_perMonth : ''}"
									                   <c:if test="${mode eq 'view'}">readonly</c:if>></td>
									    </tr>
									    <tr>
									        <td><liferay-ui:message key="shooting-rapid-event" /></td>
									        <td><input type="number" step="1" min="0" name="shootingPerHour" class="form-control"
									                   value="${sportsFacilityMaster.shooting_rapid_perHour > 0 ? sportsFacilityMaster.shooting_rapid_perHour : ''}"
									                   <c:if test="${mode eq 'view'}">readonly</c:if>></td>
									        <td><input type="number" step="1" min="0" name="shootingPerDay" class="form-control"
									                   value="${sportsFacilityMaster.shooting_rapid_perDay > 0 ? sportsFacilityMaster.shooting_rapid_perDay : ''}"
									                   <c:if test="${mode eq 'view'}">readonly</c:if>></td>
									        <td><input type="number" step="1" min="0" name="shootingPerMonth" class="form-control"
									                   value="${sportsFacilityMaster.shooting_rapid_perMonth > 0 ? sportsFacilityMaster.shooting_rapid_perMonth : ''}"
									                   <c:if test="${mode eq 'view'}">readonly</c:if>></td>
									    </tr>
									    <tr>
									        <td><liferay-ui:message key="all-arena-lights" /></td>
									        <td><input type="number" step="1" min="0" name="lightsPerHour" class="form-control"
									                   value="${sportsFacilityMaster.arena_lights_perHour > 0 ? sportsFacilityMaster.arena_lights_perHour : ''}"
									                   <c:if test="${mode eq 'view'}">readonly</c:if>></td>
									        <td></td>
									        <td></td>
									    </tr>
									    <tr>
									        <td><liferay-ui:message key="ac" /></td>
									        <td><input type="number" step="1" min="0" name="acPerHour" class="form-control"
									                   value="${sportsFacilityMaster.ac_perHour > 0 ? sportsFacilityMaster.ac_perHour : ''}"
									                   <c:if test="${mode eq 'view'}">readonly</c:if>></td>
									        <td></td>
									        <td></td>
									    </tr>
									</tbody>

							    </table>
							</div>
							
                            </div> <!-- .card-body (inner) -->
                        </div> <!-- .personal_details -->
                    </div> <!-- .card-background -->
                </div> <!-- .card-body (outer) -->
            
          </div>
          </div> 
           </form>
           
           <c:if test="${mode ne 'view'}">    
                <div class="card-footer bg-transparent text-right p-4">
                	<div>
                		<c:if test="${mode ne 'view' && mode ne 'edit'}">  
						  	<button type="button" class="btn btn-primary addMoreFormBtn" id="addMoreFormBtn"><i class="bi bi-plus-circle"></i></button>
						  	<button type="button" class="btn btn-danger removeFormBtn" id="removeFormBtn"><i class="bi bi-dash-circle"></i></button>
					  	</c:if>
                	</div>
                
                
					 <div class="d-flex justify-content-end mt-2">
					
					     <a href="javascript:void(0);" onclick="window.location.href='<%= MhdysKreedapithSportsFacilityPortletKeys.HOMEURL %>?clear=true';" class="btn btn-secondary maha-save-btn" id="modalCloseBtn">
						    <liferay-ui:message key="cancel"/>
						</a>
					    <c:if test="${mode ne 'view'}">
						    <button type="button" class="btn btn-primary reset-btn" id="reset-btn">
						      <liferay-ui:message key="reset" />
						    </button>
						 </c:if>
						 
					    <button type="button" class="btn btn-primary submit-btn" id="submitBtn">
					       <c:if test="${mode eq 'edit'}"><liferay-ui:message key="update" /></c:if> 
					       <c:if test="${mode ne 'edit'}"><liferay-ui:message key="submit" /></c:if> 
					    </button>
					   
					</div>
				</div>
			</c:if>
                
            </div> <!-- .card -->
        </div> <!-- .row -->
    </div> <!-- .container -->
</div> <!-- .common-forms-div -->


<!-- Success/Failure modal -->
<div class="modal fade" id="saveFacilityModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true" data-backdrop="static" data-keyboard="false">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content modal-bg">
      <div class="modal-header justify-content-center align-items-center">
        <h5 class="modal-title"><liferay-ui:message key="form" /></h5>
      </div>
      <div class="modal-body">
        <div class="text-center">
          <p id="success-message">
           <!--  <liferay-ui:message key="please-fill-all-required-fields-before-proceeding" /> -->
          </p>
        </div>
      </div>
      <div class="modal-footer d-flex justify-content-end">
		     <a href="#" class="btn btn-secondary maha-save-btn" onclick="closeModal()">
                <liferay-ui:message key="close"/>
            </a>
		</div>

    </div>
  </div>
</div>

<!-- Validations popup modal -->
<div class="modal fade" id="validationPopupModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true" data-backdrop="static" data-keyboard="false">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content modal-bg">
      <div class="modal-header justify-content-center align-items-center">
        <h5 class="modal-title"><liferay-ui:message key="form" /></h5>
      </div>
      <div class="modal-body">
        <div class="text-center">
          <p id="validation-message">
          </p>
        </div>
      </div>
      <div class="modal-footer d-flex justify-content-end">
		     <a href="#" class="btn btn-secondary maha-save-btn" id="modalCloseBtn" onclick="closeValidationPopupModal()">
                <liferay-ui:message key="close"/>
            </a>
		</div>

    </div>
  </div>
</div>

<script>

function backOrClearUrl() {
	var mode = "${mode}";
	var isCreateMode = mode === "" || null;
	if(isCreateMode){
    	window.location.href = "<%=MhdysKreedapithSportsFacilityPortletKeys.HOMEURL%>?clear=true";
	}else{
		window.location.href = "${redirectUrl}&type=hoFacilityList&clear=true";
	}
}
function closeValidationPopupModal(){
	$('#validationPopupModal').modal('hide');
}
	
var uploadedFilesGeoTagPhoto = [];
var $form = $("#sportsFacilityForm");

$.validator.addMethod("containsLetters", function(value, element) {
    return this.optional(element) || /[A-Za-z]/.test(value);
}, "<liferay-ui:message key='field-must-contain-characters' />");

$("#reset-btn").on("click", function () {
    let mode = '${mode}';
    if (mode === "edit") {
    	// Clear only editable inputs & textareas
        $("#sportsFacilityForm")
            .find("input[type=text]:not(:disabled):not([readonly]), input[type=number]:not(:disabled):not([readonly]), textarea:not(:disabled):not([readonly])")
            .val("");
        // Clear checkboxes and radios (but only if not disabled)
        $("#sportsFacilityForm")
            .find("input[type=checkbox]:not(:disabled), input[type=radio]:not(:disabled)")
            .prop("checked", false);
        // Clear validation errors
        $("#sportsFacilityForm").validate().resetForm();
    } else {
        // Normal reset in create mode
         $('#sportsFacilityContainer .facilityFormSection').not(':first').remove();
        $("#sportsFacilityForm")[0].reset();
        $("#sportsFacilityForm").validate().resetForm();
        $("input[type='checkbox']").prop('checked', false);
    }
});

$('.typeCheckBox').on('change', function () {
    if (this.checked) {
        $('.typeCheckBox').not(this).prop('checked', false);
    }
});

function closeModal(){
	 $("#validationPopupModal").modal('hide');
	 var mode = "${mode}";
		var isCreateMode = mode === "" || null;
		if(isCreateMode){
	    	window.location.href = "<%=MhdysKreedapithSportsFacilityPortletKeys.HOMEURL%>?clear=true";
		}else{
			window.location.href = "${redirectUrl}&type=hoFacilityList&clear=true";
		}
}

$(document).on('keypress', '#fees', function (e) {
	
	
    const char = String.fromCharCode(e.which);
    if (!/[0-9.]/.test(char)) {
        e.preventDefault();
    }
});

$(document).ready(function () {
	
	setDivisionDistrictTaluks();
	
	 /* $(document).on('change', 'select[id^="availableFacilities_"]', function() {debugger
	        const $section = $(this).closest('.facilityFormSection');
	        const index = $(this).attr('id').split('_')[1];

	        console.log('Changed:', $(this).attr('id'), 'Value:', $(this).val());
            
	        if ($(this).val() === 'Not Working') {
	            $section.find('#notWorkingReasonDiv_' + index).show();
	        } else {
	            $section.find('#notWorkingReasonDiv_' + index).hide();
	            $section.find('#notWorkingReason_' + index).val('');
	        }
	    }); */
	    
	    $(document).on('change', 'select[id^="availableFacilities_"]', function() {
	        debugger
	        const $section = $(this).closest('.facilityFormSection');
	        const index = $(this).attr('id').split('_')[1];
	        const notWorkingReasonField = $('#notWorkingReason_' + index);

	        console.log('Changed:', $(this).attr('id'), 'Value:', $(this).val());

	        if ($(this).val() === 'Not Working') {
	            $section.find('#notWorkingReasonDiv_' + index).show();
	        } else {
	            $section.find('#notWorkingReasonDiv_' + index).hide();
	            $section.find('#notWorkingReason_' + index).val('');
	        }

	        //Re-validate the corresponding notWorkingReason field dynamically
	        notWorkingReasonField.valid();
	    });

	
	
	var mode = "${mode}";
	var latitudeStr = "${sportsFacilityMaster.latitude}";
	var longitudeStr = "${sportsFacilityMaster.longitude}";

	var latitude = parseFloat(latitudeStr);
	var longitude = parseFloat(longitudeStr);
	var isValidCoordinates = !isNaN(latitude) && !isNaN(longitude);
	var isCreateMode = mode === "" || null;
	var isEditMode = mode === "edit";
	var isViewMode = mode === "view";

	if (( (isEditMode || isViewMode) && isValidCoordinates) || isCreateMode) {
	    $("#map_1").removeClass("d-none");
	    var defaultLat = 19.7515;
	    var defaultLon = 75.7139;
	    var lat = isValidCoordinates ? latitude : defaultLat;
	    var lon = isValidCoordinates ? longitude : defaultLon;
	    console.log("lat:", lat);
	    console.log("lon:", lon);
	    initializeMap(lat, lon, isViewMode ? false : true, 'map_1', '1'); 
	}

    
    console.log("Mode:", mode);
    console.log("Latitude:", latitude);
    console.log("Longitude:", longitude);
    
	
	let typeValue = "${sportsFacilityMaster.type}";
    if (typeValue) {
        const types = typeValue.split(",").map(t => t.trim());

        types.forEach(type => {
            if (type === "Monthly Pass") {
                $("#type_monthly").prop("checked", true);
            } else if (type === "Rent Booking") {
                $("#type_rent").prop("checked", true);
            }
        });
    }
    
    const uploadedFilesGeoTagPhoto = [];

     let validationRules = {
        facilityName: { required: true,alphanumericOnly:true,singleSpaceOnly:true, noEdgeSpaces:true, minlength: 3, maxlength: 75 },
       /*  facilityType: { required: true, alphanumericOnly:true,singleSpaceOnly:true, noEdgeSpaces:true, minlength: 3, maxlength: 75 }, */
        facilityArea: { required: true,alphanumericOnly:true,singleSpaceOnly:true, noEdgeSpaces:true, minlength: 3, maxlength: 75 },
        typeCheckBox: { required: true },
        sportsName: { required: true },
        fees: { required: true, number: true, min: 1, max: 9999999999},
        division: { required: true },
        district: { required: true },
        taluka: { required: true },
        facilityType: { required: true },
        sportsCourt:{ required: true,alphabetsOnly:true,singleSpaceOnly:true, noEdgeSpaces:true, minlength: 3, maxlength: 75 },
        city:{ required: true,alphanumericOnly:true,singleSpaceOnly:true, noEdgeSpaces:true, minlength: 3, maxlength: 75 },
        address:{ required: true,singleSpaceOnly:true, noEdgeSpaces:true,validAddress:true, minlength: 3, maxlength: 500 },
        mainTypeOfFacility:{ required: true,alphabetsOnly:true,singleSpaceOnly:true, noEdgeSpaces:true, minlength: 3, maxlength: 75 },
        courtNameNumber:{ required: true,alphanumericOnly:true,singleSpaceOnly:true, noEdgeSpaces:true, minlength: 3, maxlength: 75 },
        availableFacilities:{ required: true },
        notWorkingReason: {
       	 required: function(element) {
       	        const index = $(element).attr('id').split('_')[1]; 
       	        const facilityValue = $('#availableFacilities_' + index).val();
       	        return facilityValue === 'Not Working'; 
       	    },
            alphanumericOnly: true,
            singleSpaceOnly: true,
            noEdgeSpaces: true,
            validateRemarks: true,
            minlength: 3,
            maxlength: 75
        }, 
       /*  notWorkingReason:{ required: true,alphanumericOnly:true,singleSpaceOnly:true, noEdgeSpaces:true,validateRemarks:true, minlength: 3, maxlength: 75 },  */
        capacity:{ required: true ,pattern: /^[1-9][0-9]*$/, number: true},
        remarks:{ required: true,singleSpaceOnly:true, noEdgeSpaces:true,validateRemarks:true, minlength: 3, maxlength: 500 },
        contactPersonEmail:{ required: true, singleSpaceOnly:true, noEdgeSpaces:true,maxlength: 75,validateEmail:true},
    };

    let validationMessages = {
        facilityName: {
            required: "<liferay-ui:message key='please-enter-facility-name' />",
            minlength: "<liferay-ui:message key='please-enter-min-3-chars' />",
            maxlength: "<liferay-ui:message key='please-enter-max-75-chars' />"
        },
         facilityType: {
            required: "<liferay-ui:message key='please-select-facility-type' />",
        },
        facilityArea: {
            required: "<liferay-ui:message key='please-enter-facility-area' />",
            minlength: "<liferay-ui:message key='please-enter-min-3-chars' />",
            maxlength: "<liferay-ui:message key='please-enter-max-75-chars' />"
        },
      typeCheckBox: {
            required: "<liferay-ui:message key='please-enter-type' />",
        },
        sportsName: {
            required: "<liferay-ui:message key='please-enter-sports-name' />",
        },
         fees: {
            required: "<liferay-ui:message key='please-enter-fees' />",
            number: "<liferay-ui:message key='fees-must-be-number' />",
            min: '<liferay-ui:message key="it-must-be-positive-or-greater-than-0" />',
            max: "<liferay-ui:message key='please-enter-max-10-digits' />"
        },
        division: '<liferay-ui:message key="please-select-division" />',
        district: '<liferay-ui:message key="please-select-district" />',
        taluka: '<liferay-ui:message key="please-select-taluka" />',
        sportsCourt: {
            required: "<liferay-ui:message key='please-enter-sports-court' />",
            minlength: "<liferay-ui:message key='please-enter-min-3-chars' />",
            maxlength: "<liferay-ui:message key='please-enter-max-75-chars' />"
        },
        city:{
            required: "<liferay-ui:message key='please-enter-city-name' />",
            minlength: "<liferay-ui:message key='please-enter-min-3-chars' />",
            maxlength: "<liferay-ui:message key='please-enter-max-75-chars' />"
        },
        address:{
        	 required: "<liferay-ui:message key='please-enter-address' />",
             minlength: "<liferay-ui:message key='please-enter-min-3-chars' />",
             maxlength: "<liferay-ui:message key='please-enter-max-500-chars' />"
        },
        mainTypeOfFacility:{
        	required: "<liferay-ui:message key='please-enter-main-type-of-facility' />",
            minlength: "<liferay-ui:message key='please-enter-min-3-chars' />",
            maxlength: "<liferay-ui:message key='please-enter-max-75-chars' />"
        },
        courtNameNumber:{
        	required: "<liferay-ui:message key='please-enter-court-name-number' />",
            minlength: "<liferay-ui:message key='please-enter-min-3-chars' />",
            maxlength: "<liferay-ui:message key='please-enter-max-75-chars' />"
        },
        availableFacilities:{
        	 required: "<liferay-ui:message key='please-select-available-facilities' />",
        },
        notWorkingReason:{
        	required: "<liferay-ui:message key='please-enter-not-working-reason' />",
            minlength: "<liferay-ui:message key='please-enter-min-3-chars' />",
            maxlength: "<liferay-ui:message key='please-enter-max-75-chars' />"
        },
        capacity:{
        	required: "<liferay-ui:message key='please-enter-capacity' />",
        	 number: "<liferay-ui:message key='please-enter-a-valid-number' />",
             pattern: "<liferay-ui:message key='please-enter-a-valid-number' />"
        },
        remarks:{
        	 required: "<liferay-ui:message key='please-enter-remarks' />",
             minlength: "<liferay-ui:message key='please-enter-min-3-chars' />",
             maxlength: "<liferay-ui:message key='please-enter-max-500-chars' />"
        },
        contactPersonEmail:{
        	 required: "<liferay-ui:message key='please-enter-contact-person-email' />",
        	 minlength: "<liferay-ui:message key='please-enter-min-3-chars' />",
             maxlength: "<liferay-ui:message key='please-enter-max-75-chars' />"
        }
        
    }; 

    $('#sportsFacilityForm').on('keyup change', 'input, select, textarea', function() {
        $(this).removeClass('is-invalid');
        $(this).next('.invalid-feedback').remove();
    });
    
    $("#sportsFacilityForm").validate({
   	 	onkeyup: function (element) {
   	        $(element).valid();
   	    },
   	    onchange: function (element) {
   	        $(element).valid();
   	    },
        rules: validationRules,
        messages: validationMessages,
        errorElement: 'div',
  	    errorClass: 'invalid-feedback',
  	    highlight: function(element) {
  	     $(element).addClass('is-invalid');
  	    },
  	    unhighlight: function(element) {
  	     $(element).removeClass('is-invalid');
  	    },
    });
    
    
    $.validator.addMethod("alphabetsOnly", function(value, element) {
        return this.optional(element) || /^[A-Za-z ]+$/.test(value);
    }, "<liferay-ui:message key='please-enter-alphabets-only' />");

    
    $.validator.addMethod("validAddress", function (value, element) {
        value = $.trim(value); 
        return this.optional(element) || (/^(?!.*\s{2,})[a-zA-Z0-9\s,.\-/#]{3,250}$/.test(value));
    }, "<liferay-ui:message key='address-must-be-between-3-to-250-characters-and-contain-only-letters-numbers-and' />");

  
    $.validator.addMethod("validateRemarks", function(value, element) {
 	   const regex = /^(?!0+$)(?!.*  )[A-Za-z0-9]+(?:[ ]?[,.\- ]?[ ]?[A-Za-z0-9]+)*(?: \.|\.)?$/i;
 	    return this.optional(element) || regex.test(value);
 	}, "<liferay-ui:message key='please-enter-valid-remarks' />");
    
    $.validator.addMethod("validateEmail", function(value, element) {
 		const regex =  /^(?!.*\.\.)(?!.*__)(?!.*[._][._])(?![_\.])[a-zA-Z0-9._]*[a-zA-Z][a-zA-Z0-9._]*(?<![_\.])@[a-zA-Z0-9][a-zA-Z0-9-]*\.[a-zA-Z]{2,3}$/
	    return this.optional(element) || regex.test(value);
	}, "<liferay-ui:message key='please-enter-a-valid-email-address'/>");
    
    $.validator.addMethod("nonNegative", function(value, element) {
        return this.optional(element) || parseFloat(value) >= 0;
    }, "Negative values are not allowed.");

    $.validator.addMethod("containsLetters", function(value, element) {
        return this.optional(element) || /[A-Za-z]/.test(value);
    }, "<liferay-ui:message key='field-must-contain-characters' />");

    $.validator.addMethod("validContact", function(value, element) {
        return this.optional(element) || /^[6-9]\d{9}$/.test(value);
    }, '<liferay-ui:message key="contact-number-invalid-pattern" />');

    $.validator.addMethod("alphanumericOnly", function(value, element) {
        return this.optional(element) || /^[A-Za-z0-9 ]+$/.test(value);
    }, "<liferay-ui:message key='please-enter-alphanumeric-characters' />");

    $.validator.addMethod("validSpaces", function(value, element) {
        // Checks if there are no leading/trailing spaces and only single space between words
        return this.optional(element) || /^[^\s]+(?:\s[^\s]+)*$/.test(value);
    }, "<liferay-ui:message key='Spaces-are-allowed-only-between-words-and-No-leading-or-trailing-spaces' />");

    $.validator.addMethod("noEdgeSpaces", function(value, element) {
    	  return this.optional(element) || value === value.trim();
    }, "<liferay-ui:message key='no-leading-trailing-spaces-allowed' />");

    $.validator.addMethod("singleSpaceOnly", function(value, element) {
      return this.optional(element) || !/\s{2,}/.test(value);
    }, "<liferay-ui:message key='only-one-space-between-words-allowed' />");

    $.validator.addMethod("validCharacters", function(value, element) {
      return this.optional(element) || /^[A-Za-z0-9\s.,/#-]*$/.test(value);
    }, "<liferay-ui:message key='please-enter-valid-characters' />");

    $.validator.addMethod("noConsecutiveSpecials", function(value, element) {
    	return this.optional(element) || !/([.,/#-]\s*){2,}/.test(value);
    }, "<liferay-ui:message key='no-consecutive-specials-allowed' />");

    $.validator.addMethod("onlyDotAtEnd", function(value, element) {
      return this.optional(element) || /\.$/.test(value) || /[A-Za-z0-9]$/.test(value);
    }, "<liferay-ui:message key='only-dot-at-end-allowed' />");

    $.validator.addMethod("validPersonName", function(value, element) {
    	// It Should accept alphabets space .
        return this.optional(element) || /^[A-Za-z. ]+$/.test(value.trim());
    }, "<liferay-ui:message key='please-enter-valid-name' />");
    
    
    $("#submitBtn").on("click", function () {
    
        let $previousSection = $('.facilityFormSection').last();
        let allFieldsFilled = true;
        let requiredFields = [
            'facilityName', 'facilityType' , 'sportsName', 'facilityArea', 'division', 'district', 'taluka', 'sportsCourt','city','address','mainTypeOfFacility',
            'courtNameNumber','availableFacilities', /* 'notWorkingReason', */'capacity','remarks','sportsCourt','contactPersonEmail',
        ];
        
        $.each(requiredFields, function(idx, name) {
            let val = $previousSection.find('[name="'+name+'"]').val();
            if (!val || val.trim() === '') {
                allFieldsFilled = false;
                $previousSection.find('[name="'+name+'"]').addClass('is-invalid');  // Bootstrap highlight
            } else {
                $previousSection.find('[name="'+name+'"]').removeClass('is-invalid');
            }
        });

        // Prevent cloning if not valid
        if (!allFieldsFilled) {
        	   var msg = '<span class="text-danger"><liferay-ui:message key="please-fill-all-required-fields-of-current-section-before-adding-another"/></span>';
	            $('#validation-message').html(msg);
	            $("#validationPopupModal").modal('show');
            return;
        }else{
        	 saveForm("save");
        }
        
    });
	
    let formCount = 1;
    const maxForms = 5;

    function updateRemoveButtonsVisibility() {
        if ($('.facilityFormSection').length === 1) {
            $('#removeFormBtn').hide();
        } else {
            $('#removeFormBtn').show();
        }
    }

    $('#addMoreFormBtn').on('click', function () {
    	
        let $previousSection = $('.facilityFormSection').last();

        let allFieldsFilled = true;
        let requiredFields = [
        	 'facilityName', 'facilityType' , 'sportsName', 'facilityArea', 'division', 'district', 'taluka', 'sportsCourt','city','address','mainTypeOfFacility',
             'courtNameNumber','availableFacilities', /* 'notWorkingReason', */'capacity','remarks','sportsCourt','contactPersonEmail',
        ];
       
        $.each(requiredFields, function(idx, name) {
            let val = $previousSection.find('[name="'+name+'"]').val();
            if (!val || val.trim() === '') {
                allFieldsFilled = false;
                $previousSection.find('[name="'+name+'"]').addClass('is-invalid');
            } else {
                $previousSection.find('[name="'+name+'"]').removeClass('is-invalid');
            }
        }); 

        // Optionally: check location filled in
        let latitude = $previousSection.find('input[name="latitude"]').val();
        let longitude = $previousSection.find('input[name="longitude"]').val();
        if (!latitude || !longitude) {
            allFieldsFilled = false;
            // show error next to map/location
            $previousSection.find('.form-group:has(#locationSearch)').append('<span class="text-danger location-error-msg">Please set location on map.</span>');
        } else {
            $previousSection.find('.location-error-msg').remove();
        }

        // Prevent cloning if not valid
        if (!allFieldsFilled) {
        	   var msg = '<span class="text-danger"><liferay-ui:message key="please-fill-all-required-fields-of-current-section-before-adding-another"/></span>';
	            $('#validation-message').html(msg);
	            $("#validationPopupModal").modal('show');
            return;
        }
    	
    	// If Previous form valid continue adding clone --------------------------
    	
        if (formCount >= maxForms) {
            alert("You can add a maximum of " + maxForms + " facilities.");
            return;
        }

        formCount++;

        // Clone the last section
        let $lastSection = $('.facilityFormSection').last();
        let $newSection = $lastSection.clone();
        // Update data-index
        $newSection.attr('data-index', formCount);

        // Clear field values in new section
        $newSection.find('input[type="text"], input[type="number"], textarea').val('');
        $newSection.find('input[type="checkbox"]').prop('checked', false);
        

     // Update IDs
        $newSection.find('[id]').each(function () {
            const oldId = $(this).attr('id');
            const newId = oldId.split('_')[0] + '_' + formCount; // Change "locationSearch_2_3" to "locationSearch_3"
            $(this).attr('id', newId);
        });

        $newSection.find('input[type="text"], input[type="number"], textarea').val('');
        $newSection.find('input[type="checkbox"]').prop('checked', false);
        $newSection.find('#notWorkingReasonDiv_' + formCount).hide();
        
        // Update IDs and names for radio buttons
      /*   $newSection.find('input[type="radio"]').each(function() {
            const oldId = $(this).attr('id');
            const oldName = $(this).attr('name');

            const newId = oldId.split('_')[0] + '_' + formCount;
            const newName = oldName.split('_')[0] + '_' + formCount;

            $(this).attr('id', newId).attr('name', newName);
            $(this).prop('checked', false);
        }); */
        
    
        
        // Append first
        $('#sportsFacilityContainer').append($newSection);
        
        $newSection.find('input[name="latitude"]').attr('id', 'latitude_' + formCount).val('');
        $newSection.find('input[name="longitude"]').attr('id', 'longitude_' + formCount).val('');
        $newSection.find('[id^="map_"]').attr('id', 'map_' + formCount).addClass('d-none'); 
        
        // Remove all existing onclick on cloned buttons so old handlers don't stay
        $newSection.find('button[id^="searchLocationBtn"]').off('click');

        // Add the click handler dynamically passing correct parameters
        $newSection.find('button[id^="searchLocationBtn"]').on('click', function() {
            var idx = formCount; // current block index
            searchLocation('locationSearch_' + idx, 'map_' + idx, 'locationNotFound_' + idx, idx);
        });

        // Show map container
        $newSection.find('#map_' + formCount).removeClass('d-none');

        // Initialize map for this new section
        initializeMap(defaultLat, defaultLon, true, 'map_' + formCount, formCount);
        
        updateRemoveButtonsVisibility();
    });

    $('#removeFormBtn').on('click', function () {
        if ($('.facilityFormSection').length > 1) {
            $('.facilityFormSection').last().remove();
            formCount--;
            updateRemoveButtonsVisibility();
        }
    });

    // Initially hide remove button if only one section
    updateRemoveButtonsVisibility();

 // Division change handler
    $(document).on('change', 'select[name="division"]', function () {
        const $section = $(this).closest('.facilityFormSection'); // current section
        const divisionId = $(this).val();

        console.log("Division Changed ------------- " + divisionId);

        const $districtSelect = $section.find('select[name="district"]');
        const $talukaSelect = $section.find('select[name="taluka"]');

        $districtSelect.empty().append('<option value="">Select</option>');
        $talukaSelect.empty().append('<option value="">Select</option>');

        if (divisionId) {
            $.ajax({
                url: '${getDistricts}',
                type: 'GET',
                data: { divisionId: divisionId },
                success: function (data) {
                    let districts = typeof data === "string" ? JSON.parse(data) : data;
                    if (districts && districts.length > 0) {
                        $.each(districts, function (index, value) {
                            $districtSelect.append('<option value="' + value.districtId + '">' + value.districtName + '</option>');
                        });
                    } else {
                        $districtSelect.append('<option value="">No districts available</option>');
                    }
                }
            });
        }
    });

    // District change handler
    $(document).on('change', 'select[name="district"]', function () {
        const $section = $(this).closest('.facilityFormSection'); // current section
        const districtId = $(this).val();

        const $talukaSelect = $section.find('select[name="taluka"]');
        $talukaSelect.empty().append('<option value="">Select</option>');

        if (districtId) {
            $.ajax({
                url: '${getTalukas}',
                type: 'GET',
                data: { districtId: districtId },
                success: function (data) {
                    let talukas = typeof data === "string" ? JSON.parse(data) : data;
                    if (talukas && talukas.length > 0) {
                        $.each(talukas, function (index, value) {
                            $talukaSelect.append('<option value="' + value.talukaId + '">' + value.talukaName + '</option>');
                        });
                    } else {
                        $talukaSelect.append('<option value="">No talukas available</option>');
                    }
                }
            });
        }
    });

    
});

function setDivisionDistrictTaluks(){
	  const selectedDivision = '${sportsFacilityMaster.division}';
	    const selectedDistrict = '${sportsFacilityMaster.district}';
	    const selectedTaluka = '${sportsFacilityMaster.taluka}';
	    
	    console.log("selectedDivision::::::: "+selectedDivision);
	    
	    if (selectedDivision) {
	        $('#division').val(selectedDivision);

	        // Fetch and populate districts
	        $.ajax({
	            url: '${getDistricts}',
	            type: 'GET',
	            data: { divisionId: selectedDivision },
	            success: function (districtData) {
	                const $district = $('#district');
	                districtData = typeof districtData === 'string' ? JSON.parse(districtData) : districtData;

	                console.log("districtData:: "+districtData);
	                $.each(districtData, function (i, d) {
	                    const selected = d.districtId == selectedDistrict ? 'selected' : '';
	                    $district.append('<option value="' + d.districtId + '" ' + selected + '>' + d.districtName + '</option>');
	                });

	                if (selectedDistrict) {
	                    // Fetch and populate talukas
	                    $.ajax({
	                        url: '${getTalukas}',
	                        type: 'GET',
	                        data: { districtId: selectedDistrict },
	                        success: function (talukaData) {
	                           const $taluka = $('#taluka');
	                            $taluka.empty().append('<option value="">Select</option>');

	                            talukaData = typeof talukaData === 'string' ? JSON.parse(talukaData) : talukaData;
	                            console.log("talukaData:: "+talukaData);
	                            $.each(talukaData, function (i, t) {
	                                const selected = t.talukaId == selectedTaluka ? 'selected' : '';
	                                $taluka.append('<option value="' + t.talukaId + '" ' + selected + '>' + t.talukaName + '</option>');
	                            });
	                        }
	                    });
	                }section
	            }
	        });
	    }
}

function saveForm(actionType){
	 console.log("All validations are passed and saving Form ------ ");
	 console.log("actionType: "+actionType);
	 let sportsFacilityFormId = $('#sportsFacilityFormId').val();
	 console.log("sportsFacilityFormId: "+sportsFacilityFormId);
	 let mode = '${mode}';
	 
	 if(mode != "view"){
		 const form = document.getElementById("sportsFacilityForm");
		 if(mode == "edit"){
		    form.querySelectorAll("[disabled]").forEach(function (el) {
		        el.disabled = false;
		    });
		 }

		    const formData = new FormData(form); 
		    formData.append("actionType", actionType);
		    formData.append("mode", mode);
		    if(sportsFacilityFormId){
		    	formData.append("sportsFacilityFormId", sportsFacilityFormId);
		    }
		 
		 $.ajax({
		        type: "POST",
		        url: "${SaveSportsFacilityUrl}",
		        data: formData,
		        contentType : false,
				cache : false,
				processData : false,
		        success: function(data){
		        console.log("data:: "+data)
		        if (data === "success") {
		            var msg = '<span class="text-success"><liferay-ui:message key="details-submitted-successfully"/></span>';
		            if(mode == "edit"){
		            	$('#submitBtn').prop('disabled', true);
		            	msg = '<span class="text-success"><liferay-ui:message key="the-details-are-updated-successfully"/></span>';
		            }
		            $('#success-message').html(msg);
		            $('#submitBtn').prop('disabled', true);
		            $("#saveFacilityModal").modal('show');
		        } else {
		            var msg = '<span class="text-danger"><liferay-ui:message key="the-details-are-failed-to-submit"/></span>';
		            $('#success-message').html(msg);
		            $("#saveFacilityModal").modal('show');
		        }
		    	 }
		    });
	 }else{
		var msg = "<liferay-ui:message key='you-canot-submit-details-in-view-mode'/>";
	    $('#success-message').html(msg);
		 $("#saveFacilityModal").modal('show');
	 }
	 
}

// Map
var map;
var marker;
var latElement = document.getElementById('latitude');
var lonElement = document.getElementById('longitude');

// Retrieve stored coordinates
var storedLat = parseFloat(latElement.value);
var storedLon = parseFloat(lonElement.value);
 
function getLocation() {debugger
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(position => {
            const lat = position.coords.latitude;
            const lon = position.coords.longitude;
            $("#map_1").removeClass("d-none");
            initializeMap(lat, lon, true,'map_1','1'); // Edit mode
        }, showError);
    } else {
        alert("Geolocation is not supported by this browser.");
    }
}
 
function initializeMap(lat, lon, isEditable, mapId,index) {
    var mapKey = 'map_' + mapId;
    var markerKey = 'marker_' + mapId;
    if (!window[mapKey] || typeof window[mapKey].setView !== 'function') {
        window[mapKey] = L.map(mapId).setView([lat, lon], 13);

        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
            attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
        }).addTo(window[mapKey]);

        window[markerKey] = L.marker([lat, lon], { draggable: isEditable }).addTo(window[mapKey]);
    } else {
        window[mapKey].setView([lat, lon], 13);

        if (window[markerKey]) {
            window[markerKey].setLatLng([lat, lon]);
        } else {
            window[markerKey] = L.marker([lat, lon], { draggable: isEditable }).addTo(window[mapKey]);
        }
    }

    if (isEditable) {
        window[mapKey].on('click', function(e) {
            updateCoordinates(e.latlng.lat, e.latlng.lng, mapId,index);
        });

        window[markerKey].on('dragend', function(event) {
            var updatedLatLng = event.target.getLatLng();
            updateCoordinates(updatedLatLng.lat, updatedLatLng.lng, mapId,index);
        });
    }
    // Update hidden fields for this map
    updateCoordinates(lat, lon, mapId,index);
}

 
//Modified updateCoordinates for multiple maps
function updateCoordinates(lat, lon, mapId,index) {
	console.log("calling latitude and longitude::::::::: lat:: "+lat +", lon:: "+lon+", index: "+ index);
    var latElement = document.getElementById('latitude_' + index);
    var lonElement = document.getElementById('longitude_' + index);

    if (latElement) latElement.value = lat.toFixed(6);
    if (lonElement) lonElement.value = lon.toFixed(6);

    if (window['marker_' + mapId]) {
        window['marker_' + mapId].setLatLng([lat, lon]);
    }
}
 
function showError(error) {
    switch (error.code) {
        case error.PERMISSION_DENIED:
            alert("User denied the request for Geolocation.");
            break;
        case error.POSITION_UNAVAILABLE:
            alert("Location information is unavailable.");
            break;
        case error.TIMEOUT:
            alert("The request to get user location timed out.");
            break;
        case error.UNKNOWN_ERROR:
            alert("An unknown error occurred.");
            break;
    }
}

function searchLocation(locationSearchId, mapId,locationNotFound,index)  {
	
    var location = document.getElementById(locationSearchId).value;

    if (!location.trim()) {
        $("#locationNotFound").html("Please enter a location name.");
        return;
    }

    fetch('https://us1.locationiq.com/v1/search?key=pk.3fedb4a22572cf3542da5b4400f972e0&q=' 
          + encodeURIComponent(location) + '&format=json')
        .then(response => response.json())
        .then(function(data) {
            if (data.length > 0) {
                var lat = parseFloat(data[0].lat);
                var lon = parseFloat(data[0].lon);
                $('#'+mapId).removeClass('d-none');
                initializeMap(lat, lon, true,mapId,index);
                updateCoordinates(lat, lon,mapId, index);
                $("#"+locationNotFound).html('');
            } else {
                $("#"+locationNotFound).html("Location not found. Please try again.")
            }
        })
        .catch(function(err) {
            console.error('Geocoding error: ', err);
            $("#"+locationNotFound).html("We are facing a technical issue, please select a location on the map.");
        });
}



/* function searchLocation() {
    var location = document.getElementById('locationSearch').value;

    if (!location.trim()) {
    	$("#locationNotFound").html("Please enter a location name.")
        return;
    }

    fetch('https://nominatim.openstreetmap.org/search?format=json&q=' + encodeURIComponent(location))
        .then(function(response) {
            return response.json();
        })
        .then(function(data) {
            if (data.length > 0) {
                var lat = parseFloat(data[0].lat);
                var lon = parseFloat(data[0].lon);
                $('#map').removeClass('d-none');
                initializeMap(lat, lon, true); // allow editing
                updateCoordinates(lat, lon);   // update hidden fields
                $("#locationNotFound").html('');
            } else {
            	$("#locationNotFound").html("Location not found. Please try again.")
            }
        })
        .catch(function(err) {
            console.error('Geocoding error: ', err);
            $("#locationNotFound").html("We are facing a technical issue, please select a location on the map.");
        });
} */

</script>
