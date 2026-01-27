<%@page import="com.liferay.portal.kernel.language.LanguageUtil"%>
<%@ include file="/init.jsp" %>
  <portlet:resourceURL id="injuryDetailsResourceCommand" var="suspensionRemarksEntry" />


  
  <!-- history -->
  <div class="common-forms-div">
    <div class="container">
      <div class="row">
        <div class="col-md-12">
          <div class="border-0 card shadow">
            <div class="align-items-center back-btn-cn card-header d-flex justify-content-between">
              <h5><liferay-ui:message key="history" /></h5>
              <div>
                <a href="/group/guest/athelet-details" class="btn btn-primary btn-sm rounded-pill back-btn-cn"> <i
                    class="bi bi-arrow-left-circle mr-1"></i> <liferay-ui:message key="back" /> </a>
              </div>
            </div>

            <form action="historyDetails" method="post" id="historyDetails" autocomplete="off"> 
              <div class="card-body">
                <div class="card card-background p-0">
                  <div class="card-header"><liferay-ui:message key="history" /></div>
                  <div class="card-body">
                    <div class="row">
                      <div class="col-md-6">
                        <div class="form-group">
                          <label><liferay-ui:message key="ho-any-recent-injuries" /></label>
                          <input type="text" class="form-control" name="recentInjuries" id="recentInjuries">
                        </div>
                      </div>
                      <div class="col-md-6">
                        <div class="form-group">
                          <label><liferay-ui:message key="ho-any-comorbidities" /></label>
                          <input type="text" class="form-control" name="comorbidities" id="comorbidities">
                        </div>
                      </div>
                    </div>
                    <div class="row">
                      <div class="col-md-6">
                        <div class="form-group">
                          <label><liferay-ui:message key="ho-any-surgeries" /></label>
                          <input type="text" class="form-control" name="surgeries" id="surgeries">
                        </div>
                      </div>
                      <div class="col-md-6">
                        <div class="form-group">
                          <label><liferay-ui:message key="any-medications" /></label>
                          <input type="text" class="form-control" name="medications" id="medications">
                        </div>
                      </div>
                    </div>
                    <div class="row">
                      <div class="col-md-6">
                        <div class="form-group">
                          <label><liferay-ui:message key="family-history" /></label>
                          <input type="text" class="form-control" name="familyHistory" id="familyHistory">
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
                      <button type="submit" class="btn btn-primary"
                        onclick="suspensionRemarkEntry(event)"><liferay-ui:message key="submit" /></button>
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
          <h5 class="modal-title" id="exampleModalLongTitle"><liferay-ui:message key="history-details" /></h5>
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
          <button type="button" class="btn btn-secondary maha-save-btn" data-bs-dismiss="modal"
            onclick="location.reload();"><liferay-ui:message key="close" /></button>

        </div>
      </div>
    </div>
  </div>


  <!-- modal popup for establishment -->
  <script type="text/javascript">
    function suspensionRemarkEntry(event) {
      debugger;

      var form = $("#historyDetails")[0];
      var formData = new FormData(form);
      formData.append("formName", "historyDetails");
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

          const messages = {
              success: "<%= LanguageUtil.get(request, "history-details-saved") %>",
              error: "<%= LanguageUtil.get(request, "failed-to-save-record") %>",
              unknown: "<%= LanguageUtil.get(request, "unknown-response-from-server") %>"
          };

          if (data.status === "success") {
              msg = messages.success;
          } else if (data.status === "error") {
              msg = messages.error;
          } else {
              msg = messages.unknown;
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

    $(document).ready(function () {

    	  $.validator.addMethod("noStartEndSpecialChar", function (value, element) {
    	    return this.optional(element) || /^[^-_/\\.,!@#$%^&*()+=\s].*[^-_/\\.,!@#$%^&*()\s]$/.test(value);
    	  });

    	  $.validator.addMethod("startEndSpace", function (value, element) {
    	    return this.optional(element) || !/^\s|\s$/.test(value);
    	  });

    	  $.validator.addMethod("singleSpaceBetweenWords", function (value, element) {
    	    return this.optional(element) || !/ {2,}/.test(value);
    	  });

    	  $.validator.addMethod("noSpaceAroundDashSlash", function (value, element) {
    	    return this.optional(element) || !/(\s[-/])|([-/]\s)/.test(value);
    	  });

    	  $.validator.addMethod("noConsecutiveSpecialChars", function (value, element) {
    	    return this.optional(element) || !/[-_/\\.,!@#$%^&*()+=]{2,}/.test(value);
    	  });

    	  $.validator.addMethod("generalFieldsValidation", function (value, element) {
    	    return this.optional(element) || /^[A-Za-z0-9\s,.\-_/()]+$/.test(value);
    	  });

    	  $("#historyDetails").validate({
    	    ignore: [],
    	    rules: {
    	      recentInjuries: {
    	        required: true,
    	        noStartEndSpecialChar: true,
    	        startEndSpace: true,
    	        minlength: 3,
    	        singleSpaceBetweenWords: true,
    	        noSpaceAroundDashSlash: true,
    	        noConsecutiveSpecialChars: true,
    	        generalFieldsValidation: true,
    	        maxlength: 75
    	      },
    	      comorbidities: {
    	        required: true,
    	        noStartEndSpecialChar: true,
    	        startEndSpace: true,
    	        minlength: 3,
    	        singleSpaceBetweenWords: true,
    	        noSpaceAroundDashSlash: true,
    	        noConsecutiveSpecialChars: true,
    	        generalFieldsValidation: true,
    	        maxlength: 75
    	      },
    	      surgeries: {
    	        required: true,
    	        noStartEndSpecialChar: true,
    	        startEndSpace: true,
    	        minlength: 3,
    	        singleSpaceBetweenWords: true,
    	        noSpaceAroundDashSlash: true,
    	        noConsecutiveSpecialChars: true,
    	        generalFieldsValidation: true,
    	        maxlength: 75
    	      },
    	      medications: {
    	        required: true,
    	        noStartEndSpecialChar: true,
    	        startEndSpace: true,
    	        minlength: 3,
    	        singleSpaceBetweenWords: true,
    	        noSpaceAroundDashSlash: true,
    	        noConsecutiveSpecialChars: true,
    	        generalFieldsValidation: true,
    	        maxlength: 75
    	      },
    	      familyHistory: {
    	        required: true,
    	        noStartEndSpecialChar: true,
    	        startEndSpace: true,
    	        minlength: 3,
    	        singleSpaceBetweenWords: true,
    	        noSpaceAroundDashSlash: true,
    	        noConsecutiveSpecialChars: true,
    	        generalFieldsValidation: true,
    	        maxlength: 75
    	      }
    	    },
    	    messages: {
    	      recentInjuries: {
    	        required: "<liferay-ui:message key='please-enter-recent-injuries' />",
    	        minlength: "<liferay-ui:message key='minimum-3-characters-required' />",
    	        maxlength: "<liferay-ui:message key='maximum-75-characters-allowed' />"
    	      },
    	      comorbidities: {
    	        required: "<liferay-ui:message key='please-enter-comorbidities' />",
    	        minlength: "<liferay-ui:message key='minimum-3-characters-required' />",
    	        maxlength: "<liferay-ui:message key='maximum-75-characters-allowed' />"
    	      },
    	      surgeries: {
    	        required: "<liferay-ui:message key='please-enter-surgeries' />",
    	        minlength: "<liferay-ui:message key='minimum-3-characters-required' />",
    	        maxlength: "<liferay-ui:message key='maximum-75-characters-allowed' />"
    	      },
    	      medications: {
    	        required: "<liferay-ui:message key='please-enter-medications' />",
    	        minlength: "<liferay-ui:message key='minimum-3-characters-required' />",
    	        maxlength: "<liferay-ui:message key='maximum-75-characters-allowed' />"
    	      },
    	      familyHistory: {
    	        required: "<liferay-ui:message key='please-enter-family-history' />",
    	        minlength: "<liferay-ui:message key='minimum-3-characters-required' />",
    	        maxlength: "<liferay-ui:message key='maximum-75-characters-allowed' />"
    	      }
    	    },
    	    errorClass: "text-danger",
    	    errorPlacement: function (error, element) {
    	      error.insertAfter(element);
    	    },
    	    highlight: function (element) {
    	      $(element).addClass("is-invalid");
    	    },
    	    unhighlight: function (element) {
    	      $(element).removeClass("is-invalid");
    	    },
    	    submitHandler: function (form, event) {
    	      event.preventDefault();
    	      suspensionRemarkEntry(event);
    	    }
    	  });

    	  $("button[type='submit']").removeAttr("onclick");

    	});

  </script>
