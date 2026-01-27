package com.mdsys.establishment.mvc.render.commands;

import com.liferay.portal.kernel.log.Log;
import com.liferay.portal.kernel.log.LogFactoryUtil;
import com.liferay.portal.kernel.portlet.bridges.mvc.MVCRenderCommand;
import com.liferay.portal.kernel.theme.ThemeDisplay;
import com.liferay.portal.kernel.util.ParamUtil;
import com.liferay.portal.kernel.util.WebKeys;
import com.mhdsys.establishment.util.EstablishmentUtil;
import com.mhdsys.schema.service.EstablishmentDetailsLocalServiceUtil;
import com.mhdsys.schema.service.GPFDetailsLocalServiceUtil;
import com.mhdsys.schema.service.NPSDetailsLocalServiceUtil;
import com.mhdsys.schema.service.PersonalDetailsLocalServiceUtil;
import com.mhdsys.schema.service.PostingStatusLocalServiceUtil;
import com.mhdsys.schema.service.RoasterStatusLocalServiceUtil;
import com.mhdsys.schema.service.ServiceDetailsLocalServiceUtil;
import com.mhdsys.schema.service.TrainingDetailsLocalServiceUtil;
import com.mhdys.establishment.constants.EstablishmentWebPortletKeys;

import javax.portlet.PortletException;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;

import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Reference;

@Component(immediate = true, property = { "javax.portlet.name=" + EstablishmentWebPortletKeys.MHDSYSESTABLISHMENTWEB,
		"javax.portlet.name=" + EstablishmentWebPortletKeys.MHDSYSESTABLISHMENTLISTWEB,
		"javax.portlet.name=" + EstablishmentWebPortletKeys.MHDSYSESTABLISHMENTDASHBOARDWEB, "mvc.command.name="
				+ EstablishmentWebPortletKeys.ESTABLISHMENT_MVC_RENDER_COMMAND }, service = MVCRenderCommand.class)
public class EstablishmentMVCRenderCommand implements MVCRenderCommand {
	private static Log LOGGER = LogFactoryUtil.getLog(EstablishmentMVCRenderCommand.class);

	@Reference
	EstablishmentUtil establishmentUtil;

	@Override
	public String render(RenderRequest renderRequest, RenderResponse renderResponse) throws PortletException {
		try {
			LOGGER.info("Render Method Started ::::: ");
			ThemeDisplay themeDisplay = (ThemeDisplay) renderRequest.getAttribute(WebKeys.THEME_DISPLAY);
			String cmd = ParamUtil.getString(renderRequest, "cmd");
			long userId = ParamUtil.getLong(renderRequest, "userId");

			LOGGER.info("CMD : " + cmd + " USER ID " + userId);

			renderRequest.setAttribute("mode", "add");
			renderRequest.setAttribute("establishmentDetails",
					EstablishmentDetailsLocalServiceUtil.findByUserId(userId));
			renderRequest.setAttribute("personalDetails", establishmentUtil
					.setPersonalDetailsDTO(PersonalDetailsLocalServiceUtil.findByUserId(userId), themeDisplay));
			renderRequest.setAttribute("serviceDetails", establishmentUtil
					.setServiceDetailsDTO(ServiceDetailsLocalServiceUtil.findByUserId(userId), themeDisplay));
			renderRequest.setAttribute("gpfDetails",
					establishmentUtil.setGPFDetailsDTO(GPFDetailsLocalServiceUtil.findByUserId(userId), themeDisplay));
			renderRequest.setAttribute("npsDetails",
					establishmentUtil.setNPSDetailsDTO(NPSDetailsLocalServiceUtil.findByUserId(userId), themeDisplay));
			renderRequest.setAttribute("trainingDetails", establishmentUtil
					.setTrainingDetailsDTO(TrainingDetailsLocalServiceUtil.findByUserId(userId), themeDisplay));
			renderRequest.setAttribute("postingStatus", PostingStatusLocalServiceUtil.findByUserId(userId));
			renderRequest.setAttribute("roasterDetails", RoasterStatusLocalServiceUtil.findByUserId(userId));

		} catch (Exception e) {
			LOGGER.error(e.getMessage(), e);
		}
		return EstablishmentWebPortletKeys.PERSONAL_DETAILS;
	}

}
