package com.mhdsys.registration.web.mvc.resource.commands;

import com.liferay.portal.kernel.json.JSONFactoryUtil;
import com.liferay.portal.kernel.json.JSONObject;
import com.liferay.portal.kernel.log.Log;
import com.liferay.portal.kernel.log.LogFactoryUtil;
import com.liferay.portal.kernel.portlet.bridges.mvc.MVCResourceCommand;
import com.liferay.portal.kernel.servlet.ServletResponseUtil;
import com.liferay.portal.kernel.util.ParamUtil;
import com.liferay.portal.kernel.util.PortalUtil;
import com.mhdsys.registartion.web.constants.RegistrationWebPortletKeys;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.SecureRandom;

import javax.net.ssl.HttpsURLConnection;
import javax.portlet.PortletSession;
import javax.portlet.ResourceRequest;
import javax.portlet.ResourceResponse;
import javax.servlet.http.HttpServletResponse;

import org.osgi.service.component.annotations.Component;

@Component(property = { "javax.portlet.name=" + RegistrationWebPortletKeys.MHDSYSREGISTRATIONSCHOOLCOLLEGEOFFICERWEB,
		"mvc.command.name=/send_otp" }, service = MVCResourceCommand.class)
public class SendOtpResourceCommand implements MVCResourceCommand {

	private static Log LOGGER = LogFactoryUtil.getLog(SendOtpResourceCommand.class);

	@Override
	public boolean serveResource(ResourceRequest request, ResourceResponse response) {

		try {
			String mobile = ParamUtil.getString(request, "mobile");

			String otp = String.valueOf(100000 + new SecureRandom().nextInt(900000));

			PortletSession session = request.getPortletSession();

			session.setAttribute("OTP_VALUE", otp);
			session.setAttribute("OTP_MOBILE", mobile);
			session.setAttribute("OTP_TIME", System.currentTimeMillis());
			session.setAttribute("OTP_VERIFIED", false);

			String content = "Your OTP is " + otp + ". It is valid for 10 mins. Do not share with anyone. DSYSMH";

			sendSms(mobile, content);

			JSONObject json = JSONFactoryUtil.createJSONObject();
			json.put("sent", true);

			HttpServletResponse httpServletResponse = PortalUtil.getHttpServletResponse(response);

			ServletResponseUtil.write(httpServletResponse, json.toString());
		} catch (Exception exception) {
			LOGGER.error("Error while sending OTP", exception);

			JSONObject json = JSONFactoryUtil.createJSONObject();
			json.put("sent", false);

			HttpServletResponse httpServletResponse = PortalUtil.getHttpServletResponse(response);

			try {
				ServletResponseUtil.write(httpServletResponse, json.toString());
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

		return false;
	}

	private static final String SMS_URL = "https://msdgweb.mgov.gov.in/esms/sendsmsrequestDLT";

	private static final String USERNAME = "DSYSMH";
	private static final String PASSWORD = "Dsys@2025";
	private static final String SENDER_ID = "DSYSMH";
	private static final String TEMPLATE_ID = "1007817523491531517";
	private static final String SECRET_KEY = "617836aa-f587-4863-b160-4dc7b5547ca3";

	public String sendSms(String mobileNo, String content) {

		try {
			LOGGER.info("Mobile No : " + mobileNo);

			LOGGER.info("Content : " + content);

			String encryptedPassword = sha1(PASSWORD);

			String hashInput = USERNAME + SENDER_ID + content + SECRET_KEY;
			String key = sha512(hashInput);

			LOGGER.info("");

			String body = "username=" + URLEncoder.encode(USERNAME, "UTF-8") + "&password="
					+ URLEncoder.encode(encryptedPassword, "UTF-8") + "&senderid="
					+ URLEncoder.encode(SENDER_ID, "UTF-8") + "&content=" + URLEncoder.encode(content, "UTF-8")
					+ "&smsservicetype=" + URLEncoder.encode("singlemsg", "UTF-8") + "&mobileno="
					+ URLEncoder.encode(mobileNo, "UTF-8") + "&key=" + URLEncoder.encode(key, "UTF-8") + "&templateid="
					+ URLEncoder.encode(TEMPLATE_ID, "UTF-8");

			LOGGER.info("SMS Request Body: {}" + body);

			byte[] postData = body.getBytes(StandardCharsets.UTF_8);

			System.setProperty("https.protocols", "TLSv1.2");

			URL url = new URL(SMS_URL);
			HttpsURLConnection conn = (HttpsURLConnection) url.openConnection();

			conn.setRequestMethod("POST");
			conn.setDoOutput(true);
			conn.setConnectTimeout(15000);
			conn.setReadTimeout(15000);

			conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
			conn.setRequestProperty("Content-Length", String.valueOf(postData.length));

			try (OutputStream os = conn.getOutputStream()) {
				os.write(postData);
			}

			int responseCode = conn.getResponseCode();
			LOGGER.info("SMS Gateway HTTP Code: {}" + responseCode);

			BufferedReader br = new BufferedReader(new InputStreamReader(
					responseCode == 200 ? conn.getInputStream() : conn.getErrorStream(), StandardCharsets.UTF_8));

			StringBuilder response = new StringBuilder();
			String line;
			while ((line = br.readLine()) != null) {
				response.append(line);
			}

			String finalResponse = response.toString();
			LOGGER.info("SMS Gateway Response: {}" + finalResponse);

			return finalResponse;

		} catch (Exception e) {
			LOGGER.error("SMS sending failed", e);
			return "JAVA_EXCEPTION: " + e.getMessage();
		}
	}

	private static String sha512(String input) throws Exception {
		MessageDigest md = MessageDigest.getInstance("SHA-512");
		byte[] digest = md.digest(input.getBytes(StandardCharsets.UTF_8));
		StringBuilder hex = new StringBuilder();
		for (byte b : digest) {
			hex.append(String.format("%02x", b));
		}
		return hex.toString();
	}

	private static String sha1(String text) throws Exception {
		MessageDigest md = MessageDigest.getInstance("SHA-1");
		byte[] digest = md.digest(text.getBytes("ISO-8859-1"));
		StringBuilder hex = new StringBuilder();
		for (byte b : digest) {
			hex.append(String.format("%02x", b));
		}
		return hex.toString();
	}
}
