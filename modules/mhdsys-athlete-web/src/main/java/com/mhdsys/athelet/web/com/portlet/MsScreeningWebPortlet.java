package com.mhdsys.athelet.web.com.portlet;

import com.liferay.portal.kernel.portlet.bridges.mvc.MVCPortlet;
import com.mhdsys.athelet.web.com.constants.MhdsysAthleteWebPortletKeys;

import java.io.IOException;

import javax.portlet.Portlet;
import javax.portlet.PortletException;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;

import org.osgi.service.component.annotations.Component;

@Component(
		property = {
			"com.liferay.portlet.display-category=category.sample",
			"com.liferay.portlet.header-portlet-css=/css/main.css",
			"com.liferay.portlet.instanceable=true",
			"javax.portlet.display-name=MhdsysAthleteMsScreeningDetailsWeb",
			"javax.portlet.init-param.template-path=/",
			"javax.portlet.init-param.view-template=/jsps/ms-screening-details.jsp",
			"com.liferay.portlet.requires-namespaced-parameters=false",
			"javax.portlet.name=" + MhdsysAthleteWebPortletKeys.MSSCREENINGDETAILS,
			"javax.portlet.resource-bundle=content.Language",
			"com.liferay.portlet.header-portal-javascript=/o/mhdsys-dashboard-theme/js/plugins/jquery.min.js",
			"com.liferay.portlet.header-portal-javascript=/o/mhdsys-dashboard-theme/js/plugins/bootstrap.bundle.min.js",
			"com.liferay.portlet.header-portal-javascript=/o/mhdsys-dashboard-theme/js/plugins/jquery.validate.js",
			"com.liferay.portlet.header-portal-javascript=/o/mhdsys-dashboard-theme/js/plugins/additional-methods.js",
			"javax.portlet.security-role-ref=power-user,user"
		},
		service = Portlet.class
	)
public class MsScreeningWebPortlet extends MVCPortlet{

	
	@Override
	public void render(RenderRequest renderRequest, RenderResponse renderResponse)
			throws IOException, PortletException {
		// TODO Auto-generated method stub
		super.render(renderRequest, renderResponse);
	}
}
