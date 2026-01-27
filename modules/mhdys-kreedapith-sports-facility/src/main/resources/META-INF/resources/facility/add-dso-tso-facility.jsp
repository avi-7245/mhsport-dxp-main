<%@page import="mhdys.kreedapith.sports.facility.constants.MhdysKreedapithSportsFacilityPortletKeys"%>
<%@ include file="/init.jsp"%>
<!-- Include Leaflet CSS & JS -->
<link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" />
<script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>

<portlet:resourceURL id="<%=MhdysKreedapithSportsFacilityPortletKeys.SAVE_SPORTSFACILITY_RESOURCECOMMAND %>" var="SaveSportsFacilityUrl" />

<portlet:resourceURL id="<%=MhdysKreedapithSportsFacilityPortletKeys.GET_DISTRICTS%>" var="getDistricts" />
<portlet:resourceURL id="<%=MhdysKreedapithSportsFacilityPortletKeys.GET_TALUKAS%>" var="getTalukas" />

<portlet:renderURL var="redirectUrl">
    <portlet:param name="mvcRenderCommandName" value="<%=MhdysKreedapithSportsFacilityPortletKeys.REDIRECT %>" />
</portlet:renderURL>

<div class="common-forms-div">
    <div class="container">
        <div class="row">
            <div class="card shadow border-0 w-100">
                <div class="card-header d-flex justify-content-between align-items-center back-btn-cn">
                    <h5 class="mb-0">
                        <liferay-ui:message key="facility-initiation-by-dso/tso" />
                    </h5>
                    <div>
                        <a href="#" class="btn btn-primary btn-sm rounded-pill back-btn-cn" onclick="backOrClearUrl()"><i class="bi bi-arrow-left-circle mr-1"></i><liferay-ui:message key="back" /></a>
                    </div>
                </div>
                <form id="sportsFacilityForm" method="POST" enctype="multipart/form-data" autocomplete="off">
                
               <input type="hidden" id="sportsFacilityFormId" value="">
                <div class="card-body">
                    <div class="card card-background p-0">
                        <div class="personal_details">
                            <div class="card-header header-card">
                                <liferay-ui:message key="facility-initiation-by-dso/tso" />
                            </div>
                            <div class="card-body">
                            
                           			 <c:choose>
								        <c:when test="${mode eq 'edit' || mode eq 'view' || !empty filteredList}">
								         	<div class="row">
												<c:if test="${!empty filteredList}">	
													<div class="col-md-6">
														<div class="form-group">
															<label><liferay-ui:message key="facility-Name"/><sup class="text-danger">*</sup></label>
															<select class="form-control" name="facilityNameDropdown" id="facilityNameDropdown">
																	<option value=""><liferay-ui:message key="select"/></option>
																	<c:forEach var="facility" items="${filteredList}">
																	    <option value="${facility.sportsFacilityId}">${facility.facilityName}</option>
																	</c:forEach>
															</select>
								
														</div>
													</div>
												</c:if>
												
													<c:choose>
												        <c:when test="${mode eq 'edit' || mode eq 'view'}">
												           <div class="col-md-6">
																<div class="form-group">
																	<label><liferay-ui:message key="facility-Name"/><sup class="text-danger">*</sup></label>
																	<input type="text" class="form-control" name="facilityName" id="facilityName" readonly="readonly">
																</div>
															</div>
												        </c:when>
												        <c:otherwise>
												           <div class="col-md-6">
																<div class="form-group d-none">
																	<label><liferay-ui:message key="facility-Name"/><sup class="text-danger">*</sup></label>
																	<input type="text" class="form-control" name="facilityName" id="facilityName" readonly="readonly">
																</div>
															</div>
												        </c:otherwise>
												    </c:choose>
						    
													 <div class="col-md-6">
														<div class="form-group">
															<label><liferay-ui:message key="facility-type"/><sup class="text-danger">*</sup></label>
															<select name="facilityType" id="facilityType" class="form-control" <c:if test="${mode eq 'view'}">disabled</c:if>>
																<option value=""><liferay-ui:message key="select" /></option>
																<option value="Division" <c:if test="${sportsFacilityMaster.facilityType eq 'Division'}">selected</c:if>>Division</option>
																<option value="District" <c:if test="${sportsFacilityMaster.facilityType eq 'District'}">selected</c:if>>District</option>
																<option value="Taluka" <c:if test="${sportsFacilityMaster.facilityType eq 'Taluka'}">selected</c:if>>Taluka</option>
															</select>
																<div class="invalid-feedback"><liferay-ui:message key="please-enter-valid-email" /></div>
														</div>
													</div>
													
													<!-- Sports Court -->
												 <div class="col-md-6">
													<div class="form-group">
														<label><liferay-ui:message key="sports-court"/><sup class="text-danger">*</sup></label>
														<input type="text" class="form-control" name="sportsCourt" id="sportsCourt"
															   value="${sportsFacilityMaster.sportsCourt}"
															   <c:if test="${mode eq 'view' }">disabled</c:if>>
														<!-- <div class="invalid-feedback"><liferay-ui:message key="please-enter-sports-court" /></div> -->
													</div>
												</div> 
													
													<div class="col-md-6">
														 <div class="form-group">
															<label><liferay-ui:message key="sport-names"/><sup class="text-danger">*</sup></label>
															<select name="sportsName" id="sportsName" class="form-control" <c:if test="${mode eq 'view'}">disabled</c:if> >
																<option value=""><liferay-ui:message key='select' /></option>
																<c:forEach var="sports" items="${sportsMaster}">
																	<option value="${sports.name_en}" <c:if test="${sportsFacilityMaster.sportsName == sports.name_en}">selected</c:if> >${sports.name_en}</option>
																</c:forEach>
															</select>
														<!-- 	<div class="invalid-feedback"><liferay-ui:message key='please-enter-sport-name' /></div> -->
														</div> 
														
													</div>
									
													<div class="col-md-6">
														<div class="form-group">
															<label><liferay-ui:message key="facility-Area"/><sup class="text-danger">*</sup></label>
															<input type="text" class="form-control" name="facilityArea" id="facilityArea" <c:if test="${mode eq 'view'}">disabled</c:if>>
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
															<!-- <div class="invalid-feedback"><liferay-ui:message key="please-select-division" /></div> -->
															
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
															<div class="invalid-feedback"><liferay-ui:message key="please-enter-valid-email" /></div>
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
												
												
												<div class="col-md-6">
												    <div class="form-group">
												        <label><liferay-ui:message key="available-facilities"/><sup class="text-danger">*</sup></label>
												        <select name="availableFacilities" id="availableFacilities" class="form-control" <c:if test="${mode eq 'view'}">disabled</c:if>>
												            <option value=""><liferay-ui:message key="select"/></option>
												            <option value="Working" <c:if test="${sportsFacilityMaster.availableFacilities eq 'Working'}">selected</c:if>> 
												              Working
												            </option>
												            <option value="Not Working" <c:if test="${sportsFacilityMaster.availableFacilities eq 'Not Working'}">selected</c:if>> 
												               Not Working
												            </option>
												        </select>
												        <div class="invalid-feedback"><liferay-ui:message key="please-select-available-facilities"/></div>
												    </div>
												</div>
												
													
													
												
												<!-- Not Working Reason -->
												<div class="col-md-6"
												     id="notWorkingReasonDiv"
												      style="<c:if test='${sportsFacilityMaster.availableFacilities ne "Not Working"}'>display:none;</c:if>"
												    >
												    <div class="form-group">
												        <label><liferay-ui:message key="not-working-reason"/><sup class="text-danger">*</sup></label>
												        <input type="text" class="form-control"
												               name="notWorkingReason"
												               id="notWorkingReason"
												               value="${sportsFacilityMaster.notWorkingReason}"
												               <c:if test='${mode eq "view"}'>disabled</c:if>>
												        <div class="invalid-feedback">
												            <liferay-ui:message key="please-enter-not-working-reason" />
												        </div>
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
													        <button type="button" class="btn btn-primary" onclick="searchLocation()" <c:if test="${mode eq 'view'}">disabled</c:if>>Search</button>
													    </div>
													    <span class="text-danger d-block" id="locationNotFound"></span>
													    
												        <button type="button" class="btn btn-primary d-none" id="getGisLocation" onclick="getLocation()" <c:if test="${mode eq 'view'}">disabled</c:if> >
												            <liferay-ui:message key="get-GIS-location" />
												        </button>
												    </div>
												    <!-- Map Container -->
									                 <div id="map" class="d-none" style="height: 300px; border: 1px solid #ccc; z-index: 1;"></div>
												   </div>
													
												  <div class="col-md-6 d-none">
													    <div class="form-group">
													        <label><liferay-ui:message key="latitude" /></label>
													        <input type="hidden" class="form-control" name="latitude" id="latitude"
													            placeholder="<liferay-ui:message key='latitude' />"
													            value="${latitude}" readonly />
													    </div>
													</div>
													
													<div class="col-md-6 d-none">
													    <div class="form-group">
													        <label><liferay-ui:message key="longitude" /></label>
													        <input type="hidden" class="form-control" name="longitude" id="longitude"
													            placeholder="<liferay-ui:message key='longitude' />"
													            value="${longitude}" readonly />
													    </div>
													</div>
												  <!-- Map Container Ends -->
												
												<%-- <div class="col-md-6 mt-4">
													<div class="form-group">
														<label for="type"><liferay-ui:message key="type" /><sup class="text-danger">*</sup></label>
														<div class="d-flex mt-2">
														<div class="radio-text mx-4">
															<input type="checkbox" class="form-check-input typeCheckBox" name="typeCheckBox" id="type_monthly" value="Monthly Pass" <c:if test="${mode eq 'view'}">disabled</c:if>>
															<label class="form-check-label mr-3" for="type_monthly"><liferay-ui:message key="monthly-pass" /></label>
														</div>
														<div class="radio-text mx-4">
															<input type="checkbox" class="form-check-input typeCheckBox" name="typeCheckBox" id="type_rent" value="Rent Booking" <c:if test="${mode eq 'view'}">disabled</c:if>>
															<label class="form-check-label" for=type_rent><liferay-ui:message key="rent-booking" /></label>
															</div>
														</div>
													</div>
												</div>
													
												  <div class="col-md-6 mt-4">
														<div class="form-group">
															<label><liferay-ui:message key="fees"/><sup class="text-danger">*</sup></label>
															<input type="number" step="0.01" class="form-control" name="fees" id="fees" <c:if test="${mode eq 'view'}">disabled</c:if>>
														</div>
													</div> --%>
													
													<!-- Extra/additional fields -->
													
													<div class="col-md-6">
														<div class="form-group">
															<label><liferay-ui:message key="booking-Url"/><sup class="text-danger">*</sup></label>
															<input type="text" class="form-control" name="bookingUrl" id="bookingUrl" <c:if test="${mode eq 'view'}">readonly</c:if>>
														</div>
													</div>
													
												     <div class="col-md-6">
														<div class="form-group">
															<label><liferay-ui:message key="contact-Person-Name"/><sup class="text-danger">*</sup></label>
															<input type="text" class="form-control" name="contactPersonName" id="contactPersonName" <c:if test="${mode eq 'view'}">readonly</c:if>>
														</div>
													</div>
													
													<div class="col-md-6">
														<div class="form-group">
															<label><liferay-ui:message key="contact-Person-Number"/><sup class="text-danger">*</sup></label>
															<input type="text" class="form-control" name="contactPersonNumber" id="contactPersonNumber" <c:if test="${mode eq 'view'}">readonly</c:if>>
														</div>
													</div>
													
												
													  <div class="col-md-6">
														  <div class="form-group">
														    <label for="GeoTagPhoto">
														      <liferay-ui:message key="geo-tag-photo" />
														      <sup class="text-danger">*</sup>
														      <em class="bi bi-info-circle-fill" title="<liferay-ui:message key='allowed-only-jpg-jpeg-png-file-of-size-2mb' />"></em>
														    </label>
														
														    <div class="custom-file">
														      <input type="file" class="custom-file-input geoTagPhoto" id="GeoTagPhoto" name="GeoTagPhoto" multiple
														        onchange="handleMultipleFileUpload(this, 'GeoTagPhoto', 'geoTagPhotoPreviewContainer', 'geoTagPhotoPreviewList', 'geoTagPhotoError', 'geoTagPhotoHiddenInput')"
														        <c:if test="${mode eq 'view'}">disabled</c:if> />
														      <label class="custom-file-label" for="GeoTagPhoto"><liferay-ui:message key="choose-file" /></label>
														    </div>
														
														    <span id="geoTagPhotoError" class="text-danger mt-2 d-block"></span>
														    
														    <input type="hidden" id="geoTagPhotoHiddenInput" name="geoTagPhotoHiddenInput" />
														
														    <div class="mt-3" id="geoTagPhotoPreviewContainer" style="display: none;">
														      <ul id="geoTagPhotoPreviewList" class="list-group"></ul>
														    </div>
														  </div>
														</div>
												</div>
												
												
												<!--  Fees Details -->
												
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
														        <td><input type="number" step="1" min="0" name="assocPerHour" id="assocPerHour" class="form-control"
														                   <c:if test="${mode eq 'view'}">readonly</c:if>></td>
														        <td><input type="number" step="1" min="0" name="assocPerDay" id="assocPerDay" class="form-control"
														                   <c:if test="${mode eq 'view'}">readonly</c:if>></td>
														        <td><input type="number" step="1" min="0" name="assocPerMonth" id="assocPerMonth" class="form-control"
														                   <c:if test="${mode eq 'view'}">readonly</c:if>></td>
														    </tr>
														    <tr>
														        <td><liferay-ui:message key="rent-other-sports-events" /></td>
														        <td><input type="number" step="1" min="0" name="rentOtherPerHour" id="rentOtherPerHour" class="form-control"
														                   <c:if test="${mode eq 'view'}">readonly</c:if>></td>
														        <td><input type="number" step="1" min="0" name="rentOtherPerDay" id="rentOtherPerDay" class="form-control"
														                   <c:if test="${mode eq 'view'}">readonly</c:if>></td>
														        <td><input type="number" step="1" min="0" name="rentOtherPerMonth" id="rentOtherPerMonth" class="form-control"
														                   <c:if test="${mode eq 'view'}">readonly</c:if>></td>
														    </tr>
														    <tr>
														        <td><liferay-ui:message key="rent-non-sports-events" /></td>
														        <td><input type="number" step="1" min="0" name="rentNonPerHour" id="rentNonPerHour" class="form-control"
														                   <c:if test="${mode eq 'view'}">readonly</c:if>></td>
														        <td><input type="number" step="1" min="0" name="rentNonPerDay" id="rentNonPerDay" class="form-control"
														                   <c:if test="${mode eq 'view'}">readonly</c:if>></td>
														        <td><input type="number" step="1" min="0" name="rentNonPerMonth" id="rentNonPerMonth" class="form-control"
														                   <c:if test="${mode eq 'view'}">readonly</c:if>></td>
														    </tr>
														    <tr>
														        <td><liferay-ui:message key="individual" /></td>
														        <td><input type="number" step="1" min="0" name="indPerHour" id="indPerHour" class="form-control"
														                   <c:if test="${mode eq 'view'}">readonly</c:if>></td>
														        <td><input type="number" step="1" min="0" name="indPerDay" id="indPerDay" class="form-control"
														                   <c:if test="${mode eq 'view'}">readonly</c:if>></td>
														        <td><input type="number" step="1" min="0" name="indPerMonth" id="indPerMonth" class="form-control"
														                   <c:if test="${mode eq 'view'}">readonly</c:if>></td>
														    </tr>
														    <tr>
														        <td><liferay-ui:message key="shooting-rapid-event" /></td>
														        <td><input type="number" step="1" min="0" name="shootingPerHour" id="shootingPerHour" class="form-control"
														                   <c:if test="${mode eq 'view'}">readonly</c:if>></td>
														        <td><input type="number" step="1" min="0" name="shootingPerDay" id="shootingPerDay" class="form-control"
														                   <c:if test="${mode eq 'view'}">readonly</c:if>></td>
														        <td><input type="number" step="1" min="0" name="shootingPerMonth" id="shootingPerMonth" class="form-control"
														                   <c:if test="${mode eq 'view'}">readonly</c:if>></td>
														    </tr>
														    <tr>
														        <td><liferay-ui:message key="all-arena-lights" /></td>
														        <td><input type="number" step="1" min="0" name="lightsPerHour" id="lightsPerHour" class="form-control"
														                   <c:if test="${mode eq 'view'}">readonly</c:if>></td>
														        <td></td>
														        <td></td>
														    </tr>
														    <tr>
														        <td><liferay-ui:message key="ac" /></td>
														        <td><input type="number" step="1" min="0" name="acPerHour" id="acPerHour" class="form-control"
														                   <c:if test="${mode eq 'view'}">readonly</c:if>></td>
														        <td></td>
														        <td></td>
														    </tr>
														</tbody>
					
												    </table>
												</div>
							
									        </c:when>
									        <c:otherwise>
									           <div class="text-center"><p><liferay-ui:message key="no-facilities-are-available-right-now" /></p></div>
									        </c:otherwise>
									    </c:choose>
								    
								    
                            </div> <!-- .card-body (inner) -->
                        </div> <!-- .personal_details -->
                    </div> <!-- .card-background -->
                </div> <!-- .card-body (outer) -->
                
                
                <c:choose>
			        <c:when test="${mode eq 'view' || (type eq 'initiateForm' && empty filteredList)}">
			           
			        </c:when>
			        <c:otherwise>
						  <div class="card-footer bg-transparent text-right p-4">
							 <div class="d-flex justify-content-end">
					            <a href="javascript:void(0);" onclick="window.location.href='<%= MhdysKreedapithSportsFacilityPortletKeys.HOMEURL %>?clear=true';" class="btn btn-secondary maha-save-btn" id="modalCloseBtn">
								    <liferay-ui:message key="cancel"/>
								</a>
							    <button type="button" class="btn btn-primary reset-btn" id="reset-btn">
							      <liferay-ui:message key="reset" />
							    </button>
							    <button type="button" class="btn btn-primary submit-btn" id="submitBtn">
							       <c:if test="${mode eq 'edit'}"><liferay-ui:message key="update" /></c:if> 
							       <c:if test="${mode ne 'edit'}"><liferay-ui:message key="submit" /></c:if> 
							    </button>
								</div>
							</div>
			        </c:otherwise>
			    </c:choose>
												    
            <%--     <c:if test="${mode ne 'view'}">
	                <div class="card-footer bg-transparent text-right p-4">
						 <div class="d-flex justify-content-end">
				            <a href="javascript:void(0);" onclick="window.location.href='<%= MhdysKreedapithSportsFacilityPortletKeys.HOMEURL %>?clear=true';" class="btn btn-secondary maha-save-btn" id="modalCloseBtn">
							    <liferay-ui:message key="cancel"/>
							</a>
						    <button type="button" class="btn btn-primary reset-btn" id="reset-btn">
						      <liferay-ui:message key="reset" />
						    </button>
						    <button type="button" class="btn btn-primary submit-btn" id="submitBtn">
						       <c:if test="${mode eq 'edit'}"><liferay-ui:message key="update" /></c:if> 
						       <c:if test="${mode ne 'edit'}"><liferay-ui:message key="submit" /></c:if> 
						    </button>
						    
					</div>
				</div>
				</c:if> --%>
           </form>     
            </div> <!-- .card -->
        </div> <!-- .row -->
    </div> <!-- .container -->
</div> <!-- .common-forms-div -->


<!-- Validation modal -->
<div class="modal fade" id="saveConstructionModal" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true" tabindex="-1" data-backdrop="static" data-keyboard="false">
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
		    <a href="#" class="btn btn-secondary maha-save-btn" id="modalCloseBtn" onclick="closeModal()">
		                <liferay-ui:message key="close"/>
		    </a>
		</div>

    </div>
  </div>
</div>

<script>

$('.typeCheckBox').on('change', function () {
    if (this.checked) {
        $('.typeCheckBox').not(this).prop('checked', false);
    }
});

function backOrClearUrl() {
	var mode = "${mode}";
	var isCreateMode = mode === "" || null;
	if(isCreateMode){
    	window.location.href = "<%=MhdysKreedapithSportsFacilityPortletKeys.HOMEURL%>?clear=true";
	}else{
		window.location.href = "${redirectUrl}&type=dsoTsoFacilityList&clear=true";
	}
}

var uploadedFilesGeoTagPhoto = [];
var $form = $("#sportsFacilityForm");


function closeModal(){
	 $("#saveConstructionModal").modal('hide');
	 var mode = "${mode}";
		var isCreateMode = mode === "" || null;
		if(isCreateMode){
	    	window.location.href = "<%=MhdysKreedapithSportsFacilityPortletKeys.HOMEURL%>?clear=true";
		}else{
			window.location.href = "${redirectUrl}&type=dsoTsoFacilityList&clear=true";
		}
}

$("#reset-btn").on("click", function () {
	let mode = '${mode}';
	if(mode == "edit"){
		//$('#bookingUrl, #contactPersonName, #contactPersonNumber').val('');
		resetFiles();
		var $form = $("#sportsFacilityForm");
		$form.find("input, select, textarea").each(function(){
		  $(this).data("val", $(this).val());
		});
		$form[0].reset();
		$form.find(":input:disabled, :input[readonly]").each(function(){
		  $(this).val($(this).data("val"));
		});
		 $("#sportsFacilityForm").validate().resetForm(); // Clear validation
	}else{
		resetFiles();
		$("#sportsFacilityForm")[0].reset(); // Reset all fields
		$("#sportsFacilityForm").validate().resetForm(); // Clear validation
	}
  
});
function resetFiles(){

	 uploadedFilesGeoTagPhoto = [];
	    // 2. Reset DOM elements
	    const previewContainer = document.getElementById("geoTagPhotoPreviewContainer");
	    const previewList = document.getElementById("geoTagPhotoPreviewList");
	    const errorSpan = document.getElementById("geoTagPhotoErrorSpan");
	    const hiddenInput = document.getElementById("geoTagPhotoHiddenInput");
	    const fileInput = document.getElementById("GeoTagPhoto");

	    if (previewList) previewList.innerHTML = "";
	    if (previewContainer) previewContainer.style.display = "none";
	    if (errorSpan) {
	        errorSpan.textContent = "";
	        errorSpan.style.display = "none";
	    }
	    if (hiddenInput) hiddenInput.value = "";
	    if (fileInput) fileInput.value = "";
	    clearInputFile("GeoTagPhoto");
}

$(document).ready(function () {
	
	 
	
	

    var facilitiesListStr = '${empty filteredList ? "[]" : filteredList}';
    var facilitiesList = JSON.parse(facilitiesListStr);
    console.log("facilitiesList:: "+facilitiesList);
    $('#facilityNameDropdown').on('change', function () {
        const selectedId = $(this).val();
        if (!selectedId) {
            // Clear all fields
            $('#facilityName, #facilityType, #sportsName, #facilityArea, #fees, #division, #district, #taluka').val('');
            $('input[type=checkbox][name=typeCheckBox]').prop('checked', false);
            return;
        }

        const selectedFacility = facilitiesList.find(f => f.sportsFacilityId == selectedId);
        if (selectedFacility) {
        	setDivisionDistrictTaluks(selectedFacility);
        	$("#sportsFacilityForm").validate().resetForm(); // clear validation errors
            $('#sportsFacilityFormId').val(selectedFacility.sportsFacilityId);
            $('#facilityName').val(selectedFacility.facilityName);
            $('#facilityType').val(selectedFacility.facilityType);
            $('#sportsName').val(selectedFacility.sportsName);
            $('#facilityArea').val(selectedFacility.facilityArea);
           /*  $('#fees').val(selectedFacility.fees); */
            /* $('#bookingUrl').val(selectedFacility.bookingUrl || '');
            $('#contactPersonName').val(selectedFacility.contactPersonName || '');
            $('#contactPersonNumber').val(selectedFacility.contactPersonNumber || ''); */
         // Association & Federation
            $('#assocPerHour').val(selectedFacility.assoc_fed_perHour);
            $('#assocPerDay').val(selectedFacility.assoc_fed_perDay);
            $('#assocPerMonth').val(selectedFacility.assoc_fed_perMonth);

            // Rent for Other Sports Events
            $('#rentOtherPerHour').val(selectedFacility.rent_other_sports_perHour);
            $('#rentOtherPerDay').val(selectedFacility.rent_other_sports_perDay);
            $('#rentOtherPerMonth').val(selectedFacility.rent_other_sports_perMonth);

            // Rent for Non-Sports Events
            $('#rentNonPerHour').val(selectedFacility.rent_nonsports_perHour);
            $('#rentNonPerDay').val(selectedFacility.rent_nonsports_perDay);
            $('#rentNonPerMonth').val(selectedFacility.rent_nonsports_perMonth);

            // Individual
            $('#indPerHour').val(selectedFacility.individual_perHour);
            $('#indPerDay').val(selectedFacility.individual_perDay);
            $('#indPerMonth').val(selectedFacility.individual_perMonth);

            // Shooting - Rapid Event
            $('#shootingPerHour').val(selectedFacility.shooting_rapid_perHour);
            $('#shootingPerDay').val(selectedFacility.shooting_rapid_perDay);
            $('#shootingPerMonth').val(selectedFacility.shooting_rapid_perMonth);

            // Arena Lights & AC
            $('#lightsPerHour').val(selectedFacility.arena_lights_perHour);

            $('#acPerHour').val(selectedFacility.ac_perHour);
				

            // Latitude/Longitude
            $('#latitude').val(selectedFacility.latitude);
            $('#longitude').val(selectedFacility.longitude);

            $('#sportsCourt').val(selectedFacility.sportsCourt);
            $('#contactPersonEmail').val(selectedFacility.contactPersonEmail);
            $('#city').val(selectedFacility.city);
            $('#address').val(selectedFacility.address);
            $('#mainTypeOfFacility').val(selectedFacility.mainTypeOfFacility);
            $('#courtNameNumber').val(selectedFacility.courtNameNumber);
            $('#capacity').val(selectedFacility.capacity);
            $('#remarks').val(selectedFacility.remarks);
            $('#availableFacilities').val(selectedFacility.availableFacilities);
            $('#notWorkingReason').val(selectedFacility.notWorkingReason);
            
            // Optional: Auto-show map
            if (selectedFacility.latitude && selectedFacility.longitude) {
                $("#map").removeClass("d-none");
                initializeMap(parseFloat(selectedFacility.latitude), parseFloat(selectedFacility.longitude), true);
            }
        }

    });
    
    function toggleNotWorkingReason() {
        const selected = $('#availableFacilities').val();
        if (selected === 'Not Working') {
            $('#notWorkingReasonDiv').show();
        } else {
            $('#notWorkingReasonDiv').hide();
            $('#notWorkingReason').val(''); // optional: clear input when hidden
        }
    }

    // Run immediately after setting the value
    toggleNotWorkingReason();

    // Run whenever dropdown changes
    $('#availableFacilities').on('change', function() {debugger
        toggleNotWorkingReason();
    });
    
    /* If Editing after Availablity */
    var sportsFacilityMasterStr = '${empty sportsFacilityMaster ? "[]" : sportsFacilityMaster}';
    var sportsFacilityMaster = JSON.parse(sportsFacilityMasterStr);
    console.log("sportsFacilityMaster -- "+sportsFacilityMaster);
    
    setDivisionDistrictTaluks(sportsFacilityMaster);
    
    if(sportsFacilityMaster){
    	  $('#sportsFacilityFormId').val(sportsFacilityMaster.sportsFacilityId);
          $('#facilityName').val(sportsFacilityMaster.facilityName);
          $('#facilityType').val(sportsFacilityMaster.facilityType);
          $('#sportsName').val(sportsFacilityMaster.sportsName);
          $('#facilityArea').val(sportsFacilityMaster.facilityArea);
          /* $('#fees').val(sportsFacilityMaster.fees); */
          $('#bookingUrl').val(sportsFacilityMaster.bookingUrl || '');
          $('#contactPersonName').val(sportsFacilityMaster.contactPersonName || '');
          $('#contactPersonNumber').val(sportsFacilityMaster.contactPersonNumber || '');
          
       // Association & Federation
          $('#assocPerHour').val(sportsFacilityMaster.assoc_fed_perHour);
          $('#assocPerDay').val(sportsFacilityMaster.assoc_fed_perDay);
          $('#assocPerMonth').val(sportsFacilityMaster.assoc_fed_perMonth);

          // Rent for Other Sports Events
          $('#rentOtherPerHour').val(sportsFacilityMaster.rent_other_sports_perHour);
          $('#rentOtherPerDay').val(sportsFacilityMaster.rent_other_sports_perDay);
          $('#rentOtherPerMonth').val(sportsFacilityMaster.rent_other_sports_perMonth);

          // Rent for Non-Sports Events
          $('#rentNonPerHour').val(sportsFacilityMaster.rent_nonsports_perHour);
          $('#rentNonPerDay').val(sportsFacilityMaster.rent_nonsports_perDay);
          $('#rentNonPerMonth').val(sportsFacilityMaster.rent_nonsports_perMonth);

          // Individual
          $('#indPerHour').val(sportsFacilityMaster.individual_perHour);
          $('#indPerDay').val(sportsFacilityMaster.individual_perDay);
          $('#indPerMonth').val(sportsFacilityMaster.individual_perMonth);

          // Shooting - Rapid Event
          $('#shootingPerHour').val(sportsFacilityMaster.shooting_rapid_perHour);
          $('#shootingPerDay').val(sportsFacilityMaster.shooting_rapid_perDay);
          $('#shootingPerMonth').val(sportsFacilityMaster.shooting_rapid_perMonth);

          // Arena Lights & AC
          $('#lightsPerHour').val(sportsFacilityMaster.arena_lights_perHour);

          $('#acPerHour').val(sportsFacilityMaster.ac_perHour);

          // Handle checkbox values
          $('input[type=checkbox][name=typeCheckBox]').each(function () {
              const val = $(this).val();
              $(this).prop('checked', sportsFacilityMaster.type?.includes(val));
          });

          // Latitude/Longitude
          $('#latitude').val(sportsFacilityMaster.latitude);
          $('#longitude').val(sportsFacilityMaster.longitude);

          // Optional: Auto-show map
          if (sportsFacilityMaster.latitude && sportsFacilityMaster.longitude) {
              $("#map").removeClass("d-none");
              initializeMap(parseFloat(sportsFacilityMaster.latitude), parseFloat(sportsFacilityMaster.longitude), true);
          }
    }
    
    let geoTagPhotoJson = ${not empty geoTagPhoto ? geoTagPhoto : '[]'};
	console.log("geoTagPhotoJson:: "+geoTagPhotoJson);

	if (Array.isArray(geoTagPhotoJson)) {
	    uploadedFilesGeoTagPhoto = geoTagPhotoJson.map(item => ({
	        name: item.fileName,
	        fileEntryId: item.fileEntryId,
	        url: item.url || '#',
	        isExisting: true,
	        markedForDelete: false
	    }));
	    renderFilePreviews("GeoTagPhoto", document.getElementById("geoTagPhotoPreviewContainer"), document.getElementById("geoTagPhotoPreviewList"), document.getElementById("geoTagPhotoError"), document.getElementById("geoTagPhotoHiddenInput"));
	}
	
	/* --------------------------------------- */
    let validationRules = {
    	facilityNameDropdown: { required: true },
    	 facilityName: { required: true,alphanumericOnly:true,singleSpaceOnly:true, noEdgeSpaces:true, minlength: 3, maxlength: 75 },
        /*  facilityType: { required: true, alphanumericOnly:true,singleSpaceOnly:true, noEdgeSpaces:true, minlength: 3, maxlength: 75 }, */
         facilityArea: { required: true,alphanumericOnly:true,singleSpaceOnly:true, noEdgeSpaces:true, minlength: 3, maxlength: 75 },
         sportsName: { required: true },
         typeCheckBox: { required: true },
         fees: { required: true, number: true, min: 1, max: 9999999999}, 
         division: { required: true },
         district: { required: true },
         taluka: { required: true },
        bookingUrl: { required: true,validBookingURL:true, minlength: 10, maxlength: 2083 },
        contactPersonName: { required: true,alphabetsOnly:true,singleSpaceOnly:true, noEdgeSpaces:true, minlength: 3, maxlength: 75 },
        contactPersonNumber: { required: true, number: true, validContact:true, minlength: 10, maxlength: 10 },
        facilityType: { required: true },
        sportsCourt:{ required: true,alphabetsOnly:true,singleSpaceOnly:true, noEdgeSpaces:true, minlength: 3, maxlength: 75 },
        city:{ required: true,alphanumericOnly:true,singleSpaceOnly:true, noEdgeSpaces:true, minlength: 3, maxlength: 75 },
        address:{ required: true,singleSpaceOnly:true, noEdgeSpaces:true,validAddress:true, minlength: 3, maxlength: 500 },
        mainTypeOfFacility:{ required: true,alphabetsOnly:true,singleSpaceOnly:true, noEdgeSpaces:true, minlength: 3, maxlength: 75 },
        courtNameNumber:{ required: true,alphanumericOnly:true,singleSpaceOnly:true, noEdgeSpaces:true, minlength: 3, maxlength: 75 },
        availableFacilities:{ required: true },
        notWorkingReason:{ required: true,alphanumericOnly:true,singleSpaceOnly:true, noEdgeSpaces:true,validateRemarks:true, minlength: 3, maxlength: 75 }, 
        capacity:{ required: true ,pattern: /^[1-9][0-9]*$/, number: true},
        remarks:{ required: true,singleSpaceOnly:true, noEdgeSpaces:true,validateRemarks:true, minlength: 3, maxlength: 500 },
        contactPersonEmail:{ required: true, singleSpaceOnly:true, noEdgeSpaces:true,maxlength: 75,validateEmail:true},
    };

    let validationMessages = {
    	
    	facilityNameDropdown: {
    		 required: "<liferay-ui:message key='please-enter-facility-name' />",
    	},
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
              required: "<liferay-ui:message key='please-select-sports-name' />",
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
        bookingUrl: {
            required: "<liferay-ui:message key='booking-url-required' />",
            minlength: "<liferay-ui:message key='please-enter-min-10-characters' />",
            maxlength: "<liferay-ui:message key='max-2083-chars' />"
        },
        contactPersonName: {
            required: "<liferay-ui:message key='contact-person-name-required' />",
            minlength: "<liferay-ui:message key='please-enter-min-3-chars' />",
            maxlength: "<liferay-ui:message key='please-enter-max-75-chars' />"
        },
        contactPersonNumber: {
            required: "<liferay-ui:message key='contact-person-number-required' />",
            number: "<liferay-ui:message key='only-numbers' />",
            minlength: "<liferay-ui:message key='contact-number-invalid-pattern' />",
            maxlength: "<liferay-ui:message key='contact-number-invalid-pattern' />"
        },
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

    $("#sportsFacilityForm").validate({
    	onkeyup: function (element) {
   	        $(element).valid();
   	    },
   	    onchange: function (element) {
   	        $(element).valid();
   	    },
        rules: validationRules,
        messages: validationMessages,
        errorElement: 'span',
        errorClass: 'text-danger',
        errorPlacement: function (error, element) {
            if (element.attr("name") === "typeCheckBox") {
                $('.d-flex.mt-2').next('span.text-danger').remove();
                $('.d-flex.mt-2').last().after(error);
            } else {
                error.insertAfter(element);
            }
        }
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
    
    $.validator.addMethod("validContact", function(value, element) {
        return this.optional(element) || /^[6-9]\d{9}$/.test(value);
    }, '<liferay-ui:message key="contact-number-invalid-pattern" />');

    $.validator.addMethod("validBookingURL", function(value, element) {
        if (this.optional(element)) return true;

        // Basic URL pattern (accepts http, https, optional www, domain, etc.)
        var urlPattern = /^(https?:\/\/)?(www\.)?[a-zA-Z0-9-]+\.[a-z]{2,}([\/\w\-\.]*)*\/?$/;

        return urlPattern.test(value);
    }, "<liferay-ui:message key='please-enter-valid-booking-url' />");

    $.validator.addMethod("alphabetsOnly", function(value, element) {
        return this.optional(element) || /^[A-Za-z ]+$/.test(value);
    }, "<liferay-ui:message key='please-enter-alphabets' />");
    
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
    		console.log("uploadedFilesGeoTagPhoto -- "+ uploadedFilesGeoTagPhoto.length);
    		 const activeFiles = uploadedFilesGeoTagPhoto.filter(f => !f.markedForDelete);
    		 let isFileValid = true;
    		 const isFormValid = $("#sportsFacilityForm").valid();
    	    const errorSpan = document.getElementById("geoTagPhotoError");
    		if (activeFiles.length == 0) {
    		    errorSpan.textContent = "<liferay-ui:message key='please-upload-geo-tag-photo' />";
    		    errorSpan.style.display = "block";
    		    isFileValid = false;
    		}else {
    	        errorSpan.innerHTML = "";
    	        errorSpan.style.display = "none";
    	    }
    	    if(isFileValid && isFormValid){
    	    	console.log("Validations passed  ------------- ")
    	        saveForm("edit");  
    	    }
    	    
    	});
    	
    	 $('select[name="division"]').on('change', function () {
    	        const divisionId = $(this).val();
    	    	console.log("Division Changed ------------- "+divisionId)
    	        $("#district").val('');
    	        $("#taluka").val('');
    	        if (divisionId) {
    	            $.ajax({
    	                url: '${getDistricts}',
    	                type: 'GET',
    	                data: {
    	                    divisionId: divisionId
    	                },
    	                success: function (data) {
    	                    const $districtSelect = $("#district");
    	                    $districtSelect.empty();
    	    				console.log("Data ::: "+data);
    	                    let districts = typeof data === "string" ? JSON.parse(data) : data;

    	                    if (districts && districts.length > 0) {
    	                        $districtSelect.append('<option value="">Select</option>');

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

    	    $('select[name="district"]').on('change', function () {
    	        const districtId = $(this).val();
    	        $("#taluka").val('');
    	        if (districtId) {
    	            $.ajax({
    	                url: '${getTalukas}',
    	                type: 'GET',
    	                data: {
    	                    districtId: districtId
    	                },
    	                
    	                success: function (data) {
    	                    const $talukaSelect = $("#taluka");
    	                    $talukaSelect.empty();

    	                    let talukas = typeof data === "string" ? JSON.parse(data) : data;

    	                    if (talukas && talukas.length > 0) {
    	                        $talukaSelect.append('<option value="">Select</option>');

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




function saveForm(actionType){
	 console.log("All validations are passed and saving Form ------ ");
	 console.log("actionType: "+actionType);
	 let sportsFacilityFormId = $('#sportsFacilityFormId').val();
	 console.log("sportsFacilityFormId: "+sportsFacilityFormId);
	 let mode = '${mode}';
	 
	 if(mode != "view"){
		 
		 const form = document.getElementById("sportsFacilityForm");
		 if(mode == "edit" || actionType == "edit"){
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
		            	msg = '<span class="text-success"><liferay-ui:message key="the-details-are-updated-successfully"/></span>';
		            }
		            
		            $('#success-message').html(msg);
		            $('#submitBtn').prop('disabled', true);
		            $("#saveConstructionModal").modal('show');
		        } else {
		            var msg = '<span class="text-danger"><liferay-ui:message key="the-details-are-failed-to-submit"/></span>';
		            $('#success-message').html(msg);
		            $("#saveConstructionModal").modal('show');
		        }
		    	 }
		    });
	 }else{
		var msg = "<liferay-ui:message key='you-canot-submit-details-in-view-mode'/>";
	    $('#success-message').html(msg);
		 $("#saveConstructionModal").modal('show');
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
 
/* let isViewMode = typeof mode !== "undefined" && (mode === "view");
let isEditMode = typeof mode !== "undefined" && (mode === "edit");
 
 if ((isViewMode||isEditMode) && !isNaN(storedLat) && !isNaN(storedLon)) {
    $("#map").removeClass("d-none");
    initializeMap(storedLat, storedLon, false);
} */
 
function getLocation() {debugger
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(position => {
            const lat = position.coords.latitude;
            const lon = position.coords.longitude;
            $("#map").removeClass("d-none");
            initializeMap(lat, lon, true); // Edit mode
        }, showError);
    } else {
        alert("Geolocation is not supported by this browser.");
    }
}
 
function initializeMap(lat, lon, isEditable) {debugger
    if (!map) {
        map = L.map('map').setView([lat, lon], 13);
        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
            attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
        }).addTo(map);
        latElement.value = lat.toFixed(6);
        lonElement.value = lon.toFixed(6);
	    } else {
        map.setView([lat, lon], 13);
    }
 
    // Remove existing marker
    if (marker) {
        map.removeLayer(marker);
    }
 
    // Add marker with conditional interactivity
    marker = L.marker([lat, lon], { draggable: isEditable }).addTo(map);
 
    if (isEditable) {
        map.on('click', function (e) {
            updateCoordinates(e.latlng.lat, e.latlng.lng);
        });
 
        marker.on('dragend', function (event) {
            let updatedLatLng = event.target.getLatLng();
            updateCoordinates(updatedLatLng.lat, updatedLatLng.lng);
        });
    }
}
 
function updateCoordinates(lat, lon) {debugger
    latElement.value = lat.toFixed(6);
    lonElement.value = lon.toFixed(6);
    marker.setLatLng([lat, lon]);
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

/* Multiple Documents */


function handleMultipleFileUpload(fileInput, inputId, previewContainerId, previewListId, errorSpanId, hiddenInputId) {
    const previewContainer = document.getElementById(previewContainerId);
    const previewList = document.getElementById(previewListId);
    const errorSpan = document.getElementById(errorSpanId);
    const hiddenInput = document.getElementById(hiddenInputId);

    let uploadedFiles = getUploadedFileArray(inputId);

    const newFiles = Array.from(fileInput.files);
    const activeFilesCount = uploadedFiles.filter(f => !f.markedForDelete).length;
    const totalFiles = activeFilesCount + newFiles.length;

    if (totalFiles > 10) {
        errorSpan.textContent = "You can upload a maximum of 10 files.";
        errorSpan.style.display = "block";
        fileInput.value = "";
        return;
    }

    for (let file of newFiles) {
        const fileName = file.name; // define fileName
        const ext = fileName.split('.').pop().toLowerCase();
        const validNamePattern = /^[a-zA-Z0-9()_.\- ]+$/;

        // Check if file is already uploaded
        if (uploadedFiles.some(f => f.name === fileName && !f.markedForDelete)) {
            errorSpan.innerHTML = '<span style="color: red; margin-top: 5px;"><liferay-ui:message key="this-file-is-already-uploaded" /></span>';
            errorSpan.style.display = "block";
            fileInput.value = "";
            return;
        }

        // Invalid characters in file name
        if (!validNamePattern.test(fileName)) {
            errorSpan.innerHTML = '<span style="color: red; margin-top: 5px;"><liferay-ui:message key="file-name-contains-invalid-characters" /></span>';
            errorSpan.style.display = "block";
            fileInput.value = "";
            return;
        }

        // Multiple extensions check (e.g., dummy.php.pdf)
        const parts = fileName.split('.');
        if (parts.length > 2) {
            errorSpan.innerHTML = '<span style="color: red; margin-top: 5px;"><liferay-ui:message key="multiple-file-extensions-not-allowed" /></span>';
            errorSpan.style.display = "block";
            fileInput.value = "";
            return;
        }

        // File type validation
       
            if (!['jpg', 'jpeg', 'png'].includes(ext)) {
                errorSpan.innerHTML = '<span style="color: red; margin-top: 5px;"><liferay-ui:message key="allowed-only-jpg-jpeg-png-file" /></span>';
                errorSpan.style.display = "block";
                fileInput.value = "";
                uploadedFilesGeoTagPhotos.length = 0; // clear previous files
                return;
            }
        

       

        // File size validation
        if (file.size >= 2 * 1024 * 1024) { // 2 MB
            errorSpan.innerHTML = '<span style="color: red; margin-top: 5px;"><liferay-ui:message key="file-size-limit" /></span>';
            errorSpan.style.display = "block";
            fileInput.value = "";
            return;
        }
    }


    errorSpan.textContent = "";
    errorSpan.style.display = "none";

    newFiles.forEach(file => {
        uploadedFiles.push({
            file: file,
            name: file.name,
            isExisting: false,
            markedForDelete: false
        });
    });

    renderFilePreviews(inputId, previewContainer, previewList, errorSpan, hiddenInput);
     /* fileInput.value = "";  */
}

function removeFile(index, previewContainerId, previewListId, errorSpanId, hiddenInputId, inputId) {
    let uploadedFiles = getUploadedFileArray(inputId);

    if (index < 0 || index >= uploadedFiles.length) return;

    if (uploadedFiles[index].isExisting) {
        uploadedFiles[index].markedForDelete = true;
    } else {
        uploadedFiles.splice(index, 1);
    }

    const previewContainer = document.getElementById(previewContainerId);
    const fileInput = document.getElementById(inputId);
    const label = fileInput.closest('.custom-file').querySelector('.custom-file-label');
    // Reset input and label
    fileInput.value = '';
    label.classList.remove('selected');
    label.innerHTML = 'Choose file';
    // Hide preview
    previewContainer.style.display = 'none';
    previewContainer.querySelector('ul').innerHTML = '';
    
    const previewList = document.getElementById(previewListId);
    const errorSpan = document.getElementById(errorSpanId);
    const hiddenInput = document.getElementById(hiddenInputId);

    renderFilePreviews(inputId, previewContainer, previewList, errorSpan, hiddenInput);
    $form.find("#" + inputId).valid();
    const hasActiveFiles = uploadedFiles.some(f => !f.markedForDelete);
    errorSpan.style.display = hasActiveFiles ? "none" : "block";
    errorSpan.textContent = hasActiveFiles ? "" : "Please upload at least one file.";
}

function renderFilePreviews(inputId, previewContainer, previewList, errorSpan, hiddenInput) {
    let uploadedFiles = getUploadedFileArray(inputId);

    previewList.innerHTML = "";

    uploadedFiles.forEach((fileObj, index) => {
        if (fileObj.markedForDelete) return;

        const li = document.createElement("li");
        li.className = "list-group-item d-flex justify-content-between align-items-center";

        const link = document.createElement("a");
        link.href = fileObj.isExisting ? (fileObj.url || "#") : URL.createObjectURL(fileObj.file);
        link.textContent = fileObj.name;
        link.target = "_blank";
        link.style.cssText = "flex-grow: 1; text-decoration: none; white-space: nowrap; overflow: hidden; max-width: 200px;";
        li.appendChild(link);
        let mode = '${mode}';
        if(mode!="view"){
	        const btn = document.createElement("button");
	        btn.type = "button";
	        btn.className = "btn btn-primary";
	        btn.innerHTML = '<i class="bi bi-x-circle-fill"></i>';
	        btn.onclick = () => removeFile(index, previewContainer.id, previewList.id, errorSpan.id, hiddenInput.id, inputId);
        	btn.style.border = "none";
	        li.appendChild(btn);
        }
        	li.style.backgroundColor = "transparent";
        	li.style.border = "none";
        previewList.appendChild(li);
    });

    previewContainer.style.display = uploadedFiles.some(f => !f.markedForDelete) ? "block" : "none";
    /* hiddenInput.value = uploadedFiles.filter(f => !f.markedForDelete).map(f => f.name).join(','); */
    hiddenInput.value = JSON.stringify(uploadedFiles.filter(f => !f.markedForDelete));
}


function getUploadedFileArray(inputId) {
    const map = {
        'GeoTagPhoto': uploadedFilesGeoTagPhoto
    };
    return map[inputId];
}

function clearInputFile(inputId){
	const fileInputElement = document.getElementById(inputId);
	  if (fileInputElement) {
	        fileInputElement.value = '';
	        fileInputElement.dispatchEvent(new Event('change')); // Notify validators

	        // Revalidate if using jQuery Validate
	        if ($(fileInputElement).closest("form").length) {
	            $(fileInputElement).closest("form").validate().element(fileInputElement);
	        }

	        // Reset file label
	        const label = fileInputElement.nextElementSibling;
	        if (label && label.classList.contains('custom-file-label')) {
	            const chooseText = document.getElementById('chooseFileLabelText')?.textContent?.trim() || 'Choose file';
	            label.textContent = chooseText;
	        }
	    }
}

function searchLocation() {
    var location = document.getElementById('locationSearch').value;

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
                $('#map').removeClass('d-none');
                initializeMap(lat, lon, true);
                updateCoordinates(lat, lon);
                $("#locationNotFound").html('');
            } else {
                $("#locationNotFound").html("Location not found. Please try again.")
            }
        })
        .catch(function(err) {
            console.error('Geocoding error: ', err);
            $("#locationNotFound").html("We are facing a technical issue, please select a location on the map.");
        });
}

function setDivisionDistrictTaluks(sportsFacilityMaster){
	  const selectedDivision = sportsFacilityMaster.division
	    const selectedDistrict = sportsFacilityMaster.district
	    const selectedTaluka = sportsFacilityMaster.taluka
	    
	    console.log("selectedDivision:: "+ selectedDivision+", selectedDistrict:: "+ selectedDistrict +", selectedTaluka");
	    
	    if (selectedDivision) {
	        $('#division').val(selectedDivision);

	        // Fetch and populate districts
	        $.ajax({
	            url: '${getDistricts}',
	            type: 'GET',
	            data: { divisionId: selectedDivision },
	            success: function (districtData) {
	                const $district = $('#district');
	                $district.empty().append('<option value="">Select</option>');

	                districtData = typeof districtData === 'string' ? JSON.parse(districtData) : districtData;

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

	                            $.each(talukaData, function (i, t) {
	                                const selected = t.talukaId == selectedTaluka ? 'selected' : '';
	                                $taluka.append('<option value="' + t.talukaId + '" ' + selected + '>' + t.talukaName + '</option>');
	                            });
	                        }
	                    });
	                }
	            }
	        });
	    }
}

</script>
