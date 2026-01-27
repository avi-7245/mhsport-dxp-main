<%@page import="com.liferay.portal.kernel.language.LanguageUtil"%>
<%@ include file="/init.jsp" %>
<portlet:resourceURL id="injuryDetailsResourceCommand" var="suspensionRemarksEntry" /> 

<!-- MS SCREENING FORM -->
<div class="common-forms-div">
  <div class="container">
    <div class="row">
      <div class="col-md-12">
        <div class="border-0 card shadow">
          <div class="align-items-center back-btn-cn card-header d-flex justify-content-between">
            <h5><liferay-ui:message key="ms-screening" /></h5>
            <div>
              <a href="/group/guest/athelet-details" class="btn btn-primary btn-sm rounded-pill back-btn-cn">
                <i class="bi bi-arrow-left-circle mr-1"></i>
                <liferay-ui:message key="back" />
              </a>
            </div>
          </div>

          <form id="msDetails" method="post" autocomplete="off">
            <div class="card-body">
              <div class="card card-background p-0">
                <div class="card-header"><liferay-ui:message key="ms-screening-details" /></div>
                <div class="card-body">

                  <!-- Row 1 -->
                  <div class="row mb-3">
                    <div class="col-md-6">
                      <div class="form-group">
                        <label><liferay-ui:message key="kibler-lateral-slide-test" /></label>
                        <input type="text" class="form-control" placeholder="Right"
                          name="kiblerLateralSlideRight" id="kiblerLateralSlideRight"
                          value="${medicalReports.kiblerLateralSlideRight != null ? medicalReports.kiblerLateralSlideRight : ''}"
                          <c:if test="${not empty medicalReports.kiblerLateralSlideRight}">disabled</c:if> />
                      </div>
                    </div>
                    <div class="col-md-6">
                      <div class="form-group">
                        <label>&nbsp;</label>
                        <input type="text" class="form-control" placeholder="Left"
                          name="kiblerLateralSlideLeft" id="kiblerLateralSlideLeft"
                          value="${medicalReports.kiblerLateralSlideLeft != null ? medicalReports.kiblerLateralSlideLeft : ''}"
                          <c:if test="${not empty medicalReports.kiblerLateralSlideLeft}">disabled</c:if> />
                      </div>
                    </div>
                  </div>

                  <!-- Row 2 -->
                  <div class="row mb-3">
                    <div class="col-md-6">
                      <div class="form-group">
                        <label><liferay-ui:message key="rectus-femoris-length-test" /></label>
                        <input type="text" class="form-control" placeholder="Right"
                          name="rectusFemorisLengthRight" id="rectusFemorisLengthRight"
                          value="${medicalReports.rectusFemorisLengthRight != null ? medicalReports.rectusFemorisLengthRight : ''}"
                          <c:if test="${not empty medicalReports.rectusFemorisLengthRight}">disabled</c:if> />
                      </div>
                    </div>
                    <div class="col-md-6">
                      <div class="form-group">
                        <label>&nbsp;</label>
                        <input type="text" class="form-control" placeholder="Left"
                          name="rectusFemorisLengthLeft" id="rectusFemorisLengthLeft"
                          value="${medicalReports.rectusFemorisLengthLeft != null ? medicalReports.rectusFemorisLengthLeft : ''}"
                          <c:if test="${not empty medicalReports.rectusFemorisLengthLeft}">disabled</c:if> />
                      </div>
                    </div>
                  </div>

                  <!-- Row 3 -->
                  <div class="row mb-3">
                    <div class="col-md-6">
                      <div class="form-group">
                        <label><liferay-ui:message key="hip-flexion-rom" /></label>
                        <input type="text" class="form-control" placeholder="Right"
                          name="hipFlexionRomRight" id="hipFlexionRomRight"
                          value="${medicalReports.hipFlexionRomRight != null ? medicalReports.hipFlexionRomRight : ''}"
                          <c:if test="${not empty medicalReports.hipFlexionRomRight}">disabled</c:if> />
                      </div>
                    </div>
                    <div class="col-md-6">
                      <div class="form-group">
                        <label>&nbsp;</label>
                        <input type="text" class="form-control" placeholder="Left"
                          name="hipFlexionRomLeft" id="hipFlexionRomLeft"
                          value="${medicalReports.hipFlexionRomLeft != null ? medicalReports.hipFlexionRomLeft : ''}"
                          <c:if test="${not empty medicalReports.hipFlexionRomLeft}">disabled</c:if> />
                      </div>
                    </div>
                  </div>

                </div>
              </div>
            </div>

            <!-- Submit Button -->
            <div class="card-footer bg-transparent text-right p-4">
              <button type="reset" class="btn btn-primary" onclick="#">
                <liferay-ui:message key="cancel" />
              </button>
              <button type="submit" class="btn btn-primary" onclick="suspensionRemarkEntry(event)"><liferay-ui:message key="submit" /></button>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- MODAL POPUP -->
<div class="modal fade" id="saveSuspectOfficerAdditionModal" tabindex="-1" role="dialog"
     aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content modal-bg">
      <div class="modal-header justify-content-center align-items-center">
        <h5 class="modal-title" id="exampleModalLongTitle"><liferay-ui:message key="ms-screening-details" /></h5>
        <button type="button" class="close d-none" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body text-center">
        <p id="success-application"></p>
      </div>
      <div class="modal-footer d-flex justify-content-end">
        <button type="button" class="btn btn-secondary maha-save-btn" data-bs-dismiss="modal" onclick="location.reload();"><liferay-ui:message key="close" /></button>
      </div>
    </div>
  </div>
</div>

<!-- AJAX SCRIPT -->
<script type="text/javascript">
function suspensionRemarkEntry(event) {
  event.preventDefault();
  debugger;
  
  if (!$("#msDetails").valid()) {
    return;
  }

  var form = $("#msDetails")[0];
  var formData = new FormData(form);
  formData.append("formName", "msDetails");

  $.ajax({
    type: "POST",
    url: '${suspensionRemarksEntry}',
    data: formData,
    contentType: false,
    cache: false,
    processData: false,
    success: function(data) {
      if (!data) {
        $('#success-application').html("Empty response from server.");
        $("#saveSuspectOfficerAdditionModal").modal('show');
        return;
      }

      if (typeof data === "string") {
        data = JSON.parse(data);
      }

      let msg = "";

      if (data.status === "success") {
          msg = "<%= LanguageUtil.get(request, "ms-screening-saved") %>";
      } else if (data.status === "error") {
          msg = "<%= LanguageUtil.get(request, "failed-to-save-record") %>";
      } else {
          msg = "<%= LanguageUtil.get(request, "unknown-response-from-server") %>";
      }


      $('#success-application').html(msg);
      $("#saveSuspectOfficerAdditionModal").modal('show');
    },
    error: function(xhr, status, error) {
      $('#success-application').html("AJAX request failed: " + error);
      $("#saveSuspectOfficerAdditionModal").modal('show');
    }
  });
}

$(document).ready(function() {
	  $("#msDetails").validate({
	    rules: {
	      kiblerLateralSlideRight: { required: true },
	      kiblerLateralSlideLeft: { required: true },
	      rectusFemorisLengthRight: { required: true },
	      rectusFemorisLengthLeft: { required: true },
	      hipFlexionRomRight: { required: true },
	      hipFlexionRomLeft: { required: true }
	    },
	    messages: {
	    	  kiblerLateralSlideRight: { 
	    	    required: "<%= LanguageUtil.get(request, "enter-right-side-value") %>" 
	    	  },
	    	  kiblerLateralSlideLeft: { 
	    	    required: "<%= LanguageUtil.get(request, "enter-left-side-value") %>" 
	    	  },
	    	  rectusFemorisLengthRight: { 
	    	    required: "<%= LanguageUtil.get(request, "enter-right-side-value") %>" 
	    	  },
	    	  rectusFemorisLengthLeft: { 
	    	    required: "<%= LanguageUtil.get(request, "enter-left-side-value") %>" 
	    	  },
	    	  hipFlexionRomRight: { 
	    	    required: "<%= LanguageUtil.get(request, "enter-right-side-value") %>" 
	    	  },
	    	  hipFlexionRomLeft: { 
	    	    required: "<%= LanguageUtil.get(request, "enter-left-side-value") %>" 
	    	  }
	    	},

	    errorElement: "span",
	    errorClass: "text-danger"
	  });
	});


</script>
