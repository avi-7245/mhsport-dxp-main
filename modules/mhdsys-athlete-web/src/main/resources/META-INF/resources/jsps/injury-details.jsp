<%@page import="com.liferay.portal.kernel.language.LanguageUtil"%>
<%@ include file="/init.jsp" %>

<portlet:resourceURL id="injuryDetailsResourceCommand" var="suspensionRemarksEntry" />

<!-- Injury Section -->
<div class="common-forms-div">
  <div class="container">
    <div class="row">
      <div class="col-md-12">
        <div class="border-0 card shadow">
          <div class="align-items-center back-btn-cn card-header d-flex justify-content-between">
            <h5><liferay-ui:message key="injury-details" /></h5>
            <div>
              <a href="/group/guest/athelet-details" class="btn btn-primary btn-sm rounded-pill back-btn-cn">
                <i class="bi bi-arrow-left-circle mr-1"></i>
                <liferay-ui:message key="back" />
              </a>
            </div>
          </div>

          <form action="addInjury" method="post" id="addInjury" autocomplete="off">
            <div class="card-body">
              <div class="card card-background p-0">
                <div class="card-header"><liferay-ui:message key="injury" /></div>
                <div class="card-body">
                  
                  <!-- Row 1 -->
                  <div class="row mb-3">
                    <div class="col-md-4">
                      <div class="form-group">
                        <label><liferay-ui:message key="event" /></label>
                        <input type="text" name="event" class="form-control" id="event">
                      </div>
                    </div>
                    <div class="col-md-4">
                      <div class="form-group">
                        <label><liferay-ui:message key="training-age" /></label>
                        <input type="text" name="trainingAge" class="form-control" id="trainingAge">
                      </div>
                    </div>
                    <div class="col-md-4">
                      <div class="form-group">
                        <label><liferay-ui:message key="injury" /></label>
                        <input type="text" name="injury" class="form-control" id="injury">
                      </div>
                    </div>
                  </div>

                  <!-- Row 2 -->
                  <div class="row mb-3">
                    <div class="col-md-4">
                      <div class="form-group">
                        <label><liferay-ui:message key="history-current-injury" /></label>
                        <input type="text" name="historyOfCurrentInjury" class="form-control" id="historyOfCurrentInjury">
                      </div>
                    </div>
                    <div class="col-md-4">
                      <div class="form-group">
                        <label><liferay-ui:message key="mechanism-of-injury" /></label>
                        <input type="text" name="mechanismOfInjury" class="form-control" id="mechanismOfInjury">
                      </div>
                    </div>
                    <div class="col-md-4">
                      <div class="form-group">
                        <label><liferay-ui:message key="area-of-injury" /></label>
                        <input type="text" name="areaOfInjury" class="form-control" id="areaOfInjury">
                      </div>
                    </div>
                  </div>

                  <!-- Row 3 -->
                  <div class="row mb-3">
                    <div class="col-md-4">
                      <div class="form-group">
                        <label><liferay-ui:message key="affected-part" /></label>
                        <input type="text" name="affectedPart" class="form-control" id="affectedPart">
                      </div>
                    </div>
                    <div class="col-md-4">
                      <div class="form-group">
                        <label><liferay-ui:message key="on-observation" /></label>
                        <input type="text" name="onObservation" class="form-control" id="onObservation">
                      </div>
                    </div>
                    <div class="col-md-4">
                      <div class="form-group">
                        <label><liferay-ui:message key="odema" /></label>
                        <input type="text" name="odema" class="form-control" id="odema">
                      </div>
                    </div>
                  </div>

                  <!-- Row 4 -->
                  <div class="row mb-3">
                    <div class="col-md-4">
                      <div class="form-group">
                        <label><liferay-ui:message key="pitting-non-pitting" /></label>
                        <input type="text" name="pittingType" class="form-control" id="pittingType">
                      </div>
                    </div>
                    <div class="col-md-4">
                      <div class="form-group">
                        <label><liferay-ui:message key="redness" /></label>
                        <input type="text" name="redness" class="form-control" id="redness">
                      </div>
                    </div>
                    <div class="col-md-4">
                      <div class="form-group">
                        <label><liferay-ui:message key="on-palpation" /></label>
                        <input type="text" name="onPalpation" class="form-control" id="onPalpation">
                      </div>
                    </div>
                  </div>

                  <!-- Row 5 -->
                  <div class="row mb-3">
                    <div class="col-md-4">
                      <div class="form-group">
                        <label><liferay-ui:message key="tenderness" /></label>
                        <input type="text" name="tenderness" class="form-control" id="tenderness">
                      </div>
                    </div>
                    <div class="col-md-4">
                      <div class="form-group">
                        <label><liferay-ui:message key="stiffness" /></label>
                        <input type="text" name="stiffness" class="form-control" id="stiffness">
                      </div>
                    </div>
                    <div class="col-md-4">
                      <div class="form-group">
                        <label><liferay-ui:message key="pain" /></label>
                        <input type="text" name="pain" class="form-control" id="pain">
                      </div>
                    </div>
                  </div>

                  <!-- Row 6 -->
                  <div class="row mb-3">
                    <div class="col-md-4">
                      <div class="form-group">
                        <label><liferay-ui:message key="vas-scale" /></label>
                        <input type="text" name="vasScale" class="form-control" id="vasScale">
                      </div>
                    </div>
                    <div class="col-md-4">
                      <div class="form-group">
                        <label><liferay-ui:message key="special-test" /></label>
                        <input type="text" name="specialTest" class="form-control" id="specialTest">
                      </div>
                    </div>
                    <div class="col-md-4">
                      <div class="form-group">
                        <label><liferay-ui:message key="treatment" /></label>
                        <input type="text" name="treatment" class="form-control" id="treatment">
                      </div>
                    </div>
                  </div>

                  <!-- Row 7 -->
                  <div class="row mb-4">
                    <div class="col-md-4">
                      <div class="form-group">
                        <label><liferay-ui:message key="exercises-name-video" /></label>
                        <input type="text" name="exerciseVideo" class="form-control" id="exerciseVideo">
                      </div>
                    </div>
                    <div class="col-md-4">
                      <div class="form-group">
                        <label><liferay-ui:message key="machine-work" /></label>
                        <input type="text" name="machineWork" class="form-control" id="machineWork">
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

<!-- Modal popup -->
<div class="modal fade" id="saveSuspectOfficerAdditionModal" tabindex="-1" role="dialog"
  aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content modal-bg">
      <div class="modal-header justify-content-center align-items-center">
        <h5 class="modal-title" id="exampleModalLongTitle"><liferay-ui:message key="injury-details" /></h5>
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
        <button type="button" class="btn btn-secondary maha-save-btn" data-bs-dismiss="modal" onclick="location.reload();"><liferay-ui:message key="close" /></button>
      </div>
    </div>
  </div>
</div>

<!-- AJAX Script -->
<script type="text/javascript">
  function suspensionRemarkEntry(event) {
	    if (!$("#addInjury").valid()) {
	        return; 
	    }
    debugger;
    var form = $("#addInjury")[0];
    var formData = new FormData(form);
    formData.append("formName", "addInjury");
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
            msg = "<%= LanguageUtil.get(request, "injury-details-saved") %>";
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
  $(document).ready(function () {
	  $("#addInjury").validate({
	    rules: {
	      event: { required: true, minlength: 2, maxlength: 100 },
	      trainingAge: { required: true, digits: true, max: 80 },
	      injury: { required: true, minlength: 2, maxlength: 150 },
	      historyOfCurrentInjury: { required: true, minlength: 2 },
	      mechanismOfInjury: { required: true },
	      areaOfInjury: { required: true },
	      affectedPart: { required: true },
	      onObservation: { required: true },
	      odema: { required: true },
	      pittingType: { required: true },
	      redness: { required: true },
	      onPalpation: { required: true },
	      tenderness: { required: true },
	      stiffness: { required: true },
	      pain: { required: true },
	      vasScale: { required: true, number: true, min: 0, max: 10 },
	      specialTest: { required: true },
	      treatment: { required: true },
	      exerciseVideo: { required: true },
	      machineWork: { required: true }
	    },
	    messages: {
	    	  event: { 
	    	    required: "<%= LanguageUtil.get(request, "please-enter-event") %>", 
	    	    minlength: "<%= LanguageUtil.get(request, "minimum-2-characters") %>", 
	    	    maxlength: "<%= LanguageUtil.get(request, "maximum-100-characters") %>" 
	    	  },
	    	  trainingAge: { 
	    	    required: "<%= LanguageUtil.get(request, "please-enter-training-age") %>", 
	    	    digits: "<%= LanguageUtil.get(request, "numbers-only") %>", 
	    	    max: "<%= LanguageUtil.get(request, "maximum-80") %>" 
	    	  },
	    	  injury: { 
	    	    required: "<%= LanguageUtil.get(request, "please-enter-injury") %>", 
	    	    minlength: "<%= LanguageUtil.get(request, "minimum-2-characters") %>" 
	    	  },
	    	  historyOfCurrentInjury: { required: "<%= LanguageUtil.get(request, "please-enter-history-of-current-injury") %>" },
	    	  mechanismOfInjury: { required: "<%= LanguageUtil.get(request, "please-enter-mechanism-of-injury") %>" },
	    	  areaOfInjury: { required: "<%= LanguageUtil.get(request, "please-enter-area-of-injury") %>" },
	    	  affectedPart: { required: "<%= LanguageUtil.get(request, "please-enter-affected-part") %>" },
	    	  onObservation: { required: "<%= LanguageUtil.get(request, "please-enter-observation") %>" },
	    	  odema: { required: "<%= LanguageUtil.get(request, "please-enter-odema") %>" },
	    	  pittingType: { required: "<%= LanguageUtil.get(request, "please-enter-pitting-type") %>" },
	    	  redness: { required: "<%= LanguageUtil.get(request, "please-enter-redness") %>" },
	    	  onPalpation: { required: "<%= LanguageUtil.get(request, "please-enter-palpation") %>" },
	    	  tenderness: { required: "<%= LanguageUtil.get(request, "please-enter-tenderness") %>" },
	    	  stiffness: { required: "<%= LanguageUtil.get(request, "please-enter-stiffness") %>" },
	    	  pain: { required: "<%= LanguageUtil.get(request, "please-enter-pain") %>" },
	    	  vasScale: { 
	    	    required: "<%= LanguageUtil.get(request, "please-enter-vas-scale") %>", 
	    	    number: "<%= LanguageUtil.get(request, "numbers-only") %>", 
	    	    min: "<%= LanguageUtil.get(request, "min-0") %>", 
	    	    max: "<%= LanguageUtil.get(request, "max-10") %>" 
	    	  },
	    	  specialTest: { required: "<%= LanguageUtil.get(request, "please-enter-special-test") %>" },
	    	  treatment: { required: "<%= LanguageUtil.get(request, "please-enter-treatment") %>" },
	    	  exerciseVideo: { required: "<%= LanguageUtil.get(request, "please-enter-exercise-video") %>" },
	    	  machineWork: { required: "<%= LanguageUtil.get(request, "please-enter-machine-work") %>" }
	    	},

	    errorElement: "span",
	    errorClass: "text-danger"
	  });
	});

</script>
