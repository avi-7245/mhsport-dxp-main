package com.mhdsys.athlete.certificate.web.portlet;

import com.liferay.portal.kernel.log.Log;
import com.liferay.portal.kernel.log.LogFactoryUtil;
import com.liferay.portal.kernel.model.User;
import com.liferay.portal.kernel.portlet.bridges.mvc.MVCPortlet;
import com.liferay.portal.kernel.service.UserLocalServiceUtil;
import com.liferay.portal.kernel.theme.ThemeDisplay;
import com.liferay.portal.kernel.util.WebKeys;
import com.mhdsys.athlete.certificate.web.constants.MhdsysAthleteCertificateIntegrationWebPortletKeys;
import com.mhdsys.common.utility.constants.RoleConstant;
import com.mhdsys.schema.model.Profile;
import com.mhdsys.schema.model.SchoolCollegeOfficerRegistration;
import com.mhdsys.schema.service.CompetitionLevelMasterLocalServiceUtil;
import com.mhdsys.schema.service.DistrictMasterLocalServiceUtil;
import com.mhdsys.schema.service.ProfileLocalServiceUtil;
import com.mhdsys.schema.service.SchoolCollegeOfficerRegistrationLocalServiceUtil;
import com.mhdsys.schema.service.SportsMasterLocalServiceUtil;

import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;

import javax.portlet.Portlet;
import javax.portlet.PortletException;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;

import org.osgi.service.component.annotations.Component;

@Component(property = { "com.liferay.portlet.display-category=MHDSYS.Athlete",
		"com.liferay.portlet.header-portlet-css=/css/main.css", "com.liferay.portlet.instanceable=true",
		"javax.portlet.display-name=MhdsysAthleteCertificateDetails", "javax.portlet.init-param.template-path=/",
		"javax.portlet.init-param.view-template=/athlete-details.jsp",
		"javax.portlet.name=" + MhdsysAthleteCertificateIntegrationWebPortletKeys.MHDSYSATHLETECERTIFICATEDETAILSWEB,
		"javax.portlet.resource-bundle=content.Language", "com.liferay.portlet.requires-namespaced-parameters=false",
		"javax.portlet.security-role-ref=power-user,user" }, service = Portlet.class)

public class MhdsysAthleteCertificateDetailsPortlet extends MVCPortlet {

	private Log LOGGER = LogFactoryUtil.getLog(MhdsysAthleteCertificateDetailsPortlet.class);

	private static DateFormat DATE_FORMAT = new SimpleDateFormat("dd/MM/yyyy");

	@Override
	public void render(RenderRequest renderRequest, RenderResponse renderResponse)
			throws IOException, PortletException {
		LOGGER.info("Athlete Details Portlet");

		ThemeDisplay themeDisplay = (ThemeDisplay) renderRequest.getAttribute(WebKeys.THEME_DISPLAY);
		User user = UserLocalServiceUtil.fetchUser(themeDisplay.getUserId());

		String sportsPersonName = "";
		String guardianName = "";
		String dateOfBirth = "";
		String gender = "";

		try {
			SchoolCollegeOfficerRegistration registration = SchoolCollegeOfficerRegistrationLocalServiceUtil
					.findByUserId(user.getUserId());

			if (registration != null) {
				sportsPersonName = registration.getFirstName() + " " + registration.getLastName();
				guardianName = registration.getFathersName();
				gender = registration.getGender() == 1 ? "Male" : "Female";
			}

		} catch (Exception e) {
			LOGGER.warn("SchoolCollegeOfficerRegistration not found for userId: " + user.getUserId(), e);
		}

		try {
			Profile profile = ProfileLocalServiceUtil.findByUserId(user.getUserId());

			if (profile != null && profile.getDateOfBirth() != null) {
				dateOfBirth = DATE_FORMAT.format(profile.getDateOfBirth());
			}

		} catch (Exception e) {
			LOGGER.warn("Profile not found for userId: " + user.getUserId(), e);
		}

		renderRequest.setAttribute("sportsPersonName", sportsPersonName);
		renderRequest.setAttribute("guardianName", guardianName);
		renderRequest.setAttribute("dateOfBirth", dateOfBirth);
		renderRequest.setAttribute("gender", gender);

		renderRequest.setAttribute("districts", DistrictMasterLocalServiceUtil.getDistrictMasters(-1, -1));

		renderRequest.setAttribute("sports", SportsMasterLocalServiceUtil.getSportsMasters(-1, -1));

		renderRequest.setAttribute("compLevels",
				CompetitionLevelMasterLocalServiceUtil.getCompetitionLevelMasters(-1, -1));

		renderRequest.setAttribute("isSportsPerson", RoleConstant.isSportsPerson(user, themeDisplay.getCompanyId()));

		super.render(renderRequest, renderResponse);
	}

}
