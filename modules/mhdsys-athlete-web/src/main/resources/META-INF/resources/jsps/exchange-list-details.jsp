<%@page import="com.liferay.portal.kernel.language.LanguageUtil"%>
<%@ include file="/init.jsp" %>
<portlet:resourceURL id="injuryDetailsResourceCommand" var="suspensionRemarksEntry" />

<!-- exchange-list -->
<div class="common-forms-div">
  <div class="container">
    <div class="row">
      <div class="col-md-12">
        <div class="border-0 card shadow">
          <div class="align-items-center back-btn-cn card-header d-flex justify-content-between">
            <h5><liferay-ui:message key="exchange-list" /></h5>
            <div>
              <a href="/group/guest/athelet-details" class="btn btn-primary btn-sm rounded-pill back-btn-cn">
                <i class="bi bi-arrow-left-circle mr-1"></i>
                <liferay-ui:message key="back" />
              </a>
            </div>
          </div>

          <form action="exchangeDetails" method="post" id="exchangeDetails">
            <div class="card-body">
              <div class="card card-background p-0">
                <div class="card-header"><liferay-ui:message key="exchange-details" /></div>
                <div class="card-body">
                  
                  <div class="row">
                    <div class="col-md-6">
                      <div class="form-group">
                        <label><liferay-ui:message key="ho-any-recent-injuries" /></label>
                        <input type="text" class="form-control" name="exchangeRecentInjuries" id="exchangeRecentInjuries">
                      </div>
                    </div>

                    <div class="col-md-6">
                      <div class="form-group">
                        <label><liferay-ui:message key="ho-any-comorbidities" /></label>
                        <input type="text" class="form-control" name="exchangeComorbidities" id="exchangeComorbidities">
                      </div>
                    </div>
                  </div>

                  <div class="row">
                    <div class="col-md-6">
                      <div class="form-group">
                        <label><liferay-ui:message key="ho-any-surgeries" /></label>
                        <input type="text" class="form-control" name="exchangeSurgeries" id="exchangeSurgeries">
                      </div>
                    </div>

                    <div class="col-md-6">
                      <div class="form-group">
                        <label><liferay-ui:message key="any-medications" /></label>
                        <input type="text" class="form-control" name="exchangeMedications" id="exchangeMedications">
                      </div>
                    </div>
                  </div>

                  <div class="row">
                    <div class="col-md-6">
                      <div class="form-group">
                        <label><liferay-ui:message key="family-history" /></label>
                        <input type="text" class="form-control" name="exchangeFamilyHistory" id="exchangeFamilyHistory">
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

<!-- modal popup for establishment -->
<div class="modal fade" id="saveSuspectOfficerAdditionModal" tabindex="-1" role="dialog"
  aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content modal-bg">
      <div class="modal-header justify-content-center align-items-center">
        <h5 class="modal-title" id="exampleModalLongTitle"><liferay-ui:message key="exchange-details" /><liferay-ui:message key="close" /></h5>
        <button type="button" class="close d-none" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <div class="row">
          <div class="col-md-12 text-center">
            <div>
              <p id="success-application"></p>
            </div>
          </div>
        </div>
      </div>
      <div class="modal-footer d-flex justify-content-end">
        <button type="button" class="btn btn-secondary maha-save-btn" data-bs-dismiss="modal" onclick="location.reload();">Close</button>
      </div>
    </div>
  </div>
</div>

<!-- AJAX script -->
<script>
  function suspensionRemarkEntry(event) {
    debugger;
    if (!$("#exchangeDetails").valid()) {
      return false; 
    }
    
    var form = $("#exchangeDetails")[0];
    var formData = new FormData(form);
    formData.append("formName", "exchangeDetails");
    if (event) event.preventDefault();

    $.ajax({
      type: "POST",
      url: '${suspensionRemarksEntry}',
      data: formData,
      contentType: false,
      cache: false,
      processData: false,
      success: function (data) {
        if (!data) {
          $('#success-application').html("Empty response from server.");
          $("#saveSuspectOfficerAdditionModal").modal('show');
          return;
        }

        if (typeof data === 'string') {
          data = JSON.parse(data);
        }

        let msg = "";

        if (data.status === "success") {
            msg = "<%= LanguageUtil.get(request, "exchange-record-saved") %>";
        } else if (data.status === "error") {
            msg = "<%= LanguageUtil.get(request, "failed-to-save-record") %>";
        } else {
            msg = "<%= LanguageUtil.get(request, "unknown-response-from-server") %>";
        }

        $('#success-application').html(msg);
        $("#saveSuspectOfficerAdditionModal").modal('show');
      },
      error: function (xhr, status, error) {
        $('#success-application').html("AJAX request failed: " + error);
        $("#saveSuspectOfficerAdditionModal").modal('show');
      }
    });
  }
  $(document).ready(function() {
	  // Custom rule to allow only letters and spaces
	  $.validator.addMethod("lettersOnly", function(value, element) {
	    return this.optional(element) || /^[a-zA-Z\s]+$/.test(value);
	  }, "Only letters and spaces are allowed");

	  $("#exchangeDetails").validate({
	    rules: {
	      exchangeRecentInjuries: { required: true, lettersOnly: true },
	      exchangeComorbidities: { required: true, lettersOnly: true },
	      exchangeSurgeries: { required: true, lettersOnly: true },
	      exchangeMedications: { required: true, lettersOnly: true },
	      exchangeFamilyHistory: { required: true, lettersOnly: true }
	    },
	    messages: {
	    	  exchangeRecentInjuries: { 
	    	    required: "<%= LanguageUtil.get(request, "please-enter-recent-injuries") %>", 
	    	    lettersOnly: "<%= LanguageUtil.get(request, "only-letters-allowed") %>" 
	    	  },
	    	  exchangeComorbidities: { 
	    	    required: "<%= LanguageUtil.get(request, "please-enter-comorbidities") %>", 
	    	    lettersOnly: "<%= LanguageUtil.get(request, "only-letters-allowed") %>" 
	    	  },
	    	  exchangeSurgeries: { 
	    	    required: "<%= LanguageUtil.get(request, "please-enter-surgeries") %>", 
	    	    lettersOnly: "<%= LanguageUtil.get(request, "only-letters-allowed") %>" 
	    	  },
	    	  exchangeMedications: { 
	    	    required: "<%= LanguageUtil.get(request, "please-enter-medications") %>", 
	    	    lettersOnly: "<%= LanguageUtil.get(request, "only-letters-allowed") %>" 
	    	  },
	    	  exchangeFamilyHistory: { 
	    	    required: "<%= LanguageUtil.get(request, "please-enter-family-history") %>", 
	    	    lettersOnly: "<%= LanguageUtil.get(request, "only-letters-allowed") %>" 
	    	  }
	    	},

	    errorElement: "span",
	    errorClass: "text-danger"
	  });
	});
</script>
