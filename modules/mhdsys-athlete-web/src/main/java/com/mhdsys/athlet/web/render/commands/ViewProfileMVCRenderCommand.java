package com.mhdsys.athlet.web.render.commands;

import com.liferay.portal.kernel.bean.BeanPropertiesUtil;
import com.liferay.portal.kernel.log.Log;
import com.liferay.portal.kernel.log.LogFactoryUtil;
import com.liferay.portal.kernel.model.User;
import com.liferay.portal.kernel.portlet.bridges.mvc.MVCRenderCommand;
import com.liferay.portal.kernel.service.UserLocalServiceUtil;
import com.liferay.portal.kernel.theme.ThemeDisplay;
import com.liferay.portal.kernel.util.ParamUtil;
import com.liferay.portal.kernel.util.Validator;
import com.liferay.portal.kernel.util.WebKeys;
import com.mhdsys.athelet.web.com.constants.MhdsysAthleteWebPortletKeys;
import com.mhdsys.athelet.web.util.AtheletUtil;
import com.mhdsys.schema.model.AwardApplication;
import com.mhdsys.schema.model.MedicalRecord;
import com.mhdsys.schema.model.Profile;
import com.mhdsys.schema.model.SchoolCollegeOfficerRegistration;
import com.mhdsys.schema.service.AwardApplicationLocalServiceUtil;
import com.mhdsys.schema.service.MedicalRecordLocalServiceUtil;
import com.mhdsys.schema.service.ProfileLocalServiceUtil;
import com.mhdsys.schema.service.SchoolCollegeOfficerRegistrationLocalServiceUtil;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.portlet.PortletException;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;

import org.osgi.service.component.annotations.Component;

@Component(immediate = true, property = { "javax.portlet.name=" + MhdsysAthleteWebPortletKeys.MHDSYSATHLETEWEB,
		"mvc.command.name="
				+ MhdsysAthleteWebPortletKeys.VIEW_PROFILE_MVC_RENDER_COMMAND }, service = MVCRenderCommand.class)

public class ViewProfileMVCRenderCommand implements MVCRenderCommand {
	private Log LOGGER = LogFactoryUtil.getLog(ViewProfileMVCRenderCommand.class);

	@Override
	public String render(RenderRequest renderRequest, RenderResponse renderResponse) throws PortletException {
		ThemeDisplay themeDisplay = (ThemeDisplay) renderRequest.getAttribute(WebKeys.THEME_DISPLAY);

		long participantUserId = ParamUtil.getLong(renderRequest, "participantUserId");
		LOGGER.info("Rendering profile for participantUserId: " + participantUserId);

		User user = null;
		SchoolCollegeOfficerRegistration schoolCollege = null;
		String portraitURL = themeDisplay.getPathImage();
		AtheletUtil atheleteUtil = new AtheletUtil();

		long medals = 0;
		String performance = "";
		String highestMedal = "Participant";
		long totalCompetitions = 0;
		long gold = 0;
		long silver = 0;
		long bronze = 0;

		try {
			try {
				user = UserLocalServiceUtil.getUser(participantUserId);
				renderRequest.setAttribute("user", user);
				LOGGER.info("User found: " + (user != null ? user.getFullName() : "N/A"));
			} catch (Exception e) {
				LOGGER.error("Error fetching user for participantUserId: " + participantUserId, e);
			}

			try {
				schoolCollege = SchoolCollegeOfficerRegistrationLocalServiceUtil.findByUserId(participantUserId);
				renderRequest.setAttribute("schoolCollege", schoolCollege);
			} catch (Exception e) {
				LOGGER.warn("No School/College Officer Registration found for userId: " + participantUserId);
			}

			try {
				if (Validator.isNotNull(user)) {
					portraitURL = user.getPortraitURL(themeDisplay);
				}
				renderRequest.setAttribute("portraitURL", portraitURL);
			} catch (Exception e) {
				LOGGER.error("Error fetching portrait for userId: " + participantUserId, e);
			}

			try {
				if (Validator.isNotNull(schoolCollege)) {
					BeanPropertiesUtil.copyProperties(schoolCollege, atheleteUtil);
				}
			} catch (Exception e) {
				LOGGER.error("Error copying SchoolCollege properties to AtheletUtil", e);
			}

			try {
				if (Validator.isNotNull(user)) {
					MedicalRecord byUserId = MedicalRecordLocalServiceUtil.getByUserId(participantUserId);
					if (Validator.isNotNull(byUserId)) {
						renderRequest.setAttribute("medicalReports", byUserId);
					}
				}
			} catch (Exception e) {
				LOGGER.error("Error fetching medical record for userId: " + participantUserId, e);
			}

			List<AwardApplication> applications = new ArrayList<>();
			try {
				applications = AwardApplicationLocalServiceUtil.getAwardApplicationsByuserId(participantUserId);
			} catch (Exception e) {
				LOGGER.error("Error fetching award applications for userId: " + participantUserId, e);
			}

			for (AwardApplication awardApplication : applications) {
				String medal = awardApplication.getMedalRecieved();

				if (Validator.isNotNull(medal)) {
					switch (medal.trim().toLowerCase()) {
					case "gold":
						gold++;
						highestMedal = "Gold";
						break;
					case "silver":
						silver++;
						if (!highestMedal.equalsIgnoreCase("Gold")) {
							highestMedal = "Silver";
						}
						break;
					case "bronze":
						bronze++;
						if (!highestMedal.equalsIgnoreCase("Gold") && !highestMedal.equalsIgnoreCase("Silver")) {
							highestMedal = "Bronze";
						}
						break;
					default:
						break;
					}
				}

				medals++;
				totalCompetitions++;
				performance = awardApplication.getHighestPerformance();
			}

			LOGGER.info(String.format(
					"Medal Summary => Gold: %d | Silver: %d | Bronze: %d | Highest: %s | Total Competitions: %d", gold,
					silver, bronze, highestMedal, totalCompetitions));

		} catch (Exception e) {
			LOGGER.error("Unexpected error in render() for participantUserId: " + participantUserId, e);
		}

		renderRequest.setAttribute("medals", medals);
		renderRequest.setAttribute("performance", performance);
		renderRequest.setAttribute("highestMedal", highestMedal);
		renderRequest.setAttribute("totalCompetitions", totalCompetitions);
		renderRequest.setAttribute("gold", gold);
		renderRequest.setAttribute("silver", silver);
		renderRequest.setAttribute("bronze", bronze);
		renderRequest.setAttribute("portraitURL", portraitURL);
		renderRequest.setAttribute("schoolCollege", schoolCollege);
		renderRequest.setAttribute("atheleteUtil", atheleteUtil);

		try {
			Profile profile = ProfileLocalServiceUtil.findByUserId(participantUserId);
			if (profile != null && profile.getDateOfBirth() != null) {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				renderRequest.setAttribute("formattedDOB", sdf.format(profile.getDateOfBirth()));
			} else {
				renderRequest.setAttribute("formattedDOB", "");
			}
		} catch (Exception e) {
			LOGGER.error("Error fetching profile for userId: " + participantUserId, e);
			renderRequest.setAttribute("formattedDOB", "");
		}

		return "/jsps/view-profile.jsp";

	}

}
