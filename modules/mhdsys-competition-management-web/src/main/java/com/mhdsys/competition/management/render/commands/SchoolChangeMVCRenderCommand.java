package com.mhdsys.competition.management.render.commands;

import com.liferay.portal.kernel.log.Log;
import com.liferay.portal.kernel.log.LogFactoryUtil;
import com.liferay.portal.kernel.portlet.bridges.mvc.MVCRenderCommand;
import com.liferay.portal.kernel.util.ParamUtil;
import com.mhdsys.competition.management.web.constants.CompetitionCommonConstant;
import com.mhdsys.competition.management.web.constants.CompetitionManagementWebPortletKeys;
import com.mhdsys.schema.service.SchoolChangeLocalServiceUtil;

import javax.portlet.PortletException;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;

import org.osgi.service.component.annotations.Component;

@Component(immediate = true, property = {
		"javax.portlet.name=" + CompetitionManagementWebPortletKeys.MHDSYS_SCHOOL_CHANGE_MANAGEMENTWEB,
		"javax.portlet.name=" + CompetitionManagementWebPortletKeys.MHDSYS_SCHOOL_CHANGE_LIST_MANAGEMENTWEB,

		"javax.portlet.name=" + CompetitionManagementWebPortletKeys.MHDSYS_COMPETITION_INITIATION_LIST_MANAGEMENTWEB,
		"mvc.command.name="
				+ CompetitionManagementWebPortletKeys.SCHOOL_CHANGE_MVC_RENDER_COMMAND }, service = MVCRenderCommand.class)

public class SchoolChangeMVCRenderCommand implements MVCRenderCommand {
	private Log LOGGER = LogFactoryUtil.getLog(SchoolChangeMVCRenderCommand.class);

	@Override
	public String render(RenderRequest renderRequest, RenderResponse renderResponse) throws PortletException {

		try {

			long id = ParamUtil.getLong(renderRequest, "id");
			String mode = ParamUtil.getString(renderRequest, "mode");

			renderRequest.setAttribute("school", SchoolChangeLocalServiceUtil.getSchoolChange(id));

			renderRequest.setAttribute("mode", mode);

			return CompetitionCommonConstant.SCHOOL_CHANGE_JSP;

		} catch (Exception e) {
			LOGGER.error(e);
			return CompetitionCommonConstant.SCHOOL_CHANGE_JSP;
		}

	}

}
