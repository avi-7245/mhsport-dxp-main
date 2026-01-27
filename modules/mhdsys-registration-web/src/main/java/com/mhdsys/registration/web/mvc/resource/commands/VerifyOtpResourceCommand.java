package com.mhdsys.registration.web.mvc.resource.commands;

import com.liferay.portal.kernel.json.JSONFactoryUtil;
import com.liferay.portal.kernel.json.JSONObject;
import com.liferay.portal.kernel.portlet.bridges.mvc.MVCResourceCommand;
import com.liferay.portal.kernel.servlet.ServletResponseUtil;
import com.liferay.portal.kernel.util.ParamUtil;
import com.liferay.portal.kernel.util.PortalUtil;
import com.mhdsys.registartion.web.constants.RegistrationWebPortletKeys;

import javax.portlet.PortletSession;
import javax.portlet.ResourceRequest;
import javax.portlet.ResourceResponse;
import javax.servlet.http.HttpServletResponse;

import org.osgi.service.component.annotations.Component;

@Component(property = { "javax.portlet.name=" + RegistrationWebPortletKeys.MHDSYSREGISTRATIONSCHOOLCOLLEGEOFFICERWEB,
		"mvc.command.name=/verify_otp" }, service = MVCResourceCommand.class)
public class VerifyOtpResourceCommand implements MVCResourceCommand {

	@Override
	public boolean serveResource(ResourceRequest request, ResourceResponse response) {
		try {
			String userOtp = ParamUtil.getString(request, "otp");

			PortletSession session = request.getPortletSession();

			String sessionOtp = (String) session.getAttribute("OTP_VALUE");
			Long otpTime = (Long) session.getAttribute("OTP_TIME");

			boolean valid = false;

			if (sessionOtp != null && otpTime != null) {
				long diff = System.currentTimeMillis() - otpTime;

				if (diff <= 10 * 60 * 1000 && sessionOtp.equals(userOtp)) {
					valid = true;
					session.setAttribute("OTP_VERIFIED", true);
					session.removeAttribute("OTP_VALUE");
				}
			}

			JSONObject json = JSONFactoryUtil.createJSONObject();
			json.put("valid", valid);

			HttpServletResponse httpServletResponse = PortalUtil.getHttpServletResponse(response);

			ServletResponseUtil.write(httpServletResponse, json.toString());
		} catch (Exception exception) {
			exception.printStackTrace();
		}
		return false;
	}
}
