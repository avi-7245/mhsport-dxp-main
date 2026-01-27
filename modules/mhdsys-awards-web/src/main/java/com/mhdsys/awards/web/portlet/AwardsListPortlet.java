package com.mhdsys.awards.web.portlet;

import com.liferay.portal.kernel.log.Log;
import com.liferay.portal.kernel.log.LogFactoryUtil;
import com.liferay.portal.kernel.portlet.bridges.mvc.MVCPortlet;
import com.liferay.portal.kernel.theme.ThemeDisplay;
import com.liferay.portal.kernel.util.Validator;
import com.liferay.portal.kernel.util.WebKeys;
import com.mhdsys.awards.web.constants.AwardsWebPortletKeys;
import com.mhdsys.awards.web.util.AwardsUtil;
import com.mhdsys.common.pojo.AwardApplicationCommonDTO;
import com.mhdsys.common.util.RoleUtil;
import com.mhdsys.schema.model.AwardApplication;
import com.mhdsys.schema.service.AwardApplicationLocalServiceUtil;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.portlet.Portlet;
import javax.portlet.PortletException;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;

import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Reference;

@Component(property = { "com.liferay.portlet.display-category=MHDSYS.Awards",
		"com.liferay.portlet.header-portlet-css=/css/main.css", "com.liferay.portlet.instanceable=false",
		"javax.portlet.display-name=MhdsysAwardsListWeb", "javax.portlet.init-param.template-path=/",
		"javax.portlet.init-param.template-path=/", "com.liferay.portlet.requires-namespaced-parameters=false",

		"com.liferay.portlet.header-portal-javascript=/o/mhdsys-dashboard-theme/js/plugins/jquery.min.js",
		"com.liferay.portlet.header-portal-javascript=/o/mhdsys-dashboard-theme/js/plugins/bootstrap.bundle.min.js",
		"com.liferay.portlet.header-portal-javascript=/o/mhdsys-dashboard-theme/js/plugins/jquery.validate.js",
		"com.liferay.portlet.header-portal-javascript=/o/mhdsys-dashboard-theme/js/plugins/additional-methods.js",

		"javax.portlet.init-param.view-template=/awards-list.jsp",
		"javax.portlet.name=" + AwardsWebPortletKeys.MHDSYSAWARDSLISTWEB,
		"javax.portlet.resource-bundle=content.Language",
		"javax.portlet.security-role-ref=power-user,user" }, service = Portlet.class)

public class AwardsListPortlet extends MVCPortlet {

	private Log LOGGER = LogFactoryUtil.getLog(AwardsListPortlet.class);

	@Reference
	RoleUtil roleUtil;

	@Reference
	AwardsUtil awardsUtil;

	@Override
	public void render(RenderRequest renderRequest, RenderResponse renderResponse)
			throws IOException, PortletException {

		try {
			LOGGER.info("Awards Utility Page ::: Render");

			ThemeDisplay themeDisplay = (ThemeDisplay) renderRequest.getAttribute(WebKeys.THEME_DISPLAY);

			List<AwardApplication> applications = AwardApplicationLocalServiceUtil.getAwardApplications(-1, -1);

			List<AwardApplicationCommonDTO> dtos = new ArrayList<>();

			for (AwardApplication application : applications) {

				boolean hasCoach = Validator.isNotNull(application.getCoachName())
						&& !application.getCoachName().trim().isEmpty();

				boolean hasSportPerson = Validator.isNotNull(application.getSportpersonName())
						&& !application.getSportpersonName().trim().isEmpty();

				if (hasCoach || hasSportPerson) {

					AwardApplicationCommonDTO dto = awardsUtil.setAwardsApplicationsDTO(application, themeDisplay);

					dtos.add(dto);
				}
			}

			renderRequest.setAttribute("applicantList", dtos);

			super.render(renderRequest, renderResponse);

		} catch (Exception e) {
			LOGGER.error("Error in Awards Utility Page", e);
		}
	}

}
