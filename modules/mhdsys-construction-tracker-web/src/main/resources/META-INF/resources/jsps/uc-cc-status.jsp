<%@ include file="/init.jsp"%>

<%@ page import="java.util.List" %>
<%@ page import="com.liferay.portal.kernel.json.JSONFactoryUtil" %>
<%@ page import="com.mhdsys.schema.model.UcccStatus" %>
<%
    // Fetch list from request attribute
    List<UcccStatus> ucccStatusList = (List<UcccStatus>) request.getAttribute("ucccStatusList");

    // Convert list to JSON string (safe for nested objects)
    String ucccStatusListJSON = JSONFactoryUtil.looseSerialize(ucccStatusList);
%>



<div class="card card-background p-0">
	<div class="personal_details">
		<div class="card-header header-card"><liferay-ui:message key="uc-cc-status"/></div>
		<div class="card-body">
			<div class="row">
			
				<div class="col-md-12">
				    <div class="form-group">
				        <label><liferay-ui:message key="UCCC-Status"/> <sup class="text-danger">*</sup></label>
				        <div class="d-flex mt-2">
						    <div class="radio-text">
						      <input type="radio" class="radio-btn" id="UCCCStatusYes" name="UCCCStatus" value="Yes"
						        ${empty constructionTrackerDTO.UCCCStatus || constructionTrackerDTO.UCCCStatus == 'Yes' ? 'checked' : ''}
				          ${mode == 'view'  ? 'disabled' : ''} />
						      <label for="UCCCStatusYes"><liferay-ui:message key="yes"/></label>
						    </div>
						    <div class="radio-text ms-3">
						      <input type="radio" class="radio-btn" id="UCCCStatusNo" name="UCCCStatus" value="No"
						      ${empty constructionTrackerDTO.UCCCStatus || constructionTrackerDTO.UCCCStatus == 'No' ? 'checked' : ''}
				          ${mode == 'view'  ? 'disabled' : ''} />
						      <label for="UCCCStatusNo"><liferay-ui:message key="no"/></label>
						    </div>
					  </div>
				    </div>
				</div>
				</div>
				<!-- submitted block starts ----------------------------------------------------------------------------------------------------- -->
				 <div class="submitted_block">
				 <div class="row">
					<div class="col-md-6">
						<div class="form-group">
							<label><liferay-ui:message key="UCCC-Amount"/><sup class="text-danger">*</sup></label>
							<input type="text" class="form-control" name="UCCCAmount" id="UCCCAmount" <c:if test="${mode eq 'view'}">disabled</c:if> value="${constructionTrackerDTO.UCCCAmount }">
						</div>
					</div>
					
					<div class="col-md-6">
					    <div class="form-group">
					        <label><liferay-ui:message key="extension"/> </label>
					        <div class="d-flex mt-2">
							    <div class="radio-text">
							      <input type="radio" class="radio-btn" id="UCCCExtensionYes" name="UCCCExtension" value="Yes"
							        ${empty constructionTrackerDTO.UCCCExtension || constructionTrackerDTO.UCCCExtension == 'Yes' ? 'checked' : ''}
					          ${mode == 'view'  ? 'disabled' : ''} />
							      <label for="UCCCExtension"><liferay-ui:message key="yes"/></label>
							    </div>
							    <div class="radio-text ms-3">
							      <input type="radio" class="radio-btn" id="UCCCExtension" name="UCCCExtension" value="No"
							      ${empty constructionTrackerDTO.UCCCExtension || constructionTrackerDTO.UCCCExtension == 'No' ? 'checked' : ''}
					          ${mode == 'view'  ? 'disabled' : ''} />
							      <label for="UCCCExtension"><liferay-ui:message key="no"/></label>
							    </div>
						  </div>
					    </div>
					</div>
					
					<!-- If expendicture yes then it should visible -->
					<%-- <div class="col-md-6">
						<div class="form-group">
							<label><liferay-ui:message key="UCCC-Revised-Completion-Date"/></label>
							<input type="date" class="form-control" name="UCCCRevisedCompletionDate" id="UCCCRevisedCompletionDate" <c:if test="${mode eq 'view'}">disabled</c:if>
							 value="<fmt:formatDate value='${constructionTrackerDTO.UCCCRevisedCompletionDate}' pattern='yyyy-MM-dd'/>">
						</div>
					</div> --%>
					
					<div class="col-md-6">
					    <div class="form-group">
					        <label><liferay-ui:message key="work-Completed-In-Timeline"/> </label>
					        <div class="d-flex mt-2">
							    <div class="radio-text">
							      <input type="radio" class="radio-btn" id="workCompletedInTimeline" name="workCompletedInTimeline" value="Yes"
							        ${empty constructionTrackerDTO.workCompletedInTimeline || constructionTrackerDTO.workCompletedInTimeline == 'Yes' ? 'checked' : ''}
					          ${mode == 'view'  ? 'disabled' : ''} />
							      <label for="workCompletedInTimeline"><liferay-ui:message key="yes"/></label>
							    </div>
							    <div class="radio-text ms-3">
							      <input type="radio" class="radio-btn" id="workCompletedInTimeline" name="workCompletedInTimeline" value="No"
							      ${empty constructionTrackerDTO.workCompletedInTimeline || constructionTrackerDTO.workCompletedInTimeline == 'No' ? 'checked' : ''}
					          ${mode == 'view'  ? 'disabled' : ''} />
							      <label for="workCompletedInTimeline"><liferay-ui:message key="no"/></label>
							    </div>
						  	</div>
					    </div>
					</div> 
					 <div id="ucccContainer" class="container mt-2"></div>
					
					
					</div>
					
				<c:if test="${mode ne 'view'}">
               <div class="row reason-row mb-2" data-index="${index}">
				    <div class="buttonsDiv mt-2 uccc-buttons" style="display:none;">
				        <button type="button" class="btn btn-primary" id="addUcccRowBtn">
				            <i class="bi bi-plus-circle"></i>
				        </button>
				        <button type="button" class="btn btn-danger" id="removeUcccRowBtn">
				            <i class="bi bi-dash-circle"></i>
				        </button>
				    </div>
				</div>
              </c:if>
            
                
				
				 </div>
				<!-- submitted block Ends ----------------------------------------------------------------------------------------------------- -->
				
				<!-- Not submitted block Starts ----------------------------------------------------------------------------------------------------- -->
				
				<div class="not_submitted_block">
				<div class="row">	
					<div class="col-md-6">
						<div class="form-group">
							<label><liferay-ui:message key="UCCC-Reason"/><sup class="text-danger">*</sup></label>
							<input type="text" class="form-control" name="UCCCReason" id="UCCCReason" <c:if test="${mode eq 'view'}">disabled</c:if> value="${constructionTrackerDTO.UCCCReason }">
						</div>
					</div>
					
					<div class="col-md-6">
						<div class="form-group">
							<label><liferay-ui:message key="panal-Action"/><sup class="text-danger">*</sup></label>
							<input type="text" class="form-control" name="panalAction" id="panalAction" <c:if test="${mode eq 'view'}">disabled</c:if> value="${constructionTrackerDTO.panalAction }">
						</div>
					</div>
					
					<%-- <div class="col-md-6">
						<div class="form-group">
							<label><liferay-ui:message key="panal-Action-Doc"/><sup class="text-danger">*</sup>
								<em class="bi bi-info-circle-fill" title="<liferay-ui:message key="allowed-only-pdf-file" />"></em>
							</label>
							
							<div class="custom-file">
								<input type="file" class="custom-file-input" id="panalActionDoc" name="panalActionDoc"
									onchange="handleFileUpload(event, 'medicalCertificate', 'medicalCertificateNewPreviewContainer', 'medicalCertificateNewPreviewLink', 'medicalCertificateNewDeleteButton')"> 
								<label class="custom-file-label" for="customFile">
									<liferay-ui:message key="choose-file" />
								</label>
							</div>
										
						</div>
					</div> --%>
					
					<div class="col-md-6">
					  <div class="form-group">
					    <label>
					      <liferay-ui:message key="panal-Action-Doc" />
					      <sup class="text-danger">*</sup>
					      <em class="bi bi-info-circle-fill" title="<liferay-ui:message key='allowed-only-pdf-file-under-2mb' />"></em>
					    </label>
					    <div class="custom-file">
					      <input type="file" class="custom-file-input" id="panalActionDoc" name="panalActionDoc"
					        onchange="handleSingleImageUpload(this,'panalActionDoc','panalActionDocPreviewContainer','panalActionDocPreviewLink','panalActionDocDeleteButton','panalActionDocError','panalActionDocHiddenInput')"
					        <c:if test="${mode eq 'view'}">disabled</c:if> >
					      <label class="custom-file-label" for="panalActionDoc"><liferay-ui:message key="choose-file" /></label>
					    </div>
					    <span id="panalActionDocError" class="text-danger mt-2"></span>
					    <input type="hidden" id="panalActionDocHiddenInput" name="panalActionDocHiddenInput" value="${constructionTrackerDTO.panalActionDoc }" readonly="readonly"/>
					    <input type="hidden" name="hiddenPanelActionDoc" value="${constructionTrackerDTO.panalActionDoc }" readonly="readonly">
					   <div class="mt-3" id="panalActionDocPreviewContainer" style="${not empty panalActionDocURL and panalActionDocURL != '' ? '' : 'display:none;'}">
					      <div class="d-flex">
					      <a href="${panalActionDocURL}" target="_blank" id="panalActionDocPreviewLink" class="text-truncate">View document</a>
					         <c:if test="${mode ne 'view' && mode ne 'edit'}">
							      <button type="button" class="btn btn-sm btn-danger" id="panalActionDocDeleteButton"
							        onclick="removeSingleImageFile(this,'panalActionDoc','panalActionDocPreviewContainer','panalActionDocPreviewLink','panalActionDocHiddenInput')">
							        	<i class="bi bi-x-circle-fill"></i>
							      </button>
					         </c:if>
							</div>
					    </div>
					  </div>
					</div>
					
				
				</div>
				</div>
				<!-- Not submitted block Ends ----------------------------------------------------------------------------------------------------- -->
				
			</div>
		</div>
	</div>


<c:if test="${constructionTrackerDTO.applicationStatus == 1 || constructionTrackerDTO.applicationStatus == 2}">
<div class="card card-background p-0 w-100">
	<div class="personal_details">
		<div class="card-header header-card"><liferay-ui:message key="review-by-deputy-director"/></div>
		<div class="card-body">
			<div class="row">
		      <div class="col-md-12">
		     	 <div class="form-group">
			        <label><liferay-ui:message key="review" /><sup class="text-danger">*</sup></label>
			        <input type="text" class="form-control" name="review" id="review" value="${constructionTrackerDTO.dddReview }" readonly="readonly"/>
			   	 </div>
		      </div>
		      <div class="col-md-12">
		      	<div class="form-group">
		      		<label for=""> <liferay-ui:message key="review-document" /></label>
				
				    <div class="custom-file mt-2">
				    <c:choose>
				        <c:when test="${not empty dddDocURL}">
				            <a href="${hoDocURL}" target="_blank">
				                <liferay-ui:message key="view-document" />
				            </a>
				        </c:when>
				        <c:otherwise>
				            <span><liferay-ui:message key="no-document-uploaded" /></span>
				        </c:otherwise>
				    </c:choose>
				</div>
				
		      	</div>
		      </div>
		    </div>
		</div>
	</div>
</div>
</c:if>

<c:if test="${constructionTrackerDTO.applicationStatus == 2}">
<div class="card card-background p-0 w-100">
	<div class="personal_details">
		<div class="card-header header-card"><liferay-ui:message key="review-by-ho"/></div>
		<div class="card-body">
			<div class="row">
		      <div class="col-md-12">
		     	 <div class="form-group">
			        <label><liferay-ui:message key="review" /><sup class="text-danger">*</sup></label>
			        <input type="text" class="form-control" name="review" id="review" value="${constructionTrackerDTO.hoReview }" readonly="readonly"/>
			   	 </div>
		      </div>
		      <div class="col-md-12">
		      	<div class="form-group">
		      		<label for="">  <liferay-ui:message key="review-document" /> </label>
				
				  <div class="custom-file mt-2">
				    <c:choose>
				        <c:when test="${not empty hoDocURL}">
				            <a href="${hoDocURL}" target="_blank">
				                <liferay-ui:message key="view-document" />
				            </a>
				        </c:when>
				        <c:otherwise>
				            <span><liferay-ui:message key="no-document-uploaded" /></span>
				        </c:otherwise>
				    </c:choose>
				</div>

		      	</div>
		      </div>
		    </div>
		</div>
	</div>
</div>
</c:if>

<script>

var ucccStatusActionIndex = 0;
let minUcccBlockLength = 1; // minimum block should always remain
let ucccAllFieldsValid = true;
let maxUcccBlockLength = 3


function ucccStatusActionRow() {
    	console.log("panalActionRow method called")
    const row =
		    '<div class="row reason-row mb-2" data-index="' + ucccStatusActionIndex + '">' +
		
		    // UCCC Revised Completion Date
		    '<div class="col-md-6">' +
		        '<div class="form-group">' +
		            '<label><liferay-ui:message key="UCCC-Revised-Completion-Date"/><sup class="text-danger">*</sup></label>' +
		            '<input type="date" class="form-control" name="UCCCRevisedCompletionDate_' + ucccStatusActionIndex + '" id="UCCCRevisedCompletionDate_' + ucccStatusActionIndex + '">' +
		        '</div>' +
		    '</div>' +
		
		    // Work Completed In Timeline (Yes/No)
		    '<div class="col-md-6">' +
		        '<div class="form-group">' +
		            '<label><liferay-ui:message key="work-Completed-In-Timeline"/><sup class="text-danger">*</sup></label>' +
		            '<div class="d-flex mt-2">' +
		                '<div class="radio-text">' +
		                    '<input type="radio" class="radio-btn" id="ucccWorkCompletedInTimelineYes_' + ucccStatusActionIndex + '" name="ucccWorkCompletedInTimeline_' + ucccStatusActionIndex + '" value="Yes" checked>' +
		                    '<label for="ucccWorkCompletedInTimelineYes_' + ucccStatusActionIndex + '">Yes</label>' +
		                '</div>' +
		                '<div class="radio-text ms-3">' +
		                    '<input type="radio" class="radio-btn" id="ucccWorkCompletedInTimelineNo_' + ucccStatusActionIndex + '" name="ucccWorkCompletedInTimeline_' + ucccStatusActionIndex + '" value="No">' +
		                    '<label for="ucccWorkCompletedInTimelineNo_' + ucccStatusActionIndex + '">No</label>' +
		                '</div>' +
		            '</div>' +
		        '</div>' +
		    '</div>' +
		
		    // UCCC Reason (Hidden by default)
		    '<div class="col-md-6 reason-section" style="display:none;">' +
		        '<div class="form-group">' +
		            '<label><liferay-ui:message key="UCCC-Reason"/><sup class="text-danger">*</sup></label>' +
		            '<input type="text" class="form-control" name="UCCCReason_' + ucccStatusActionIndex + '" id="UCCCReason_' + ucccStatusActionIndex + '">' +
		        '</div>' +
		    '</div>' +
		
		    // Panal Action (Hidden by default)
		    '<div class="col-md-6 panal-action-section" style="display:none;">' +
		        '<div class="form-group">' +
		            '<label><liferay-ui:message key="panal-Action"/><sup class="text-danger">*</sup></label>' +
		            '<input type="text" class="form-control" name="panalAction_' + ucccStatusActionIndex + '" id="panalAction_' + ucccStatusActionIndex + '">' +
		        '</div>' +
		    '</div>' +
		
		    // Panal Action Doc Upload (Hidden by default)
		    '<div class="col-md-6 panal-doc-section" style="display:none;">' +
		        '<div class="form-group">' +
		            '<label><liferay-ui:message key="panal-Action-Doc" /> <sup class="text-danger">*</sup>' +
		                '<em class="bi bi-info-circle-fill" title="Allowed only PDF file under 2MB"></em>' +
		            '</label>' +
		            '<div class="custom-file">' +
		                '<input type="file" class="custom-file-input" id="panalActionDoc_' + ucccStatusActionIndex + '" name="panalActionDoc_' + ucccStatusActionIndex + '" ' +
		                    'onchange="handleSingleImageUpload(this, \'panalActionDoc_' + ucccStatusActionIndex + '\', \'panalActionDocPreviewContainer_' + ucccStatusActionIndex + '\', \'panalActionDocPreviewLink_' + ucccStatusActionIndex + '\', \'panalActionDocDeleteButton_' + ucccStatusActionIndex + '\', \'panalActionDocError_' + ucccStatusActionIndex + '\', \'panalActionDocHiddenInput_' + ucccStatusActionIndex + '\')">' +
		                '<label class="custom-file-label" for="panalActionDoc_' + ucccStatusActionIndex + '">Choose file</label>' +
		            '</div>' +
		            '<span id="panalActionDocError_' + ucccStatusActionIndex + '" class="text-danger mt-2"></span>' +
		            '<input type="hidden" id="panalActionDocHiddenInput_' + ucccStatusActionIndex + '" name="panalActionDocHiddenInput_' + ucccStatusActionIndex + '" readonly="readonly"/>' +
		            '<div class="mt-3" id="panalActionDocPreviewContainer_' + ucccStatusActionIndex + '" style="display:none;">' +
		                '<div class="d-flex">' +
		                    '<a href="#" target="_blank" id="panalActionDocPreviewLink_' + ucccStatusActionIndex + '" class="text-truncate">View document</a>' +
		                    '<button type="button" class="btn btn-sm btn-danger" id="panalActionDocDeleteButton_' + ucccStatusActionIndex + '"' +
		                        'onclick="removeSingleImageFile(this, \'panalActionDoc_' + ucccStatusActionIndex + '\', \'panalActionDocPreviewContainer_' + ucccStatusActionIndex + '\', \'panalActionDocPreviewLink_' + ucccStatusActionIndex + '\', \'panalActionDocHiddenInput_' + ucccStatusActionIndex + '\')">' +
		                        '<i class="bi bi-x-circle-fill"></i>' +
		                    '</button>' +
		                '</div>' +
		            '</div>' +
		        '</div>' +
		    '</div>' +
		
		    '</div>';

    const $row = $($.parseHTML(row));
    console.log("row::::::::::::",$row)
    $('#ucccContainer').append($row);
    applyUcccValidationRules($row, ucccStatusActionIndex);
    
    
    // Disable all inputs if mode is 'view' or 'edit'
     const mode = $('#mode').val();
    if (mode === 'view' || mode === 'edit') {
        $row.find('input, button').prop('disabled', true);
    } 

    ucccStatusActionIndex++;
}


//Add this function to apply validation rules for UC/CC Status
function applyUcccValidationRules(block, ucccRowIndex) {

    // --- Custom validation methods (if not already defined globally) ---
    $.validator.addMethod("filesize", function(value, element, param) {
        if (this.optional(element) || !element.files || !element.files[0]) {
            return true;
        }
        return element.files[0].size <= param;
    }, "<liferay-ui:message key='file-size-must-be-less-than-2mb' />");

    // --- Revised Completion Date ---
    block.find('#UCCCRevisedCompletionDate_' + ucccRowIndex).rules('add', {
        required: true,
        pastOrToday: true,
       /*  date: true, */
        messages: {
            required: "<liferay-ui:message key='please-enter-revised-completion-date' />",
            /* date: "<liferay-ui:message key='please-enter-valid-date' />" */
        }
    });

    // --- UCCC Reason ---
    block.find('#UCCCReason_' + ucccRowIndex).rules('add', {
    	required: true,
	    minlength: 3,
	    maxlength: 75,
	    alphanumericWithPeroidAndHyphen: true,
	    noEdgeSpaces: true,
	    singleSpaceOnly: true,
	    noConsecutiveSpecials: true,
        messages: {
        	required: '<liferay-ui:message key="please-enter-reason" />',
	        minlength: '<liferay-ui:message key="please-enter-min-3-characters" />',
	        maxlength: '<liferay-ui:message key="please-enter-max-75-characters" />'
        }
    });

    // --- Penal Action ---
    block.find('#panalAction_' + ucccRowIndex).rules('add', {
    	required: true,
	    minlength: 3,
	    maxlength: 75,
	    alphanumericWithPeroidAndHyphen: true,
	    noEdgeSpaces: true,
	    singleSpaceOnly: true,
	    noConsecutiveSpecials: true,
	    messages: {
	        required: '<liferay-ui:message key="please-enter-panel-action" />',
	        minlength: '<liferay-ui:message key="please-enter-min-3-characters" />',
	        maxlength: '<liferay-ui:message key="please-enter-max-75-characters" />'
	    }
    });

    // --- Penal Action Document (File Upload) ---
    block.find('#panalActionDoc_' + ucccRowIndex).rules('add', {
        required: function() {
            // Required only if "Work Completed In Timeline" = "No"
            return $('#ucccWorkCompletedInTimelineNo_' + ucccRowIndex).is(':checked');
        },
  
       
        messages: {
            required: "<liferay-ui:message key='please-upload-panel-action-document' />",
         
        }
    });
    
 

}



 function populateUcccStatusAction(ucccStatusList) {
	    let mode = '${mode}';
		const isDisabled = (mode === 'view' || mode === 'edit') ? 'disabled' : '';
		const isReadOnly = (mode === 'view' || mode === 'edit') ? 'readonly' : '';
		console.log("populateUcccStatusAction::::::::",mode)

    // Clear existing rows
    $('#ucccContainer').empty();
    console.log("ucccStatusList.length::::::::",ucccStatusList.length)
    for (var index = 0; index < ucccStatusList.length; index++) {
        var item = ucccStatusList[index];

        var row = '<div class="row reason-row mb-2" data-index="' + index + '">' +
        '<input type="hidden" id="imageId_' + index + '" name="imageId_' + index + '" value="' + (item.penalActionDoc ? item.penalActionDoc : 0) + '">'+
            // UCCC Revised Completion Date
            '<div class="col-md-6">' +
                '<div class="form-group">' +
                    '<label><liferay-ui:message key="UCCC-Revised-Completion-Date"/><sup class="text-danger">*</sup></label>' +
                    '<input type="date" class="form-control" ' +
                        'name="UCCCRevisedCompletionDate_' + index + '" ' +
                        'id="UCCCRevisedCompletionDate_' + index + '" ' +
                        'value="' + formatDateForInput(item.ucccRevisedCompletionDate) + '" ' + isReadOnly + '>' +
                '</div>' +
            '</div>' +

            // Work Completed In Timeline
            '<div class="col-md-6">' +
                '<div class="form-group">' +
                    '<label><liferay-ui:message key="work-Completed-In-Timeline"/><sup class="text-danger">*</sup></label>' +
                    '<div class="d-flex mt-2">' +
                        '<div class="radio-text">' +
                            '<input type="radio" class="radio-btn" ' +
                                'id="ucccWorkCompletedInTimelineYes_' + index + '" ' +
                                'name="ucccWorkCompletedInTimeline_' + index + '" ' +
                                'value="Yes" ' + ((item.workCompletedInTimeline === 'Yes') ? 'checked' : '') + ' ' + isDisabled + '>' +
                            '<label for="ucccWorkCompletedInTimelineYes_' + index + '">Yes</label>' +
                        '</div>' +
                        '<div class="radio-text ms-3">' +
                            '<input type="radio" class="radio-btn" ' +
                                'id="ucccWorkCompletedInTimelineNo_' + index + '" ' +
                                'name="ucccWorkCompletedInTimeline_' + index + '" ' +
                                'value="No" ' + ((item.workCompletedInTimeline === 'No') ? 'checked' : '') + ' ' + isDisabled + '>' +
                            '<label for="ucccWorkCompletedInTimelineNo_' + index + '">No</label>' +
                        '</div>' +
                    '</div>' +
                '</div>' +
            '</div>' +

            // UCCC Reason
            '<div class="col-md-6 reason-section" style="display:' + ((item.workCompletedInTimeline === 'No') ? 'block' : 'none') + ';">' +
                '<div class="form-group">' +
                    '<label><liferay-ui:message key="UCCC-Reason"/><sup class="text-danger">*</sup></label>' +
                    '<input type="text" class="form-control" ' +
                        'name="UCCCReason_' + index + '" ' +
                        'id="UCCCReason_' + index + '" ' +
                        'value="' + (item.ucccReason || '') + '" ' + isReadOnly + '>' +
                '</div>' +
            '</div>' +

            // Penal Action
            '<div class="col-md-6 panal-action-section" style="display:' + ((item.workCompletedInTimeline === 'No') ? 'block' : 'none') + ';">' +
                '<div class="form-group">' +
                    '<label><liferay-ui:message key="panal-Action"/><sup class="text-danger">*</sup></label>' +
                    '<input type="text" class="form-control" ' +
                        'name="panalAction_' + index + '" ' +
                        'id="panalAction_' + index + '" ' +
                        'value="' + (item.penalAction || '') + '" ' + isReadOnly + '>' +
                '</div>' +
            '</div>' +

            // Penal Action Document
            /* '<div class="col-md-6 panal-doc-section" style="display:' + ((item.workCompletedInTimeline === 'No') ? 'block' : 'none') + ';">' +
                '<div class="form-group">' +
                    '<label>Penal Action Document <sup class="text-danger">*</sup></label>' +
                    '<div class="custom-file">' +
                        '<input type="file" class="custom-file-input" ' +
                            'id="panalActionDoc_' + index + '" ' +
                            'name="panalActionDoc_' + index + '" ' + isDisabled + '>' +
                        '<label class="custom-file-label" for="panalActionDoc_' + index + '">Choose file</label>' +
                    '</div>' +
                    '<input type="hidden" id="panalActionDocHiddenInput_' + index + '" ' +
                        'name="panalActionDocHiddenInput_' + index + '" ' +
                        'value="' + (item.penalActionDoc || '') + '" readonly="readonly">' +
                    '<div class="mt-3" id="panalActionDocPreviewContainer_' + index + '" ' +
                        'style="display:' + (item.penalActionDoc ? 'block' : 'none') + ';">' +
                        '<a href="' + (item.penalActionDoc ? '/documents/' + item.penalActionDoc : '#') + '" ' +
                            'target="_blank" id="panalActionDocPreviewLink_' + index + '">View document</a>' +
                    '</div>' +
                '</div>' +
            '</div>' + */
            '<div class="col-md-6 panal-doc-section" style="display:' + 
            ((item.workCompletedInTimeline === "No") ? "block" : "none") + ';">' +
              '<div class="form-group">' +
                '<label><liferay-ui:message key="panal-Action-Doc" /><sup class="text-danger">*</sup>' +
                  '<em class="bi bi-info-circle-fill" title="Allowed only PDF file under 2MB"></em>' +
                '</label>' +
                '<div class="custom-file">' +
                  '<input type="file" class="custom-file-input" ' +
                    'id="panalActionDoc_' + index + '" ' +
                    'name="panalActionDoc_' + index + '" ' + isDisabled + ' ' +
                    'onchange="handleSingleImageUpload(this, \'panalActionDoc_' + index + '\', ' +
                    '\'panalActionDocPreviewContainer_' + index + '\', ' +
                    '\'panalActionDocPreviewLink_' + index + '\', ' +
                    '\'panalActionDocDeleteButton_' + index + '\', ' +
                    '\'panalActionDocError_' + index + '\', ' +
                    '\'panalActionDocHiddenInput_' + index + '\')">' +
                  '<label class="custom-file-label" for="panalActionDoc_' + index + '">Choose file</label>' +
                '</div>' +
                '<span id="panalActionDocError_' + index + '" class="text-danger mt-2"></span>' +
                '<input type="hidden" id="panalActionDocHiddenInput_' + index + '" ' +
                  'name="panalActionDocHiddenInput_' + index + '" ' +
                  'value="' + (item.penalActionDoc || '') + '" readonly="readonly"/>' +

                
                '<div class="mt-3" id="panalActionDocPreviewContainer_' + index + '" ' +
                  'style="display:' + (item.penalActionDocURL ? 'block' : 'none') + ';">' +
                  '<div class="d-flex">' +
                    '<a href="' + (item.penalActionDocURL || '#') + '" target="_blank" ' +
                      'id="panalActionDocPreviewLink_' + index + '" class="text-truncate">View document</a>' +
                    '<button type="button" class="btn btn-sm btn-danger" ' +
                      'id="panalActionDocDeleteButton_' + index + '" ' +
                      'onclick="removeSingleImageFile(this, \'panalActionDoc_' + index + '\', ' +
                      '\'panalActionDocPreviewContainer_' + index + '\', ' +
                      '\'panalActionDocPreviewLink_' + index + '\', ' +
                      '\'panalActionDocHiddenInput_' + index + '\')">' +
                      '<i class="bi bi-x-circle-fill"></i>' +
                    '</button>' +
                  '</div>' +
                '</div>' +
              '</div>' +
            '</div>'+

        '</div>'; // row end

        $('#ucccContainer').append(row);
    }
    
     ucccStatusActionIndex=ucccStatusList.length;
    if(ucccStatusList[ucccStatusList.length-1].workCompletedInTimeline==="No" && ucccStatusList.length<maxUcccBlockLength){
   	 ucccStatusActionRow();
   	 console.log("call 1")
   } 
} 


function formatDateForInput(dateString) {
    if (!dateString) return '';
    const date = new Date(dateString);
    return date.toISOString().split('T')[0];
}

var ucccStatusList=null
var isChange=0;
var isDisplay=0;
$(document).ready(function () {debugger
	ucccStatusList= <%= ucccStatusListJSON != null ? ucccStatusListJSON : "[]" %>;
	
	
	 <%--  var ucccStatusList = <%= ucccStatusListJSON != null ? ucccStatusListJSON : "[]" %>;
	  if (ucccStatusList && ucccStatusList.length > 0) {
	        populateUcccStatusAction(ucccStatusList);
	    }
    console.log("UCCC Status List:", ucccStatusList); --%>
	// Initialize form validation
	
	/* let panalActionDocURL = '${panalActionDocURL}';
	if(panalActionDocURL){
		$('#panalActionDocPreviewLink').text('View document').attr('href', panalActionDocURL);
		$('#panalActionDocPreviewContainer').show();
	} */
	
	$('#constructionTracker').validate({
		ignore: ':hidden',
		errorClass: 'text-danger',
		errorElement: 'div'
	});

	// Initial evaluation
	toggleUCCBlocks(ucccStatusList);
	toggleExtensionField();
	

	// Event listeners
	$('input[name="UCCCStatus"]').on('change', function () {
		toggleUCCBlocks(ucccStatusList);
	});

	$('input[name="UCCCExtension"]').on('change', function () {
		toggleExtensionField();
	});
	
	
	// Listen for change on dynamically added radios
		$(document).on('change', 'input[name^="ucccWorkCompletedInTimeline_"]', function () {
		    const index = $(this).attr('name').split('_')[1]; // extract index from name
		    const value = $(this).val();
		
		    const $row = $('[data-index="' + index + '"]');
		    
		    if (value === 'No') {
		        $row.find('.reason-section').show();
		        $row.find('.panal-action-section').show();
		        $row.find('.panal-doc-section').show();
		        $('.uccc-buttons').show(); // global selector
		    } else {
		        $row.find('.reason-section, .panal-action-section, .panal-doc-section').hide();
		        $row.find('.reason-section input, .panal-action-section input, .panal-doc-section input[type="text"]').val('');
		        $row.find('.panal-doc-section input[type="file"]').val('');
		        $row.find('.panal-doc-section input[type="hidden"]').val('');
		        $row.find('.panal-doc-section #panalActionDocPreviewContainer_' + index).hide();
		        $('.uccc-buttons').hide(); // hide globally
		    }

		});


	
	
	// Toggle UC/CC blocks
	function toggleUCCBlocks(ucccStatusList) {
		
		const isSubmitted = $('input[name="UCCCStatus"]:checked').val() === 'Yes';
        console.log("ucccStatusList:::::",ucccStatusList)
		if (isSubmitted) {
			 var ucccStatusList = <%= ucccStatusListJSON != null ? ucccStatusListJSON : "[]" %>;
			  if (ucccStatusList && ucccStatusList.length > 0 && isChange===0) {
				 
			        populateUcccStatusAction(ucccStatusList);
			        console.log("ucccStatusList[ucccStatusList.length-1].workCompletedInTimeline==='No':::::::",ucccStatusList[ucccStatusList.length-1].workCompletedInTimeline==="No")
			       
			    }else{
			     ucccStatusActionRow();
			     console.log("call 2")
			    }
			 
			 
			$('.submitted_block').show();
			$('.not_submitted_block').hide();

			// Reset not-submitted values
			$('#UCCCReason, #panalAction').val('');
			$('#panalActionDoc').val('');
			$('#medicalCertificateNewPreviewContainer').hide();
			$('#medicalCertificateNewPreviewLink').text('').attr('href', '#');
			$('#medicalCertificateNewDeleteButton').hide();

			// Add validation
			$('#UCCCAmount').rules('add', {
				required: true,
				number: true,
				min:1,
				maxlength: 10,
				messages: {
					required: '<liferay-ui:message key="please-enter-amount" />',
					number: '<liferay-ui:message key="amount-must-be-number" />',
					 min: '<liferay-ui:message key="amount-must-be-positive-or-greater-than-0" />',
					 maxlength: '<liferay-ui:message key="maximum-10-digits-should-allow" />',
					 
				}
			});
			
			$('#UCCCRevisedCompletionDate').rules('add', {
				pastOrToday: true,
			});

			// Remove validations from not-submitted
			$('#UCCCReason, #panalAction, #panalActionDoc').each(function () {
				$(this).rules('remove');
				$(this).removeClass('error');
				$(this).siblings('div.text-danger').remove();
			});
			
		} else {
			$('.submitted_block').hide();
			$('.not_submitted_block').show();

			// Reset submitted values
			$('#UCCCAmount').val('');
			$('#UCCCRevisedCompletionDate').val('');
			$('input[name="UCCCExtension"][value="Yes"]').prop('checked', true);
			$('input[name="workCompletedInTimeline"][value="Yes"]').prop('checked', true);

			// Remove validations from submitted
			$('#UCCCAmount').rules('remove');
			$('#UCCCAmount').removeClass('error');
			$('#UCCCAmount').siblings('div.text-danger').remove();

			 $('#ucccContainer').empty();
			 ucccStatusActionIndex=0;
			 isChange=1;
			
			// Add validations for not-submitted
			/* $('#UCCCReason, #panalAction').each(function () {
				$(this).rules('add', {
					 required: true,
 	       	        minlength: 3,
	   	       	        maxlength: 75,
	   	       	  alphanumericWithPeroidAndHyphen: true,
	   		             noEdgeSpaces: true,
	   		             singleSpaceOnly: true,
	   		             noConsecutiveSpecials:true,
					messages: {
						required: '<liferay-ui:message key="please-enter-reason" />',
						required: '<liferay-ui:message key="please-enter-panel-action" />',
		 	        	  minlength: "<liferay-ui:message key='please-enter-min-3-characters' />",
		     	          maxlength: "<liferay-ui:message key='please-enter-max-75-characters' />",
					}
				});
			}); */
			
			// Validation for UCCCReason
			$('#UCCCReason').rules('add', {
			    required: true,
			    minlength: 3,
			    maxlength: 75,
			    alphanumericWithPeroidAndHyphen: true,
			    noEdgeSpaces: true,
			    singleSpaceOnly: true,
			    noConsecutiveSpecials: true,
			    messages: {
			        required: '<liferay-ui:message key="please-enter-reason" />',
			        minlength: '<liferay-ui:message key="please-enter-min-3-characters" />',
			        maxlength: '<liferay-ui:message key="please-enter-max-75-characters" />'
			    }
			});

			// Validation for panalAction
			$('#panalAction').rules('add', {
			    required: true,
			    minlength: 3,
			    maxlength: 75,
			    alphanumericWithPeroidAndHyphen: true,
			    noEdgeSpaces: true,
			    singleSpaceOnly: true,
			    noConsecutiveSpecials: true,
			    messages: {
			        required: '<liferay-ui:message key="please-enter-panel-action" />',
			        minlength: '<liferay-ui:message key="please-enter-min-3-characters" />',
			        maxlength: '<liferay-ui:message key="please-enter-max-75-characters" />'
			    }
			});


			/* $('#panalActionDoc').rules('add', {
				required: true,
				accept: 'application/pdf',
				messages: {
					required: '<liferay-ui:message key="please-upload-pdf" />',
					accept: '<liferay-ui:message key="only-pdf-allowed" />'
				}
			}); */
			
		}
	}

	// Toggle Revised Completion Date field
	function toggleExtensionField() {debugger
		const isYes = $('input[name="UCCCExtension"]:checked').val() === 'Yes';
		/* const $field = $('#UCCCRevisedCompletionDate').closest('.col-md-6'); */

		if (isYes) {
			
		/* 	$field.show(); */
			$("#workCompletedInTimeline").closest('.col-md-6').hide()
			
			 if (isDisplay==1) {
			    ucccStatusActionRow(); 
			}
			 isDisplay=1;
		} else {
		/* 	$field.hide(); */
			/* $('#UCCCRevisedCompletionDate').val(''); */
			$("#workCompletedInTimeline").closest('.col-md-6').show()
			  $('#ucccContainer').empty();
			ucccStatusActionIndex=0;
			$('.uccc-buttons').hide();
		}
	}
	function toggleWorkCompletedInTimeline() {
	    const isNo = $('input[name="workCompletedInTimeline"]:checked').val() === 'No';
	    
	    // Select all related fields by class or id
	    const $fields = $('.workUcccReason, .workpanalAction, #workPanalActionDoc').closest('.col-md-6');

	    if (isNo) {
	        $fields.show();
	    } else {
	        $fields.hide();
	        // Clear values
	        $('.workUCCCReason, .workpanalAction').val('');
	        $('#workPanalActionDoc').val('');
	    }
	}


	
	 function formatDateForInput(dateStr) {
         if (!dateStr) return '';
         const date = new Date(dateStr);
         return date.toISOString().split('T')[0];
     }
	 
	// Add Button Logic
	 $(document).on('click', '#addUcccRowBtn', function () {
	     let blocks = $('#ucccContainer .reason-row');

	     // Validate existing rows before adding (optional)
	     let isValid = true;
	     blocks.each(function () {
	         $(this).find('input, select, textarea').each(function () {
	             if ($(this).is(':visible') && !$(this).valid()) {
	                 isValid = false;
	             }
	         });
	     });

	     if (!isValid) {
	         return; // Stop adding if validation fails
	     }
         console.log("blocks.length:::::::::::",blocks.length)
	     if (blocks.length < maxUcccBlockLength) {
	         ucccStatusActionRow();
	         console.log("call 4")
	         $('.uccc-buttons').hide();
	     }

	     // Disable add button if max reached
	     if ($('#ucccContainer .reason-row').length >= maxUcccBlockLength) {
	         $('#addUcccRowBtn').prop('disabled', true);
	     } else {
	         $('#addUcccRowBtn').prop('disabled', false);
	     }
	     
	 });

	 // Remove Button Logic
	 $(document).on('click', '#removeUcccRowBtn', function () {
	     const blocks = $('#ucccContainer .reason-row');
	     if (blocks.length > minUcccBlockLength) {
	         blocks.last().remove();
	     }

	     // Re-enable add button if below max
	     if ($('#ucccContainer .reason-row').length < maxUcccBlockLength) {
	         $('#addUcccRowBtn').prop('disabled', false);
	     }
	    

	     // If only one row left, hide remove button
	     if ($('#ucccContainer .reason-row').length <= minUcccBlockLength) {
	         $('.uccc-buttons').hide();
	     }
	    
	 });

	
});

function reset_uc_cc_status() {

	 if(!isEditMode){
	   	 resetAllFields();
	   	const previewContainer = document.getElementById("panalActionDocPreviewContainer");
	    const previewLink = document.getElementById("panalActionDocPreviewLink");
	    const errorSpan = document.getElementById("panalActionDocError");
	    const hiddenInput = document.getElementById("hiddenPanelActionDoc");
	    const hiddenInput2 = document.getElementById("panalActionDocHiddenInput");
	    const fileInput = document.getElementById("panalActionDoc");
	    const fileLabel = document.querySelector("label[for='panalActionDoc']");

	    if (previewContainer) previewContainer.style.display = "none";
	    if (previewLink) {
	        previewLink.href = "#";
	        previewLink.textContent = "";
	    }
	    if (errorSpan) {
	        errorSpan.textContent = "";
	        errorSpan.style.display = "none";
	    }
	    if (hiddenInput) hiddenInput.value = "";
	    if (hiddenInput2) hiddenInput2.value = "";
	    if (fileInput) fileInput.value = "";
	    if (fileLabel) fileLabel.textContent = "Choose file"; // Adjust for localization if needed

	    clearInputFile("panalActionDoc");
	 }
    
}


</script>
