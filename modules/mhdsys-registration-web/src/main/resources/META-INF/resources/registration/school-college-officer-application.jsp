<%@page import="com.mhdsys.registartion.web.constants.RegistrationWebPortletKeys"%>
<%@page import="com.liferay.portal.kernel.language.LanguageUtil"%>
<%@page import="com.liferay.portal.kernel.captcha.CaptchaException"%>
<%@ taglib uri="http://liferay.com/tld/captcha" prefix="liferay-captcha" %>
<%@ taglib uri="http://liferay.com/tld/ui" prefix="liferay-ui" %>
<%@ include file="/init.jsp" %>

<portlet:resourceURL id="<%=RegistrationWebPortletKeys.SMART_SEARCH_SCHOOL_MVC_RESOURCE_COMMAND%>" var="searchSchoolURL" />
<portlet:resourceURL id="<%=RegistrationWebPortletKeys.EMAIL_EXIST_URL%>" var="emailExist" />
<portlet:resourceURL id="/send_otp" var="sendOtpURL" />
<portlet:resourceURL id="/verify_otp" var="verifyOtpURL" />

<input type="hidden" id="regEmailExist" value="<liferay-ui:message key="email-id-already-exist"/>">

<div class="common-forms-div mt-6">
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<div class="border-0 card shadow">
					<div class="align-items-center back-btn-cn card-header d-flex justify-content-between">
						<h5 class="text-white"><liferay-ui:message key="sports-person-coach-registration"/></h5>						
						<h5><div>
							<a class="btn btn-primary btn-sm rounded-pill back-btn-cn" href="/registration" style="background-color: #861f41; border-color: #fff;">
							 <i class="bi bi-arrow-left-circle"></i> <liferay-ui:message key="back" />
							</a>
							</div>
						</h5>						
					</div>
					
				<form id="school-college-officer-form" enctype="multipart/form-data" autocomplete="off"> 
					<div class="card-body">
						<div class="card card-background p-0">
							<div class="card-header header-card">
								<liferay-ui:message key="sports-person-coach-registration"/>
							</div>
							<div class="card-body">
								<!-- User Role Selection - Always shown at start -->
								<div class="row" id="roleSelectionSection">
									<div class="col-md-6">
										<div class="form-group">
											<label><liferay-ui:message key="current-user-role"/><sup class="text-danger">*</sup></label>
											<select class="form-control" name="currentDesignation" id="currentDesignation" onchange="handleRoleChange()">
												<option value=""><liferay-ui:message key="select"/></option>
												<c:forEach var="designation" items="${designations}">
													<option value="${designation.officerDesignationId}">${designation.name}</option>
												</c:forEach>
											</select>
										</div>
									</div>
									
									<div class="col-md-6" id="penIdSection" style="display: none;">
										<div class="form-group">
											<label><liferay-ui:message key="pen-id"/></label>
											<input type="text" class="form-control" name="penId" id="penId" value=""/>
										</div>
									</div>
									
									<!-- Type Field - Only for Coach -->
									<div class="col-md-6" id="typeSection" style="display: none;">
										<div class="form-group">
											<label><liferay-ui:message key="type"/><sup class="text-danger">*</sup></label>
											<select class="form-control" name="type" id="type">
												<option value=""><liferay-ui:message key="select"/></option>
												<option value="Private"><liferay-ui:message key="private"/></option>
												<option value="Government"><liferay-ui:message key="government"/></option>
											</select>
										</div>
									</div>
									
								</div>
								
								<!-- Form Fields Section - Hidden initially -->
								<div id="formFieldsSection" style="display: none;">

									<div class="row">
										<div class="col-md-6">
											<div class="form-group">
												<label><liferay-ui:message key="first-name"/><sup class="text-danger">*</sup></label>
												<input type="text" class="form-control" name="firstName" value=""/>
											</div>
										</div>
										
										<div class="col-md-6">
											<div class="form-group">
												<label><liferay-ui:message key="last-name"/><sup class="text-danger">*</sup></label>
												<input type="text" class="form-control" name="lastName" value=""/>
											</div>
										</div>
									</div>
									
									<div class="row">
										<div class="col-md-6">
											<div class="form-group">
												<label><liferay-ui:message key="mothers-name"/><sup class="text-danger">*</sup></label>
												<input type="text" class="form-control" name="mothersName" value=""/>
											</div>
										</div>
										
										<div class="col-md-6">
											<div class="form-group">
												<label><liferay-ui:message key="father-name-spouse-name"/><sup class="text-danger">*</sup></label>
												<input type="text" class="form-control" name="fathersName" value=""/>
											</div>
										</div>
									</div>
									
									<div class="row">
										<div class="col-md-6">
											<div class="form-group">
											    <label for="genderYes">  <liferay-ui:message key="gender" /> <sup class="text-danger">*</sup> </label>
											    <div class="d-flex mt-2">
												<div class="radio-text">
											        <input type="radio" class="radio-btn" id="genderYes" name="gender" value="1" />
											        <label for="genderYes"><liferay-ui:message key="male"/></label>
											    </div>
											    <div>
											        <input type="radio" class="radio-btn" id="genderNo" name="gender" value="2" />
											        <label for="genderNo"><liferay-ui:message key="female"/></label>
											    </div>
											    </div>
											</div>
										</div>
										
										<div class="col-md-6">
											<div class="form-group">
												<label><liferay-ui:message key="school-or-college-or-company-institute-name"/><sup class="text-danger">*</sup></label>
												<input type="text" class="form-control" name="schoolOrCollegeName" oninput="searchSchool(this.value)" id="schoolOrCollegeName" value=""/>
												<div id="schoolSuggestions" class=""></div>
											</div>
										</div>
									</div>
									
									<div class="row">
										<div class="col-md-6">
											<div class="form-group">
												<label><liferay-ui:message key="aadhar-number"/><sup class="text-danger">*</sup></label>
												<input type="text" class="form-control" id="aadharNumber" name="aadharNumber" value="" />
											</div>
										</div>
										
										<div class="col-md-6">
											<div class="form-group">
												<label><liferay-ui:message key="email-id"/><sup class="text-danger">*</sup></label>
												<input type="text" class="form-control" id="email" name="email" />
											</div>
										</div>
									</div>
									
									<div class="row">
									    <div class="col-md-6">
									        <div class="form-group">
									            <label>
									                <liferay-ui:message key="mobile-number"/>
									                <sup class="text-danger">*</sup>
									            </label>
									            <input type="text" class="form-control" id="mobileNumber" name="mobileNumber"/>
									
									            <%-- <button type="button" class="btn btn-sm btn-secondary mt-2" id="sendOtpBtn" onclick="sendOtp()">
									                <liferay-ui:message key="send-otp"/>
									            </button>
									
									            <small id="otpStatusMsg" class="d-none"></small> --%>
									            
									            <button type="button" class="btn btn-sm btn-secondary mt-2" id="sendOtpBtn" onclick="handleOtpSend()">
												    <liferay-ui:message key="send-otp"/>
												</button>
												
												<small id="otpStatusMsg" class="d-none"></small>
									        </div>
									    </div>
									
									    <div class="col-md-6 d-none" id="otpSection">
									        <div class="form-group">
									            <label><liferay-ui:message key="enter-otp"/></label>
									            <input type="text" class="form-control" id="otpInput"/>
									            <button type="button" class="btn btn-sm btn-success mt-2" id="verifyOtpBtn" onclick="verifyOtp()">
									                <liferay-ui:message key="verify-otp"/>
									            </button>
									            <small id="otpError" class="text-danger"></small>
									            
									        </div>
									    </div>
									</div>
									
									<div class="row">
										<div class="col-md-6">
											<div class="form-group">
												<label><liferay-ui:message key="aadhar-card-pdf-only-2-mb"/><sup class="text-danger">*</sup></label>
												<div class="custom-file">
													<input type="file" class="custom-file-input" id="aadharCardReciept" name="aadharCardReciept" onchange="handleFileUpload(event)" >
													<label class="custom-file-label" for="customFile"><liferay-ui:message key="choose-file"/></label>
												</div>
												
												<!-- Preview and Delete Section -->
												<div class="aadharCardid d-none mt-3" id="filePreviewContainer">
													<a class="aadharCardCls" id="filePreviewLink" href="" target="_blank" style="flex-grow: 1; text-decoration: none;"></a>
													<button type="button" id="deleteButton" class="dltFeesReceiptBtn close" aria-label="Close" onclick="deleteFile()">
														<span aria-hidden="true" class="text-danger"><em class="bi bi-x-circle-fill"></em></span>
													</button>
												</div>
											</div>
										</div>
									
										<div class="col-md-6">
											<div class="form-group">
												<label><liferay-ui:message key="text-verification-code"/><sup class="text-danger">*</sup></label>
												<div class="d-flex align-items-center mb-2">
													<canvas id="captchaCanvas" class="captcha-image me-2"></canvas>
													<button type="button" id="refreshCaptcha" class="btn btn-refresh btn-sm" aria-label="Refresh Captcha">
														<i class="bi bi-repeat"></i>
													</button>
													<input type="text" class="form-control mb-1" id="captchaInput" name="captchaInput" placeholder="Enter Captcha">
													<div id="captchaError" class="error text-danger small"></div>
												</div>
											</div>
										</div>
									</div>
									
								</div> 
							</div>
						</div>
					</div>
					
					<!-- Form Footer with Submit Button - Hidden initially -->
					<div class="card-footer bg-transparent text-right p-4" id="formFooter" style="display: none;">
						<a href="/registration" type="button" class="btn btn-primary"><liferay-ui:message key="cancel" /></a>
						<button type="button" class="btn btn-primary" onclick="saveSchoolCollegeOfficerForm(event)"><liferay-ui:message key="save" /></button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>

<!-- modal popup for add competition -->
<div class="modal fade" id="schoolCollegeOfficerModel" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content modal-bg">
			<div class="modal-header justify-content-center align-items-center">
				<h5 class="modal-title" id="exampleModalLongTitle"></h5>
				<button type="button" class="close d-none" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="row">
					<div class="col-md-12 text-center">
						<div>
							<liferay-ui:message key="your-registration-has-been-completed-successfully"/>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer d-flex justify-content-end">
				<a href="javascript:void(0)" type="button" id="closeModal" class="btn btn-secondary maha-save-btn" data-bs-dismiss="modal" onclick="closeModal()"><liferay-ui:message key="close"/></a>
			</div>
		</div>
	</div>
</div>

<style>
.custom-file-label::after {
	color:#fff!important;
}
#aadharCardReciept-error{
	margin-top:10px;
}
</style>

<script>
// Global variables
let currentCaptcha = "";

// Handle role selection change
function handleRoleChange() {
    const form = document.getElementById('school-college-officer-form');
    const roleSelect = document.getElementById('currentDesignation');
    const selectedRole = roleSelect.value;
    const formFieldsSection = document.getElementById('formFieldsSection');
    const formFooter = document.getElementById('formFooter');
    const penIdSection = document.getElementById('penIdSection');
    const typeSection = document.getElementById('typeSection');
    const modalTitle = document.getElementById('exampleModalLongTitle');

    // Preserve selected role
    const preservedRole = selectedRole;

    // Hide conditional sections first
    penIdSection.style.display = 'none';
    typeSection.style.display = 'none';

    // If no role selected → hide form
    if (!preservedRole) {
        formFieldsSection.style.display = 'none';
        formFooter.style.display = 'none';
        return;
    }

    // Show form
    formFieldsSection.style.display = 'block';
    formFooter.style.display = 'block';

    // Role-based logic
    if (preservedRole === '1' || preservedRole === '2' || preservedRole === '3') { // Athlete
        modalTitle.innerHTML = '<liferay-ui:message key="sport-person-registration"/>';
        penIdSection.style.display = 'block';
        typeSection.style.display = 'none';
        
        // Clear type field
        document.getElementById('type').value = '';
    }
    else if (preservedRole === '4') { // Coach
        modalTitle.innerHTML = '<liferay-ui:message key="sport-coach-registration"/>';
        penIdSection.style.display = 'none';
        typeSection.style.display = 'block';
        
        // Clear penId field
        document.getElementById('penId').value = '';
    }
}

function resetForm() {
    document.getElementById('school-college-officer-form').reset();
    document.getElementById('currentDesignation').value = '';
    document.getElementById('formFieldsSection').style.display = 'none';
    document.getElementById('formFooter').style.display = 'none';
    document.getElementById('penIdSection').style.display = 'none';
    document.getElementById('typeSection').style.display = 'none';
    
    // Clear file preview
    const previewContainer = document.getElementById('filePreviewContainer');
    if (previewContainer) {
        previewContainer.classList.add('d-none');
        previewContainer.classList.remove('d-flex');
    }
    
    // Clear validation errors
    if ($.fn.validate) {
        const validator = $('#school-college-officer-form').validate();
        if (validator) {
            validator.resetForm();
        }
    }
}

function findProperty(obj, key) {
    if (typeof obj === "object") {
        if (key in obj) {
            return true;
        } else {
            return false;
        }
    }
    return false;
}

$(document).ready(function () {
    addValidationMethods();
    
    // Initialize CAPTCHA
    currentCaptcha = generateCaptcha();
    drawCaptcha(currentCaptcha);
    
    // Add validation rules for Pen ID (only for Athlete)
    $.validator.addMethod("validPenId", function(value, element) {
        const currentRole = $('#currentDesignation').val();
        // Only validate if role is Athlete (assuming '1' is Athlete)
        if (currentRole === '1') {
            return value.trim() !== '';
        }
        return true; // Skip validation for non-Athlete roles
    }, '<liferay-ui:message key="please-enter-pen-id"/>');
    
    $('#school-college-officer-form').validate({
        onkeyup: function (element) {
            $(element).valid();
        },
        onchange: function (element) {
            $(element).valid();
        },
        rules: {
            firstName: {
                required: true,
                pattern: /^[A-Za-z]+([A-Za-z ]*[A-Za-z])?$/,
                noEdgeSpaces:true
            },
            lastName: {
                required: true,
                pattern: /^[A-Za-z]+([A-Za-z ]*[A-Za-z])?$/,
                noEdgeSpaces:true,
            },
            mothersName: {
                required: true,
                pattern: /^[A-Za-z]+([A-Za-z ]*[A-Za-z])?$/,
                noEdgeSpaces:true,
            },
            fathersName: {
                required: true,
                pattern: /^[A-Za-z]+([A-Za-z ]*[A-Za-z])?$/,
                noEdgeSpaces:true,
            },
            currentDesignation: {
                required: true,
            },
            gender: {
                required: true,
            },
            type: {
                required: function(element) {
                    // Only require type field if role is Coach (assuming '2' is Coach)
                    return $("#currentDesignation").val() === "2";
                }
            },
            schoolOrCollegeName: {
                required: true,
                maxlength: 100
            },
            aadharNumber: {
                required: true,
                digits: true,
                minlength: 12,
                maxlength: 12,
            },
            email: {
                required: true,
                noEdgeSpaces:true,
                email: true,
                existingEmail:true
            },
            mobileNumber: {
                required: true,
                digits: true,
                minlength: 10,
                maxlength: 10,
            },
            aadharCardReciept: {
                required: true,
                validPdfFile:true
            },
            captchaInput: {
                required: true,
                validateCaptcha: true
            }
        },
        messages: {
            firstName: {
                required: "<liferay-ui:message key='please-enter-first-name' />",
                pattern: "<liferay-ui:message key='only-alphabates-are-allowed' />"
            },
            lastName: {
                required: "<liferay-ui:message key='please-enter-last-name' />",
                pattern: "<liferay-ui:message key='only-alphabates-are-allowed' />"
            },
            mothersName: {
                required: "<liferay-ui:message key='please-enter-mothers-name' />",
                pattern: "<liferay-ui:message key='only-alphabates-are-allowed' />"
            },
            fathersName: {
                required: "<liferay-ui:message key='please-enter-fathers-name' />",
                pattern: "<liferay-ui:message key='only-alphabates-are-allowed' />"
            },
            currentDesignation: {
                required: "<liferay-ui:message key='please-select-designation' />",
            },
            gender: {
                required: "<liferay-ui:message key='please-select-gender' />",
            },
            type: {
                required: "<liferay-ui:message key='please-select-type' />",
            },
            schoolOrCollegeName: {
                required: "<liferay-ui:message key='please-enter-school-or-college-name' />",
                maxlength: "<liferay-ui:message key='maximum-length-is-100-characters' />"
            },
            aadharNumber: {
                required: "<liferay-ui:message key='please-enter-aadhar-number' />",
                digits: "<liferay-ui:message key='please-enter-only-numeric-values' />",
                minlength: "<liferay-ui:message key='aadhar-number-must-be-12-digits' />",
                maxlength: "<liferay-ui:message key='aadhar-number-must-be-12-digits' />",
            },
            email: {
                required: "<liferay-ui:message key='please-enter-email-id' />",
                email: "<liferay-ui:message key='please-enter-valid-email' />",
            },
            mobileNumber: {
                required: "<liferay-ui:message key='please-enter-mobile-number' />",
                digits: "<liferay-ui:message key='please-enter-only-numeric-values' />",
                minlength: "<liferay-ui:message key='mobile-number-must-be-10-digits' />",
                maxlength: "<liferay-ui:message key='mobile-number-must-be-10-digits' />",
            },
            aadharCardReciept: {
                accept: "<liferay-ui:message key='please-choose-valid-file'/>",
                filesize: "<liferay-ui:message key='maximum-file-size-is-2-mb'/>",
                required: "<liferay-ui:message key='please-choose-a-file' />"
            },
            captchaInput: {
                required: "<liferay-ui:message key='please-enter-captcha' />",
                validateCaptcha: "<liferay-ui:message key='captcha-incorrect' />"
            }
        },
    });
    
  /*   $.validator.addMethod("validPdfFile", function(value, element) {
        if (this.optional(element)) return true;

        const file = element.files[0];
        if (!file) return false;

        const fileName = file.name;
        const parts = fileName.split('.');
        const ext = parts.pop().toLowerCase();

        const validNamePattern = /^[a-zA-Z0-9()_.\- ]+$/;
        if (!validNamePattern.test(fileName)) {
            $.validator.messages.validPdfFile = '<liferay-ui:message key="file-name-contains-invalid-characters" />';
            return false;
        }

        if (parts.length > 1) {
            $.validator.messages.validPdfFile = '<liferay-ui:message key="multiple-file-extensions-not-allowed" />';
            return false;
        }

        if (ext !== "pdf") {
            $.validator.messages.validPdfFile = '<liferay-ui:message key="only-pdf-files-are-allowed" />';
            return false;
        }

        if (file.size >= 2 * 1024 * 1024) {
            $.validator.messages.validPdfFile = '<liferay-ui:message key="file-size-limit" />';
            return false;
        }

        return true;
    }); */
    
    $.validator.addMethod("validPdfFile", function (value, element) {
        if (this.optional(element)) return true;

        const file = element.files[0];
        if (!file) return false;

        const fileName = file.name;
        const ext = fileName.split('.').pop().toLowerCase();

        const unicodeSafePattern = /^[^<>:"/\\|?*\x00-\x1F]+$/;

        if (!unicodeSafePattern.test(fileName)) {
            $.validator.messages.validPdfFile =
                '<liferay-ui:message key="file-name-contains-invalid-characters" />';
            return false;
        }

        if (ext !== "pdf") {
            $.validator.messages.validPdfFile =
                '<liferay-ui:message key="only-pdf-files-are-allowed" />';
            return false;
        }

        if (file.size > 2 * 1024 * 1024) {
            $.validator.messages.validPdfFile =
                '<liferay-ui:message key="file-size-limit" />';
            return false;
        }

        return true;
    });
    
    
    
    // Add CAPTCHA validation method
    $.validator.addMethod("validateCaptcha", function(value, element) {
        return value === currentCaptcha;
    });
    
    // Refresh CAPTCHA button
    $("#refreshCaptcha").on("click", function () {
        currentCaptcha = generateCaptcha();
        drawCaptcha(currentCaptcha);
        $("#captchaInput").val("");
        $("#captchaError").text("");
        $("#captchaInput-error").text("");
    });
});

function addValidationMethods(){
    $.validator.addMethod("filesize", function(value, element, param) {
        return this.optional(element) || (element.files[0].size <= param);
    });
    $.validator.addMethod("filexssFilter", function(value, element, param) {
        if (element.files.length === 0) {
            console.log("No file selected, skipping type validation.");
            return true;
        }
        let validFileRegex = new RegExp(/^[a-zA-Z0-9 ._-]+$/); 
        if(!validFileRegex.test(element.files[0].name)){
            $.validator.messages.filexssFilter = "Special characters not allowed. Please select a different file.";
            return false;
        }
        return true;
    });
    if(!findProperty($.validator.methods, 'existingEmail')){
        $.validator.addMethod("existingEmail", function(value, element) {
            var email = $("#email").val();
            return this.optional(element) || checkEmailExist(email);
        }, $('#regEmailExist').val());
    } 
    if (!findProperty($.validator.methods, 'noEdgeSpaces')) {
        $.validator.addMethod("noEdgeSpaces", function(value) {
            return value === value.trim();
        }, '<liferay-ui:message key="no-leading-and-trailing-space-allowed"/>');
    }
}

function saveSchoolCollegeOfficerForm(event){
    
  if (!otpVerified) {
    $('#otpStatusMsg').removeClass('d-none text-success').addClass('text-danger').text('<liferay-ui:message key="otp-verify-before-submit" />');
    return false;
}
    
    var captchaInput = document.getElementById('captchaInput').value;
    if (captchaInput !== currentCaptcha) {
        $("#captchaError").text("<liferay-ui:message key='captcha-incorrect' />");
        return false;
    }
    
    if (!$('#school-college-officer-form').valid()) {
        return false;
    }
    
    var form = $("#school-college-officer-form")[0];
    var formData = new FormData(form);
    
    // Note: Aadhar number is sent as plain text (no encryption)
    // You can handle encryption in backend if needed
    
    var fileInput = document.getElementById("aadharCardReciept");
    if (fileInput && fileInput.files && fileInput.files.length > 0) {
        var aadharCardReciept = document.getElementById("aadharCardReciept").files[0];
        if (aadharCardReciept) {
            formData.append('aadharCardReciept', aadharCardReciept);
        }
    }
    
    if (event) {
        event.preventDefault();
    }
    
    // Show loading state
    $('.btn-primary[onclick*="saveSchoolCollegeOfficerForm"]').prop('disabled', true).html('<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> Saving...');
    
    $.ajax({
        type: "POST",
        url: '${schoolCollegeOfficerFormURL}',
        data: formData,
        enctype: 'multipart/form-data',
        contentType: false,
        cache: false,
        processData: false,
        success: function(data){
            console.log("data: ", typeof data);
            if (typeof data === 'string') {
                try {
                    data = JSON.parse(data);
                } catch (e) {
                    console.error("Failed to parse JSON response: ", e);
                    // Reset button state
                    $('.btn-primary[onclick*="saveSchoolCollegeOfficerForm"]').prop('disabled', false).html('<liferay-ui:message key="save" />');
                    return;
                }
            }
            console.log("Parsed data: ", data);
            if(data.schoolCollegeOfficerReg == true){
                $("#schoolCollegeOfficerModel").modal('show');  
            }else{
                $("#schoolCollegeOfficerModel").modal('show'); 
            }
            // Reset button state
            $('.btn-primary[onclick*="saveSchoolCollegeOfficerForm"]').prop('disabled', false).html('<liferay-ui:message key="save" />');
        },
        error: function(xhr, status, error) {
            console.error("Error submitting form:", error);
            alert("Error submitting form. Please try again.");
            // Reset button state
            $('.btn-primary[onclick*="saveSchoolCollegeOfficerForm"]').prop('disabled', false).html('<liferay-ui:message key="save" />');
        }
    });
}

function closeModal() {
    $("#schoolCollegeOfficerModel").modal('hide');
    $(".modal-backdrop").remove();
    $("body").removeClass("modal-open");
    window.location.href = "/login";
}

function handleFileUpload(event) {
    const fileInput = event.target;
    const file = fileInput.files[0];
    const previewContainer = document.getElementById('filePreviewContainer');
    const previewLink = document.getElementById('filePreviewLink');
    const deleteButton = document.getElementById('deleteButton');

    if (file && $('#aadharCardReciept').val() != '' && $('#aadharCardReciept').valid()) {   
        const fileName = file.name;

        previewContainer.classList.remove('d-none');
        previewContainer.classList.add('d-flex');

        previewLink.textContent = fileName;
        previewLink.href = URL.createObjectURL(file);
        previewLink.target = "_blank";

        deleteButton.dataset.filename = fileName;
    }
}

function deleteFile() {
    const previewContainer = document.getElementById('filePreviewContainer');
    const fileInput = document.getElementById('aadharCardReciept');

    fileInput.value = "";
    $(".custom-file-input").siblings(".custom-file-label").addClass("selected").html("choose-file"); 
    
    previewContainer.classList.add('d-none');
    previewContainer.classList.remove('d-flex');
}

function checkEmailExist(email){
    var flag = false;
    $.ajax({
        url: '${emailExist}',
        type: 'GET',
        data: {
            email: email
        },
        async: false, 
        success: function (response) {
            var data = JSON.parse(response);
            console.log('emailExist:',data.emailExist);
            if(data.emailExist == true){
                flag = false;
            }
            if(data.emailExist == false){
                flag = true;
            }
        }
    });
    return flag;
}

//Generate CAPTCHA
function generateCaptcha() {
    const characters = "0123456789";
    let captcha = "";
    for (let i = 0; i < 4; i++) {
        captcha += characters.charAt(Math.floor(Math.random() * characters.length));
    }
    return captcha;
}

// Draw CAPTCHA on canvas
function drawCaptcha(captchaText) {
    const canvas = document.getElementById('captchaCanvas');
    const ctx = canvas.getContext('2d');
    canvas.width = 200;
    canvas.height = 50;

    ctx.clearRect(0, 0, canvas.width, canvas.height);
    ctx.fillStyle = "#f0f0f0";
    ctx.fillRect(0, 0, canvas.width, canvas.height);

    for (let i = 0; i < 50; i++) {
        ctx.fillStyle = `rgb(${Math.random() * 255}, ${Math.random() * 255}, ${Math.random() * 255})`;
        ctx.fillRect(Math.random() * canvas.width, Math.random() * canvas.height, 2, 2);
    }

    ctx.font = "bold 30px Arial";
    ctx.fillStyle = "#333";
    ctx.textAlign = "center";
    ctx.fillText(captchaText, canvas.width / 2, canvas.height / 2 + 10);
}

function searchSchool(query) {
    if (query.length < 1) {
        $('#schoolSuggestions').hide();
        return;
    }
    var form = $("#school-college-officer-form")[0];
    var formData = new FormData(form);
    $.ajax({
        type: "POST",
        data: formData,
        contentType: false,
        cache: false,
        processData: false,
        url: '${searchSchoolURL}',
        success: function (response) {
            console.log('response: ', response)
            response = JSON.parse(response);
            if (response && response.length > 0) {
                let fragment = document.createDocumentFragment(); 
                response.forEach(function (school) {
                    console.log("school, ", school.schoolName)
                    var div = document.createElement('div');
                    div.textContent = school.schoolName;  
                    div.onclick = function() {
                        selectSchool(school.schoolName); 
                    };
                    fragment.appendChild(div);
                });
                $('#schoolSuggestions').html('').append(fragment).show();

                var inputPos = $('#schoolOrCollegeName').offset(); 
                $('#schoolSuggestions').css({
                    top: inputPos.top + $('#schoolOrCollegeName').outerHeight(), 
                    left: inputPos.left, 
                    width: $('#schoolOrCollegeName').outerWidth() 
                });
            } else {
                $('#schoolSuggestions').html('<div>No results found</div>').show();
            }
        },
        error: function (xhr, status, error) {
            console.error("Error:", error);
        }
    });
}

function selectSchool(name) {
    $('#schoolOrCollegeName').val(name);
    $('#schoolSuggestions').hide();
}


let otpSent = false;

function handleOtpSend() {

    const mobile = $('#mobileNumber').val();

    if (mobile.length !== 10) {
        $('#otpStatusMsg').removeClass('d-none text-success').addClass('text-danger').text('<liferay-ui:message key="otp-enter-valid-mobile" />');
        return;
    }

    $.ajax({
        url: '${sendOtpURL}',
        type: 'POST',
        data: { mobile: mobile },
        success: function (res) {

            res = typeof res === 'string' ? JSON.parse(res) : res;

            if (res.sent) {

                const maskedMobile =
                    mobile.replace(/(\d{2})\d{6}(\d{2})/, "$1******$2");

                $('#mobileNumber').prop('readonly', true);
                $('#otpSection').removeClass('d-none');

                $('#otpStatusMsg').removeClass('d-none text-danger').addClass('text-success').text(otpSent
                        ? '<liferay-ui:message key="otp-resent-successfully"/>' : Liferay.Util.sub('<liferay-ui:message key="otp-sent-to-mobile" />', maskedMobile)
                    );

                otpSent = true;
                otpVerified = false;

                $('#sendOtpBtn').html('<liferay-ui:message key="resend-otp"/>');

               /*  setTimeout(() => {
                    $('#sendOtpBtn').prop('disabled', false);
                }, 30000); */

            } else {
                $('#otpStatusMsg').removeClass('text-success').addClass('text-danger').text('<liferay-ui:message key="otp-send-failed" />');
                $('#sendOtpBtn').prop('disabled', false);
            }
        },
        error: function () {
            $('#otpStatusMsg').removeClass('text-success').addClass('text-danger').text('<liferay-ui:message key="otp-send-failed" />');
            $('#sendOtpBtn').prop('disabled', false);
        }
    });
}

function verifyOtp() {

    const otp = $('#otpInput').val();

    $.ajax({
        url: '${verifyOtpURL}',
        type: 'POST',
        data: { otp: otp },
        success: function (res) {

            res = JSON.parse(res);

            if (res.valid) {
                otpVerified = true;

                $('#otpInput').prop('readonly', true);
                $('#verifyOtpBtn').prop('disabled', true);
                $('#sendOtpBtn').prop('disabled', true); 

                $('#otpStatusMsg').removeClass('text-danger').addClass('text-success').text('<liferay-ui:message key="otp-mobile-verified" />');
            } else {
                otpVerified = false;
                $('#otpStatusMsg').removeClass('text-success').addClass('text-danger').text('<liferay-ui:message key="otp-verification-failed" />');
            }
        }
    });
}
</script>