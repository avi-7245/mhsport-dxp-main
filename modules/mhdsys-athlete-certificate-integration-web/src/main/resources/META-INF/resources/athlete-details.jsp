<%@page import="com.mhdsys.athlete.certificate.web.constants.MhdsysAthleteCertificateIntegrationWebPortletKeys"%>
<%@ include file="/init.jsp" %>

<portlet:resourceURL id="<%=MhdsysAthleteCertificateIntegrationWebPortletKeys.SAVEATHLETEDETAILSMVCRESOURECCOMMAND %>" var="saveSportsCertificateURL" />

<form id="sportsPersonForm" method="post" enctype="multipart/form-data" autocomplete="off">
<div class="common-forms-div">
    <div class="container">
        <div class="row">
            <div class="col-md-12">

                <div class="card shadow border-0">

                    <div class="align-items-center back-btn-cn card-header d-flex justify-content-between" style="">
                    	<h5 class="mb-0"> <liferay-ui:message key="sports-person-details" /> </h5>
                        <div><a href="/group/guest/application-details-list" class="btn btn-primary btn-sm rounded-pill back-btn-cn"><i class="bi bi-arrow-left-circle"></i>  <liferay-ui:message key="back" /></a></div>
					</div>

                    <div class="card-body">
                        <input type="hidden" name="athleteCertificateId" value="${sportsDTO.athleteCertificateId}" />
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label><liferay-ui:message key="name-of-the-sports-person" /></label>
                                    <c:if test="${mode eq 'view'}">
                                    	<input type="text" class="form-control" name="sportsPersonName" id="sportsPersonName" value="${sportsDTO.sportsPersonName}" readonly />
                                    </c:if>
                                    <c:if test="${mode ne 'view'}">
                                    	<input type="text" class="form-control" name="sportsPersonName" id="sportsPersonName" value="${sportsPersonName}" readonly />
                                    </c:if>
                                </div>
                            </div>

                            <div class="col-md-6">
                                <div class="form-group">
                                    <label><liferay-ui:message key="father-name-spouse-name" /></label>
                                    <c:if test="${mode eq 'view'}">
                                    	<input type="text" class="form-control" name="guardianName" id="guardianName" value="${sportsDTO.guardianName}" readonly />
                                    </c:if>
                                    <c:if test="${mode ne 'view'}">
                                    	<input type="text" class="form-control" name="guardianName" id="guardianName" value="${guardianName}" readonly />
                                    </c:if>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label><liferay-ui:message key="date-of-birth" /></label>
                                    <c:if test="${mode eq 'view'}">
                                    	<input type="text" class="form-control" name="dateOfBirth" id="dateOfBirth" value="${sportsDTO.dateOfBirth}" readonly />
                                    </c:if>
                                    <c:if test="${mode ne 'view'}">
                                    	<input type="text" class="form-control" name="dateOfBirth" id="dateOfBirth" value="${dateOfBirth}" readonly />
                                    </c:if>
                                </div>
                            </div>
                            
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label><liferay-ui:message key="gender" /></label>
                                    <c:if test="${mode eq 'view'}">
                                    	<input type="text" class="form-control" name="gender" id="gender" value="${sportsDTO.gender}" readonly />
                                    </c:if>
                                    <c:if test="${mode ne 'view'}">
                                    	<input type="text" class="form-control" name="gender" id="gender" value="${gender}" readonly />
                                    </c:if>
                                </div>
                            </div>
                            
                        </div>

                        <div class="row">
                        	<div class="col-md-6">
                                <div class="form-group">
                                    <label><liferay-ui:message key="resident-of-district" /><sup class="text-danger">*</sup></label>
                                    <select class="form-control" name="residentDistrict" id="residentDistrict" <c:if test="${mode eq 'view'}">disabled</c:if>>
                                        <option value=""><liferay-ui:message key="select" /></option>
                                        <c:forEach var="district" items="${districts}">
                                            <option value="${district.districtName_en}"
                                                <c:if test="${district.districtName_en == sportsDTO.residentDistrict}"> selected </c:if>>
                                                ${district.districtName_en}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                        	
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label><liferay-ui:message key="representing-district-division-state-country" /><sup class="text-danger">*</sup></label>
                                    <input type="text" class="form-control" name="representing" id="representing" value="${sportsDTO.representing}" <c:if test="${mode eq 'view'}">readonly</c:if>/>
                                </div>
                            </div>
                         </div>
                         
                         <div class="row">   
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label><liferay-ui:message key="age-group" /><sup class="text-danger">*</sup></label>
                                    <select class="form-control" name="ageCode" id="ageCode" <c:if test="${mode eq 'view'}">disabled</c:if>>
                                        <option value=""><liferay-ui:message key="select" /></option>
                                            <option value="Senior" <c:if test="${sportsDTO.ageCode eq 'Senior'}"> selected </c:if>> Senior </option>
                                            <option value="Junior" <c:if test="${sportsDTO.ageCode eq 'Junior'}"> selected </c:if>> Junior </option>
                                            <option value="Sub-Junior" <c:if test="${sportsDTO.ageCode eq 'Sub-Junior'}"> selected </c:if>> Sub-Junior </option>
                                            <option value="School" <c:if test="${sportsDTO.ageCode eq 'School'}"> selected </c:if>> School </option>
                                            <option value="University" <c:if test="${sportsDTO.ageCode eq 'University'}"> selected </c:if>> University </option>
                                            <option value="Para" <c:if test="${sportsDTO.ageCode eq 'Para'}"> selected </c:if>> Para </option>
                                            <option value="Tribal" <c:if test="${sportsDTO.ageCode eq 'Tribal'}"> selected </c:if>> Tribal </option>
                                            <option value="Rural" <c:if test="${sportsDTO.ageCode eq 'Rural'}"> selected </c:if>> Rural </option>
                                            <option value="Women" <c:if test="${sportsDTO.ageCode eq 'Women'}"> selected </c:if>> Women </option>
                                    </select>
                                </div>
                            </div>
                            
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label><liferay-ui:message key="name-of-the-game" /><sup class="text-danger">*</sup></label>
                                    <select class="form-control" name="gameName" id="gameName" <c:if test="${mode eq 'view'}">disabled</c:if>>
                                        <option value=""><liferay-ui:message key="select" /></option>
                                        <c:forEach var="sportsName" items="${sports}">
                                            <option value="${sportsName.name_en}"
                                            	data-sportcode="${sportsName.sportCode}"
                                                <c:if test="${sportsName.name_en == sportsDTO.gameName}"> selected </c:if>>
                                                ${sportsName.name_en}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            
                          </div>
                          
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label><liferay-ui:message key="name-of-the-competition" /><sup class="text-danger">*</sup></label>
                                    <select class="form-control" name="competitionName" id="competitionName" <c:if test="${mode eq 'view'}">disabled</c:if>>
							            <option value=""><liferay-ui:message key="select" /></option>
							            <option value="Olympic"
							                <c:if test="${sportsDTO.competitionName == 'Olympic'}">selected</c:if>>
							                Olympic
							            </option>
							            <option value="Olympic"
							                <c:if test="${sportsDTO.competitionName == '65TH SENIOR GROUP MEN AND WOMEN STATE CHAMPIONSHIP AND SELECTION TRIALS KABADDI TOURNAMENT 2017'}">selected</c:if>>
							                65TH SENIOR GROUP MEN AND WOMEN STATE CHAMPIONSHIP AND SELECTION TRIALS KABADDI TOURNAMENT 2017
							            </option>
							        </select>
                                    
                                </div>
                            </div>

                            <div class="col-md-6">
                                <div class="form-group">
                                    <label><liferay-ui:message key="competition-held-at" /><sup class="text-danger">*</sup></label>
                                    <input type="text" class="form-control" name="competitionVenue" id="competitionVenue" value="${sportsDTO.competitionVenue}" <c:if test="${mode eq 'view'}">readonly</c:if>/>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label><liferay-ui:message key="competition-period-from" /><sup class="text-danger">*</sup></label>
                                    <c:if test="${mode eq 'view'}">
                                    	<input type="text" class="form-control" name="competitionFromDate" id="competitionFromDate" value="${sportsDTO.competitionFromDateStr}" <c:if test="${mode eq 'view'}">readonly</c:if>/>
                                    </c:if>
                                    <c:if test="${mode ne 'view'}">
                                    	<input type="date" class="form-control" name="competitionFromDate" id="competitionFromDate"/>
                                    </c:if>
                                </div>
                            </div>

                            <div class="col-md-6">
                                <div class="form-group">
                                    <label><liferay-ui:message key="competition-period-to" /><sup class="text-danger">*</sup></label>
                                    <c:if test="${mode eq 'view'}">
                                    	<input type="text" class="form-control" name="competitionToDate" id="competitionToDate" value="${sportsDTO.competitionToDateStr}" <c:if test="${mode eq 'view'}">readonly</c:if>/>
                                    </c:if>
                                    <c:if test="${mode ne 'view'}">
                                    	<input type="date" class="form-control" name="competitionToDate" id="competitionToDate"/>
                                    </c:if>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label><liferay-ui:message key="competition-level" /><sup class="text-danger">*</sup></label>
                                    <select class="form-control" name="competitionLevel" id="competitionLevel" <c:if test="${mode eq 'view'}">disabled</c:if>>
                                        <option value=""><liferay-ui:message key="select" /></option>
                                        <c:forEach var="competitionLevel" items="${compLevels}">
                                            <option value="${competitionLevel.name_en}"
                                                <c:if test="${competitionLevel.name_en == sportsDTO.competitionLevel}"> selected </c:if>>
                                                ${competitionLevel.name_en}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>

                            <div class="col-md-6">
							    <div class="form-group">
							        <label><liferay-ui:message key="position-obtained" /><sup class="text-danger">*</sup></label>
							        <select class="form-control" name="positionObtained" id="positionObtained" <c:if test="${mode eq 'view'}">disabled</c:if>>
							            <option value=""><liferay-ui:message key="select" /></option>
							
							            <option value="First - Gold"
							                <c:if test="${sportsDTO.positionObtained == 'First - Gold'}">selected</c:if>>
							                First - Gold
							            </option>
							
							            <option value="Second - Silver"
							                <c:if test="${sportsDTO.positionObtained == 'Second - Silver'}">selected</c:if>>
							                Second - Silver
							            </option>
							
							            <option value="Third - Bronze"
							                <c:if test="${sportsDTO.positionObtained == 'Third - Bronze'}">selected</c:if>>
							                Third - Bronze
							            </option>
							
							            <!-- Participation (initially hidden via JS logic) -->
							            <option value="Participation"
							                <c:if test="${sportsDTO.positionObtained == 'Participation'}">selected</c:if>>
							                Participation
							            </option>
							        </select>
							    </div>
							</div>
                            
                        </div>

                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label><liferay-ui:message key="certificate-no" /><sup class="text-danger">*</sup></label>
                                    <input type="text" class="form-control" name="certificateNo" id="certificateNo"  value="${sportsDTO.certificateNo}" <c:if test="${mode eq 'view'}">readonly</c:if>/>
                                </div>
                            </div>
                            
                            
                            <div class="col-md-6">
								<div class="form-group">
									<label><liferay-ui:message key="certificate" /><sup class="text-danger">*</sup> <em class="bi bi-info-circle-fill" title="<liferay-ui:message key="allowed-only-pdf-file-of-size-2mb" />">  </em> </label>
									
									<div class="custom-file">
										<input type="file" class="custom-file-input" id="certificate" name="certificate"
											onchange="handleFileUpload(event, 'certificate', 'filePreviewContainer', 'filePreviewLink', 'deleteButton','certificateFileEntyId')"
											accept="application/pdf"> <label class="custom-file-label" for="customFile"><liferay-ui:message key="choose-file" /></label>
									</div>

									<!-- Preview and Delete Section -->
									<div class="certificateid d-none mt-3" id="filePreviewContainer">
										<a class="certificateCls text-truncate" id="filePreviewLink" href="" target="_blank" style="flex-grow: 1; text-decoration: none;"></a>
										<button type="button" id="deleteButton" class="dltcertificateBtn close" aria-label="Close"
											onclick="deleteFile('filePreviewContainer', 'certificate')">
											<span aria-hidden="true" class="text-danger"><em
												class="bi bi-x-circle-fill"></em></span>
										</button>
									</div>

								</div>
								</div>
                        </div>

                    </div>

				<c:if test="${mode ne 'view'}">
                    <div class="card-footer text-right">
                    	<button type="reset" class="btn btn-secondary">
                            <liferay-ui:message key="reset" />
                        </button>
                        <button type="button" class="btn btn-primary" onclick="submitSportsDetails(event)">
                            <liferay-ui:message key="submit" />
                        </button>
                    </div>
                </c:if>
                </div>
            </div>
        </div>
    </div>
</div>
</form>

<div class="modal fade" id="sportsModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header justify-content-center"> <h5><liferay-ui:message key="sports-certificate"/></h5> </div>
            <div class="modal-body text-center"> <p id="sports-success-msg"></p> </div>
            <div class="modal-footer">
                <button class="btn btn-secondary" id="closeSportsModal" data-bs-dismiss="modal">
                    <liferay-ui:message key="close"/>
                </button>
            </div>
        </div>
    </div>
</div>

<script>
$(document).ready(function () {

    $('#sportsPersonForm').validate({
        rules: {
            residentDistrict: { required: true },
            representing: { required: true },
            gameName: { required: true },
            competitionName: { required: true },
            competitionVenue: { required: true },
            competitionFromDate: { required: true },
            competitionToDate: { required: true },
            competitionLevel: { required: true },
            positionObtained: { required: true },
            certificateNo: { required: true },
            ageCode: { required: true },
            genderCode: { required: true },
        },
        messages: {
            residentDistrict: "<liferay-ui:message key='please-select-district'/>",
            representing: "<liferay-ui:message key='please-enter-representing'/>",
            gameName: "<liferay-ui:message key='please-select-game'/>",
            competitionName: "<liferay-ui:message key='please-select-competition-name'/>",
            competitionVenue: "<liferay-ui:message key='please-enter-competition-venue'/>",
            competitionFromDate: "<liferay-ui:message key='please-select-from-date'/>",
            competitionToDate: "<liferay-ui:message key='please-select-to-date'/>",
            competitionLevel: "<liferay-ui:message key='please-select-competition-level'/>",
            positionObtained: "<liferay-ui:message key='please-select-position'/>",
            certificateNo: "<liferay-ui:message key='please-enter-certificate-no'/>",
            ageCode: "<liferay-ui:message key='please-select-age-code'/>",
            genderCode: "<liferay-ui:message key='please-select-gender-code'/>",
        }
    });
    
});

function submitSportsDetails(event) {

    if (event) event.preventDefault();

    if (!$('#sportsPersonForm').valid()) {
        return;
    }

    var form = $("#sportsPersonForm")[0];
    var formData = new FormData(form);

    $.ajax({
        type: "POST",
        url: '${saveSportsCertificateURL}',
        data: formData,
        contentType: false,
        processData: false,
        success: function (data) {

            if (typeof data === 'string') {
                data = JSON.parse(data);
            }

            if (data.success) {
                $('#sports-success-msg').html(
                    "<liferay-ui:message key='sports-certificate-saved-successfully'/>"
                );
            } else {
                $('#sports-success-msg').html(
                    "<liferay-ui:message key='sports-certificate-save-failed'/>"
                );
            }

            $("#sportsModal").modal('show');
        }
    });
}

function toggleParticipationOption() {
    var competitionLevel = document.getElementById("competitionLevel").value;
    var positionSelect = document.getElementById("positionObtained");

    var participationOption = Array.from(positionSelect.options)
        .find(opt => opt.value === "Participation");

    if (!participationOption) return;

    if (competitionLevel === "National") {
        participationOption.style.display = "block";
    } else {
        if (positionSelect.value === "Participation") {
            positionSelect.value = "";
        }
        participationOption.style.display = "none";
    }
}

document.addEventListener("DOMContentLoaded", function () {
    toggleParticipationOption();
    document.getElementById("competitionLevel")
        .addEventListener("change", toggleParticipationOption);
});

document.getElementById("closeSportsModal").addEventListener("click", function () {
	/* window.open = "https://pramaan.0-4.nl/api/saml/login"; */
	window.open("https://kridaepramaan.org/api/saml/login", "_blank");
    /* window.location.href = "https://pramaan.0-4.nl/static/athlete-login.html"; */
/*     window.location.href = "/group/guest/application-details-list"; */
});


function handleFileUpload(event,id,filePreviewContainer,filePreviewLink,deleteBtn,hiddenFileId) {debugger
    const fileInput = event.target;
    const file = fileInput.files[0]; 
    const previewContainer = document.getElementById(filePreviewContainer);
    const previewLink = document.getElementById(filePreviewLink);
    const deleteButton = document.getElementById(deleteBtn);
    if (file && $('#'+id).val() != '' ) {   
    	const fileName = file.name;

        previewContainer.classList.remove('d-none');
        previewContainer.classList.add('d-flex');

        previewLink.textContent = fileName;
        previewLink.href = URL.createObjectURL(file); 
        previewLink.target = "_blank";

        deleteButton.dataset.filename = fileName; 
        
        $('#'+hiddenFileId).val('');
    }
}

function deleteFile(filePreviewContainer,id) {
    const previewContainer = document.getElementById(filePreviewContainer);
    const fileInput = document.getElementById(id);

    fileInput.value = "";
	$(".custom-file-input").siblings(".custom-file-label").addClass("selected").html("<liferay-ui:message key="choose-file" />"); 
    previewContainer.classList.add('d-none');
    previewContainer.classList.remove('d-flex');
}

$('#gameName').on('change', function () {

    const selectedOption = $(this).find(':selected');
    const sportName = selectedOption.val();   

    const $competition = $('#competitionName');

    $competition.val('');

    if (sportName && sportName.toLowerCase() === 'kabaddi') {
        $competition.find('option:eq(2)').prop('selected', true);
    }
});
</script>