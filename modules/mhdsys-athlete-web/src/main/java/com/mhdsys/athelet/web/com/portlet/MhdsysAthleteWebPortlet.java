package com.mhdsys.athelet.web.com.portlet;

import com.liferay.portal.kernel.log.Log;
import com.liferay.portal.kernel.log.LogFactoryUtil;
import com.liferay.portal.kernel.model.User;
import com.liferay.portal.kernel.portlet.bridges.mvc.MVCPortlet;
import com.liferay.portal.kernel.theme.ThemeDisplay;
import com.liferay.portal.kernel.util.WebKeys;
import com.mhdsys.athelet.web.com.constants.MhdsysAthleteWebPortletKeys;
import com.mhdsys.common.utility.constants.RoleConstant;
import com.mhdsys.schema.model.SchoolCollegeOfficerRegistration;
import com.mhdsys.schema.service.SchoolCollegeOfficerRegistrationLocalServiceUtil;

import java.io.IOException;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

import javax.portlet.Portlet;
import javax.portlet.PortletException;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;

import org.osgi.service.component.annotations.Component;

/**
 * @author DELL
 */
@Component(property = { "com.liferay.portlet.display-category=category.sample",
		"com.liferay.portlet.header-portlet-css=/css/main.css", "com.liferay.portlet.instanceable=true",
		"javax.portlet.display-name=MhdsysAthleteWeb", "javax.portlet.init-param.template-path=/",
		"javax.portlet.init-param.view-template=/jsps/athelet-list.jsp",
		"com.liferay.portlet.requires-namespaced-parameters=false",
		"javax.portlet.name=" + MhdsysAthleteWebPortletKeys.MHDSYSATHLETEWEB,
		"javax.portlet.resource-bundle=content.Language",
		"com.liferay.portlet.header-portal-javascript=/o/mhdsys-dashboard-theme/js/plugins/jquery.min.js",
		"com.liferay.portlet.header-portal-javascript=/o/mhdsys-dashboard-theme/js/plugins/bootstrap.bundle.min.js",
		"com.liferay.portlet.header-portal-javascript=/o/mhdsys-dashboard-theme/js/plugins/jquery.validate.js",
		"com.liferay.portlet.header-portal-javascript=/o/mhdsys-dashboard-theme/js/plugins/additional-methods.js",
		"javax.portlet.security-role-ref=power-user,user" }, service = Portlet.class)
public class MhdsysAthleteWebPortlet extends MVCPortlet {

	private static final Log LOGGER = LogFactoryUtil.getLog(MhdsysAthleteWebPortlet.class);

	@Override
	public void render(RenderRequest renderRequest, RenderResponse renderResponse)
			throws IOException, PortletException {

		LOGGER.info("### Athlete List Portlet ###");

		try {
			ThemeDisplay themeDisplay = (ThemeDisplay) renderRequest.getAttribute(WebKeys.THEME_DISPLAY);
			User user = themeDisplay.getUser();

			boolean isHoAdmin = RoleConstant.isHOAdmin(user, themeDisplay.getCompanyId());
			boolean isDeskOfficer = RoleConstant.isDeskOfficer(user, themeDisplay.getCompanyId());

			if (isHoAdmin || isDeskOfficer) {
				List<SchoolCollegeOfficerRegistration> collegeOfficerRegistrations = SchoolCollegeOfficerRegistrationLocalServiceUtil
						.getSchoolCollegeOfficerRegistrations(-1, -1);

				LOGGER.info("Total Officer Registrations: " + collegeOfficerRegistrations.size());

				List<SchoolCollegeOfficerRegistration> filteredList = collegeOfficerRegistrations.stream()
						.filter(officer -> officer.getCurrentDesignation() == 1).collect(Collectors.toList());

				LOGGER.info("Filtered Athlete List Size: " + filteredList.size());

				renderRequest.setAttribute("atheletList", filteredList);

			} else {
				SchoolCollegeOfficerRegistration officerRegistration = SchoolCollegeOfficerRegistrationLocalServiceUtil
						.findByUserId(user.getUserId());

				renderRequest.setAttribute("atheletList", officerRegistration);

				renderRequest.setAttribute("atheletList", Collections.singletonList(officerRegistration));
			}

		} catch (Exception e) {
			LOGGER.error("Error in render method: ", e);
		}

		super.render(renderRequest, renderResponse);
	}

}