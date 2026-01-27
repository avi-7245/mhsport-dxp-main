package com.mhdsys.competition.management.resource.commands;

import com.liferay.portal.kernel.json.JSONFactoryUtil;
import com.liferay.portal.kernel.json.JSONObject;
import com.liferay.portal.kernel.log.Log;
import com.liferay.portal.kernel.log.LogFactoryUtil;
import com.liferay.portal.kernel.portlet.bridges.mvc.MVCResourceCommand;
import com.liferay.portal.kernel.service.ServiceContext;
import com.liferay.portal.kernel.service.ServiceContextFactory;
import com.liferay.portal.kernel.upload.UploadPortletRequest;
import com.liferay.portal.kernel.util.ParamUtil;
import com.liferay.portal.kernel.util.PortalUtil;
import com.mhdsys.competition.management.web.constants.CompetitionManagementWebPortletKeys;
import com.mhdsys.schema.model.SchoolChange;
import com.mhdsys.schema.service.SchoolChangeLocalServiceUtil;

import javax.portlet.ResourceRequest;
import javax.portlet.ResourceResponse;

import org.osgi.service.component.annotations.Component;

@Component(immediate = true, property = {
		"javax.portlet.name=" + CompetitionManagementWebPortletKeys.MHDSYS_COMPETITION_INITIATION_LIST_MANAGEMENTWEB,

		"javax.portlet.name=" + CompetitionManagementWebPortletKeys.MHDSYS_SCHOOL_CHANGE_MANAGEMENTWEB,
		"javax.portlet.name=" + CompetitionManagementWebPortletKeys.MHDSYS_SCHOOL_CHANGE_LIST_MANAGEMENTWEB,

		"javax.portlet.name="
				+ CompetitionManagementWebPortletKeys.MHDSYS_COMPETITION_PT_TEACHER_REQUEST_LIST_MANAGEMENTWEB,
		"javax.portlet.name=" + CompetitionManagementWebPortletKeys.MHDSYS_COMPETITION_SCHEDULED_LIST_MANAGEMENTWEB,
		"javax.portlet.name=" + CompetitionManagementWebPortletKeys.MHDSYS_UPLOADED_RESULT_LIST_MANAGEMENTWEB,

		"mvc.command.name="
				+ CompetitionManagementWebPortletKeys.SAVE_SCHOOL_CHANGE_MVC_RESOURCE_COMMAND }, service = MVCResourceCommand.class)

public class SaveSchoolChangeApplicationMVCResourceCommand implements MVCResourceCommand {

	private static final Log _log = LogFactoryUtil.getLog(SaveSchoolChangeApplicationMVCResourceCommand.class);

	@Override
	public boolean serveResource(ResourceRequest resourceRequest, ResourceResponse resourceResponse) {
		JSONObject jsonResponse = JSONFactoryUtil.createJSONObject();

		try {
			UploadPortletRequest uploadRequest = PortalUtil.getUploadPortletRequest(resourceRequest);
			ServiceContext serviceContext = ServiceContextFactory.getInstance(SchoolChange.class.getName(),
					resourceRequest);

			long schoolChangeId = ParamUtil.getLong(uploadRequest, "schoolChangeId");
			String participantName = ParamUtil.getString(uploadRequest, "name");
			String standard = ParamUtil.getString(uploadRequest, "standard");
			String fromSchool = ParamUtil.getString(uploadRequest, "fromSchool");
			String toSchool = ParamUtil.getString(uploadRequest, "toSchool");
			String year = ParamUtil.getString(uploadRequest, "year");
			String mode = ParamUtil.getString(uploadRequest, "mode");

			_log.info("Received School Change Request:");
			_log.info(" - Participant Name: " + participantName);
			_log.info(" - Standard: " + standard);
			_log.info(" - From School: " + fromSchool);
			_log.info(" - To School: " + toSchool);
			_log.info(" - Year: " + year);
			_log.info(" - Mode: " + mode);
			_log.info(" - schoolChangeId: " + schoolChangeId);

			SchoolChange schoolChange;

			if (schoolChangeId > 0) {
				schoolChange = SchoolChangeLocalServiceUtil.fetchSchoolChange(schoolChangeId);

				if (schoolChange != null) {
					schoolChange.setParticipantName(schoolChange.getParticipantName());
					schoolChange.setStandard(schoolChange.getStandard());
					schoolChange.setFromSchool(schoolChange.getFromSchool());
					schoolChange.setToSchool(schoolChange.getToSchool());
					schoolChange.setYear(schoolChange.getYear());
					schoolChange.setModifiedDate(new java.util.Date());
					schoolChange.setApproval(ParamUtil.getString(uploadRequest, "approval"));

					schoolChange = SchoolChangeLocalServiceUtil.updateSchoolChange(schoolChange);
					_log.info("School Change details updated successfully.");
				}

			} else {
				schoolChange = addNewSchoolChange(participantName, standard, fromSchool, toSchool, year,
						serviceContext);
				_log.info("New School Change record created successfully.");
			}

			if (schoolChange != null) {
				jsonResponse.put("school", true);
				jsonResponse.put("message", "The details are saved successfully.");
				jsonResponse.put("schoolChangeId", schoolChange.getSchoolChangeId());
			} else {
				jsonResponse.put("school", false);
				jsonResponse.put("message", "Failed to save school change details.");
			}

		} catch (Exception e) {
			_log.error("Error while saving school change request: ", e);
			jsonResponse.put("school", false);
			jsonResponse.put("message", "Exception occurred while saving details: " + e.getMessage());
		}

		try {
			resourceResponse.setContentType("application/json");
			resourceResponse.getWriter().write(jsonResponse.toString());
		} catch (Exception e) {
			_log.error("Error writing JSON response: ", e);
		}

		return false;
	}

	private SchoolChange addNewSchoolChange(String participantName, String standard, String fromSchool, String toSchool,
			String year, ServiceContext serviceContext) {

		try {
			long schoolChangeId = com.liferay.counter.kernel.service.CounterLocalServiceUtil
					.increment(SchoolChange.class.getName());

			SchoolChange schoolChange = SchoolChangeLocalServiceUtil.createSchoolChange(schoolChangeId);

			schoolChange.setParticipantName(participantName);
			schoolChange.setStandard(standard);
			schoolChange.setFromSchool(fromSchool);
			schoolChange.setToSchool(toSchool);
			schoolChange.setYear(year);
			schoolChange.setCreateDate(serviceContext.getCreateDate(new java.util.Date()));
			schoolChange.setModifiedDate(serviceContext.getModifiedDate(new java.util.Date()));

			return SchoolChangeLocalServiceUtil.addSchoolChange(schoolChange);
		} catch (Exception e) {
			_log.error("Error while adding new school change record: ", e);
			return null;
		}
	}

}
