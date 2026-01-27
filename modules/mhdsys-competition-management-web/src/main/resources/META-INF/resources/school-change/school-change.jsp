<%@page import="com.mhdsys.competition.management.web.constants.CompetitionManagementWebPortletKeys"%>
<%@ include file="/init.jsp" %>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/jquery.validation/1.19.5/jquery.validate.min.js"></script>
 
<portlet:resourceURL id="<%=CompetitionManagementWebPortletKeys.SAVE_SCHOOL_CHANGE_MVC_RESOURCE_COMMAND %>" var="saveURL" />

<form id="school_change" method="POST" enctype="multipart/form-data" autocomplete="off">
<div class="common-forms-div">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div class="border-0 card shadow">
                    <div class="align-items-center back-btn-cn card-header d-flex justify-content-between" style="">
						<h5 class="mb-0"> <liferay-ui:message key="budget-addition" /></h5>
						<div><a href="/group/guest/competition-dashboard" class="btn btn-primary btn-sm rounded-pill back-btn-cn"><i class="bi bi-arrow-left-circle"></i>  <liferay-ui:message key="back" /></a></div>
					</div>
 
                    <form id="GPFDetails" method="POST" enctype="multipart/form-data">
                        <div class="card-body">
                            <div class="card card-background p-0">
                                <div class="card-header header-card">
                                    <liferay-ui:message key="school-change" />
                                </div>
 
                                <input type="hidden" class="form-control" id="schoolChangeId" name="schoolChangeId" value="${school.schoolChangeId}" />
                                <input type="hidden" class="form-control" id="mode" name="mode" value="${mode}" />
 
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label><liferay-ui:message key="participant-name"/><sup class="text-danger">*</sup></label>
                                                <input type="text" class="form-control" id="name" name="name" value="${school.participantName}" <c:if test="${mode eq 'view'}">disabled</c:if>/>
                                            </div>
                                        </div>
                                        
                                        <div class="col-md-6">
										    <div class="form-group">
										        <label><liferay-ui:message key="standard"/><sup class="text-danger">*</sup></label>
										        <select class="form-control" name="standard" id="standard" <c:if test="${mode eq 'view'}">disabled</c:if>>
										            <option value=""><liferay-ui:message key="select"/></option>
										            <option value="1st"  <c:if test="${school.standard eq '1st'}">selected</c:if>>  <liferay-ui:message key="first"/></option>
										            <option value="2nd"  <c:if test="${school.standard eq '2nd'}">selected</c:if>>  <liferay-ui:message key="second"/></option>
										            <option value="3rd"  <c:if test="${school.standard eq '3rd'}">selected</c:if>>  <liferay-ui:message key="third"/></option>
										            <option value="4th"  <c:if test="${school.standard eq '4th'}">selected</c:if>>  <liferay-ui:message key="fourth"/></option>
										            <option value="5th"  <c:if test="${school.standard eq '5th'}">selected</c:if>>  <liferay-ui:message key="fifth"/></option>
										            <option value="6th"  <c:if test="${school.standard eq '6th'}">selected</c:if>>  <liferay-ui:message key="sixth"/></option>
										            <option value="7th"  <c:if test="${school.standard eq '7th'}">selected</c:if>>  <liferay-ui:message key="seventh"/></option>
										            <option value="8th"  <c:if test="${school.standard eq '8th'}">selected</c:if>>  <liferay-ui:message key="eighth"/></option>
										            <option value="9th"  <c:if test="${school.standard eq '9th'}">selected</c:if>>  <liferay-ui:message key="ninth"/></option>
										            <option value="10th" <c:if test="${school.standard eq '10th'}">selected</c:if>> <liferay-ui:message key="tenth"/></option>
										            <option value="11th" <c:if test="${school.standard eq '11th'}">selected</c:if>> <liferay-ui:message key="eleventh"/></option>
										            <option value="12th" <c:if test="${school.standard eq '12th'}">selected</c:if>> <liferay-ui:message key="twelfth"/></option>
										        </select>
										    </div>
										</div>

                                    </div>
 									
 									<div class="row">
 										<div class="col-md-6">
                                            <div class="form-group">
                                                <label><liferay-ui:message key="from-school"/><sup class="text-danger">*</sup></label>
                                                <select class="form-control" name ="fromSchool" id="fromSchool" <c:if test="${mode eq 'view'}">disabled</c:if>>
                                                    <option value=""><liferay-ui:message key="select"/></option>
                                                    <c:forEach var="sch" items="${schools}">
														<option value="${sch.firstName}" <c:if test="${school.fromSchool == sch.firstName}">selected</c:if>>${sch.firstName}</option>
													</c:forEach>
                                                </select>
                                            </div>
                                        </div>
                                        
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label><liferay-ui:message key="to-school"/><sup class="text-danger">*</sup></label>
                                                <select class="form-control" name ="toSchool" id="toSchool" <c:if test="${mode eq 'view'}">disabled</c:if>>
                                                    <option value=""><liferay-ui:message key="select"/></option>
                                                    <c:forEach var="sch" items="${schools}">
														<option value="${sch.firstName}" <c:if test="${school.toSchool == sch.firstName}">selected</c:if>>${sch.firstName}</option>
													</c:forEach>
                                                </select>
                                            </div>
                                        </div>
 									</div>
 									
                                    <div class="row">
                                        <div class="col-md-6">
										    <div class="form-group">
										        <label><liferay-ui:message key="year"/><sup class="text-danger">*</sup></label>
										        <select class="form-control" name="year" id="year" <c:if test="${mode eq 'view'}">disabled</c:if>>
										            <option value=""><liferay-ui:message key="select"/></option>
										            <option value="2021-22" <c:if test="${school.year eq '2021-22'}">selected</c:if>>2021-22</option>
										            <option value="2022-23" <c:if test="${school.year eq '2022-23'}">selected</c:if>>2022-23</option>
										            <option value="2023-24" <c:if test="${school.year eq '2023-24'}">selected</c:if>>2023-24</option>
										            <option value="2024-25" <c:if test="${school.year eq '2024-25'}">selected</c:if>>2024-25</option>
										            <option value="2025-26" <c:if test="${school.year eq '2025-26'}">selected</c:if>>2025-26</option>
										        </select>
										    </div>
										</div>
										
										
										
									<c:if test="${not empty school.year}">
										<div class="col-md-6">
											<div class="form-group">
												<label><liferay-ui:message key="approval-status" /><sup class="text-danger">*</sup></label>
												<div>
												<label><input type="radio" name="approval" id="approval" value="Approve"
														<c:if test="${school.approval == 'Approve'}">checked</c:if>
														<c:if test="${not empty school.approval}">disabled</c:if>>
														<liferay-ui:message key="approve" />
												</label>
												<label><input type="radio" name="approval" id="approval" value="Reject"
														<c:if test="${school.approval == 'Reject'}">checked</c:if>
														<c:if test="${not empty school.approval}">disabled</c:if>>
														<liferay-ui:message key="reject" />
												</label>
												</div>
											</div>
										</div>
									</c:if>	
									
                                    </div>
                                </div>
                            </div>
                            
                           
                        </div>
                        
				            <div class="card-footer bg-transparent text-right p-4">
					                <button type="button" class="btn btn-primary" onclick="location.href='/group/guest/school-change';">
					                    <liferay-ui:message key="cancel" />
					                </button>	
					                <button class="btn btn-primary" type="button" onclick="location.reload();">
					                    <liferay-ui:message key="reset" />
					                </button>	
					                <button class="btn btn-primary" type="button" onclick="submitDetails(event)">
					                    <liferay-ui:message key="submit"/>
					                </button>
				            </div>
			            
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
</form>

<!-- modal popup for budget -->
<div class="modal fade" id="schoolModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered" role="document">
				<div class="modal-content modal-bg">
					<div class="modal-header justify-content-center align-items-center">
						<h5 class="modal-title" id="exampleModalLongTitle"><liferay-ui:message key="school-change"/></h5>
						<button type="button" class="close d-none" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<div class="row">
							<div class="col-md-12 text-center">
									<div> <p id="success-application"></p> </div>
							</div>
						</div>
					</div>
					<div class="modal-footer d-flex justify-content-end">
       					 <a href="/group/guest/school-change-list" type="button" id="closeModal" class="btn btn-secondary maha-save-btn" data-bs-dismiss="modal" onclick="closeModal()"><liferay-ui:message key="close"/></a>
					</div>
				</div>
			</div>
		</div>
<!-- modal popup for budget -->

<script>

$(document).ready(function () {
	var mode = '${mode}'
	console.log("Mode :::  "+mode);
});

function submitDetails(event){debugger
	console.log('Inside submit ')
	var form = $("#school_change")[0];
	var formData = new FormData(form);
	
	       $.ajax({
	        type: "POST",
	        url: '${saveURL}' ,
	        data:  formData,
	        contentType : false,
			cache : false,
			processData : false,
	        success: function(data){
	        console.log("data: ", typeof data);
		        if (typeof data === 'string') {
		            try {
		                data = JSON.parse(data);
		            } catch (e) {
		                console.error("Failed to parse JSON response: ", e);
		                return;
		            }
		        }
	        	console.log("Parsed data: ", data);
	        	
	        	if (data.school == true) {
	        	    var msg = "<liferay-ui:message key='the-details-are-saved-successfully'/>";
	        	    
	        	    $('#success-application').html(msg);
	        	    $("#schoolModal").modal('show');
	        	}else{
	        		var msg = "<liferay-ui:message key="details-are-failed-to-submit"/>";
	        	    $('#success-application').html(msg);
	        		 $("#schoolModal").modal('show');
	        	}
	        }
      });
};
	
function closeModal() {debugger
    $("#schoolModal").modal('hide');
 	$(".modal-backdrop").remove();
 	$("body").removeClass("modal-open");
}
</script>