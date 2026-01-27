package com.mhdsys.registration.web.util;

import com.liferay.document.library.kernel.model.DLFileEntry;
import com.liferay.portal.kernel.log.Log;
import com.liferay.portal.kernel.log.LogFactoryUtil;
import com.liferay.portal.kernel.service.ServiceContext;
import com.liferay.portal.kernel.service.ServiceContextFactory;
import com.liferay.portal.kernel.service.UserLocalServiceUtil;
import com.liferay.portal.kernel.theme.ThemeDisplay;
import com.liferay.portal.kernel.upload.UploadPortletRequest;
import com.liferay.portal.kernel.util.Base64;
import com.liferay.portal.kernel.util.ParamUtil;
import com.liferay.portal.kernel.util.PortalUtil;
import com.liferay.portal.kernel.util.PropsUtil;
import com.liferay.portal.kernel.util.Validator;
import com.mhdsys.common.pojo.AwardApplicationCommonDTO;
import com.mhdsys.common.pojo.RegistrationDTO;
import com.mhdsys.common.pojo.SchoolCollegeOfficerRegistrationCommonDTO;
import com.mhdsys.common.pojo.UserInformationModel;
import com.mhdsys.common.util.DateConversionUtil;
import com.mhdsys.common.util.FileUploadUtil;
import com.mhdsys.common.utility.constants.CommonUtilityConstant;
import com.mhdsys.common.utility.constants.RoleConstant;
import com.mhdsys.schema.service.OfficerDesignationLocalServiceUtil;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Date;
import java.util.Map;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import javax.net.ssl.HttpsURLConnection;
import javax.portlet.ResourceRequest;

import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Reference;

@Component(immediate = true, service = RegistrationUtil.class)
public class RegistrationUtil {

	private static Log LOGGER = LogFactoryUtil.getLog(RegistrationUtil.class);

	@Reference
	DateConversionUtil dateConversionUtil;
	@Reference
	FileUploadUtil fileUploadUtil;

	private static final Map<String, String> REG_TYPE = Map.of("SchoolCollege", "MHSCHL", "SportsAssociation", "MHSPAS",
			"SportsComplex", "MHSPCO", "YouthInstitute", "MHYTIN", "Desk Officer", "MHSDDO", "LocalSelfGov", "MHLSGV",
			"Sport Person", "MHSPTP", "Coach", "MHSPTC");

	public String decrypt(String value) throws NoSuchAlgorithmException, NoSuchPaddingException, InvalidKeyException,
			InvalidAlgorithmParameterException, IllegalBlockSizeException, BadPaddingException {
		IvParameterSpec iv = new IvParameterSpec(PropsUtil.get("cipher.initVector").getBytes(StandardCharsets.UTF_8));
		SecretKeySpec skeySpec = new SecretKeySpec(PropsUtil.get("cipher.key").getBytes(StandardCharsets.UTF_8), "AES");

		Cipher cipher = Cipher.getInstance(PropsUtil.get("cipher.instance"));
		cipher.init(Cipher.DECRYPT_MODE, skeySpec, iv);
		byte[] original = cipher.doFinal(Base64.decode(value));

		return new String(original);
	}

	public UserInformationModel setUserInformationModule(ResourceRequest resourceRequest, String regType) {

		UserInformationModel userInformationModel = new UserInformationModel();
		try {
			LOGGER.info("reg type: " + regType);

			if (regType.equalsIgnoreCase("Desk Officer")) {
				userInformationModel.setFirstName(ParamUtil.getString(resourceRequest, "departmentName"));
			} else if (regType.equalsIgnoreCase("Association")) {
				userInformationModel.setFirstName(ParamUtil.getString(resourceRequest, "associationName"));
			} else if (regType.equalsIgnoreCase("LocalSelfGov")) {
				userInformationModel.setFirstName(ParamUtil.getString(resourceRequest, "departmentName"));
			} else if (regType.equalsIgnoreCase("SportsComplex")) {
				userInformationModel.setFirstName(ParamUtil.getString(resourceRequest, "departmentName"));
			} else if (regType.equalsIgnoreCase("YouthInstitute")) {
				userInformationModel.setFirstName(ParamUtil.getString(resourceRequest, "organizationName"));
			} else {
				userInformationModel.setFirstName(ParamUtil.getString(resourceRequest, "firstName"));
			}

			userInformationModel.setLastName(".");
			userInformationModel.setEmail(ParamUtil.getString(resourceRequest, "email"));
			userInformationModel.setScreenName(REG_TYPE.getOrDefault(regType, "Default"));

		} catch (Exception e) {
			LOGGER.error(e.getMessage(), e);
		}
		return userInformationModel;
	}

	public UserInformationModel setInformationModule(ResourceRequest resourceRequest, String regType) {

		UserInformationModel userInformationModel = new UserInformationModel();
		try {
			LOGGER.info("reg type: " + regType);
			userInformationModel.setFirstName(ParamUtil.getString(resourceRequest, "firstName"));
			userInformationModel.setLastName(".");
			userInformationModel.setEmail(ParamUtil.getString(resourceRequest, "email"));
			userInformationModel.setScreenName(REG_TYPE.getOrDefault(regType, "Default"));

		} catch (Exception e) {
			LOGGER.error(e.getMessage(), e);
		}
		return userInformationModel;
	}

	public RegistrationDTO setRegistrationDTO(ResourceRequest resourceRequest, ThemeDisplay themeDisplay) {

		RegistrationDTO registrationDTO = new RegistrationDTO();
		try {
			LOGGER.info("Registration Util ::: ");
			registrationDTO.setState(ParamUtil.getInteger(resourceRequest, "state"));
			registrationDTO.setDivision(ParamUtil.getInteger(resourceRequest, "division"));
			registrationDTO.setDistrict(ParamUtil.getInteger(resourceRequest, "district"));
			registrationDTO.setTaluka(ParamUtil.getInteger(resourceRequest, "taluka"));
			registrationDTO.setFirstName(ParamUtil.getString(resourceRequest, "firstName"));
			registrationDTO.setPrincipalName(ParamUtil.getString(resourceRequest, "principalName"));
			registrationDTO.setSportsTeacher(ParamUtil.getString(resourceRequest, "sportsTeacher"));
			registrationDTO.setSchoolRegNo(ParamUtil.getString(resourceRequest, "schoolRegNo"));
			registrationDTO.setUdiseCode(ParamUtil.getString(resourceRequest, "udiseCode"));

//			registrationDTO.setAadharNo(ParamUtil.getString(resourceRequest, "aadharNo"));
			try {
				String encryptedAadhaar = ParamUtil.getString(resourceRequest, "aadharNo");
				String decryptedAadhaar = decrypt(encryptedAadhaar);
				registrationDTO.setAadharNo(decryptedAadhaar);
				LOGGER.info("encryptedAadhaar::::::" + encryptedAadhaar);
				LOGGER.info("decryptedAadhaar::::::" + decryptedAadhaar);
			} catch (Exception e) {
				e.printStackTrace();
			}
			registrationDTO.setMobileNo(ParamUtil.getString(resourceRequest, "mobileNo"));
			registrationDTO.setLandlineNo(ParamUtil.getString(resourceRequest, "landlineNo"));
			registrationDTO.setEmail(ParamUtil.getString(resourceRequest, "email"));
			registrationDTO.setWebsite(ParamUtil.getString(resourceRequest, "website"));

			registrationDTO.setDepartmentName(ParamUtil.getString(resourceRequest, "departmentName"));
			registrationDTO.setSubDepartment(ParamUtil.getString(resourceRequest, "subDepartment"));
			registrationDTO.setOfficialName(ParamUtil.getString(resourceRequest, "officialName"));
			registrationDTO.setDesignation(ParamUtil.getString(resourceRequest, "designation"));
			registrationDTO.setSecretaryOrgName(ParamUtil.getString(resourceRequest, "secretaryOrgName"));
			registrationDTO.setOrganizationName(ParamUtil.getString(resourceRequest, "organizationName"));
			String foundingDateStr = ParamUtil.getString(resourceRequest, "foundingDate");
			if (Validator.isNotNull(foundingDateStr)) {
				registrationDTO.setFoundingDate(dateConversionUtil.convertStringToDateFormat(foundingDateStr));
			}
			registrationDTO.setSecretaryName(ParamUtil.getString(resourceRequest, "secretaryName"));
			registrationDTO.setAssociationRegNo(ParamUtil.getString(resourceRequest, "associationRegNo"));
			registrationDTO.setAssociationName(ParamUtil.getString(resourceRequest, "associationName"));
			registrationDTO.setEmployeeId(ParamUtil.getLong(resourceRequest, "employeeId"));

			registrationDTO.setCreatedDate(new Date());
			registrationDTO.setModifiedDate(new Date());
			registrationDTO.setUserId(themeDisplay.getUserId());
			LOGGER.info("Registration obj: " + registrationDTO);
		} catch (Exception e) {
			LOGGER.error(e.getMessage(), e);
		}
		return registrationDTO;

	}

	public SchoolCollegeOfficerRegistrationCommonDTO setSchoolCollegeOfficerReg(ResourceRequest resourceRequest,
			ThemeDisplay themeDisplay) {

		SchoolCollegeOfficerRegistrationCommonDTO schoolCollegeOfficer = new SchoolCollegeOfficerRegistrationCommonDTO();
		try {
			LOGGER.info("schoolCollegeOfficer Util ::: ");
			schoolCollegeOfficer.setFirstName(ParamUtil.getString(resourceRequest, "firstName"));
			schoolCollegeOfficer.setLastName(ParamUtil.getString(resourceRequest, "lastName"));
			LOGGER.info("email: " + ParamUtil.getString(resourceRequest, "email"));
			schoolCollegeOfficer.setEmailId(ParamUtil.getString(resourceRequest, "email"));
			schoolCollegeOfficer.setMothersName(ParamUtil.getString(resourceRequest, "mothersName"));
			schoolCollegeOfficer.setFathersName(ParamUtil.getString(resourceRequest, "fathersName"));
			schoolCollegeOfficer.setCurrentDesignation(ParamUtil.getLong(resourceRequest, "currentDesignation"));
			schoolCollegeOfficer.setGender(ParamUtil.getLong(resourceRequest, "gender"));
			schoolCollegeOfficer.setSchoolOrCollegeName(ParamUtil.getString(resourceRequest, "schoolOrCollegeName"));

			schoolCollegeOfficer.setPenId(ParamUtil.getString(resourceRequest, "penId"));
			schoolCollegeOfficer.setAadharNumber(ParamUtil.getString(resourceRequest, "aadharNumber"));
//			try {
//				String encryptedAadhaar = ParamUtil.getString(resourceRequest, "aadharNumber");
//				String decryptedAadhaar = decrypt(encryptedAadhaar);
//
//				schoolCollegeOfficer.setAadharNumber(decryptedAadhaar);
//
//			} catch (Exception e) {
//				e.printStackTrace();
//			}
			schoolCollegeOfficer.setMobileNumber(ParamUtil.getString(resourceRequest, "mobileNumber"));
			schoolCollegeOfficer.setType(ParamUtil.getString(resourceRequest, "type"));
			schoolCollegeOfficer.setCreateDate(new Date());
			schoolCollegeOfficer.setModifiedDate(new Date());
			schoolCollegeOfficer.setUserId(themeDisplay.getUserId());
			schoolCollegeOfficer.setCurrentDesignationName(Validator.isNotNull(OfficerDesignationLocalServiceUtil
					.getOfficerDesignation(schoolCollegeOfficer.getCurrentDesignation()))
							? OfficerDesignationLocalServiceUtil
									.getOfficerDesignation(schoolCollegeOfficer.getCurrentDesignation()).getName()
							: "");
			UploadPortletRequest uploadPortletRequest = PortalUtil.getUploadPortletRequest(resourceRequest);
//			ServiceContext serviceContext = ServiceContextFactory.getInstance(DLFileEntry.class.getName(),
//					uploadPortletRequest);
//			long aadharaadharCardRecieptId = fileUploadUtil.uploadFile(uploadPortletRequest, "aadharCardReciept",
//					CommonUtilityConstant.REGISTRATION_FOLDER, serviceContext);
//			LOGGER.info("aadharaadharCardRecieptId: " + aadharaadharCardRecieptId);
//			schoolCollegeOfficer.setAadharCardRecieptFileEntryId(aadharaadharCardRecieptId);

			ServiceContext serviceContext = ServiceContextFactory.getInstance(DLFileEntry.class.getName(),
					uploadPortletRequest);

			long companyId = themeDisplay.getCompanyId();
			long adminUserId = UserLocalServiceUtil.getDefaultUserId(companyId);

			serviceContext.setUserId(adminUserId);
			serviceContext.setAddGroupPermissions(true);
			serviceContext.setAddGuestPermissions(false);

			long aadharaadharCardRecieptId = fileUploadUtil.uploadFile(uploadPortletRequest, "aadharCardReciept",
					CommonUtilityConstant.REGISTRATION_FOLDER, serviceContext);

			LOGGER.info("Aadhaar FileEntryId ::: " + aadharaadharCardRecieptId);
			schoolCollegeOfficer.setAadharCardRecieptFileEntryId(aadharaadharCardRecieptId);

//			fileUploadUtil.setFilePermissionByRoleName(aadharaadharCardRecieptId, serviceContext, themeDisplay,
//					RoleConstant.SCHOOLCOLLEGE);
//			fileUploadUtil.setFilePermissionByRoleName(aadharaadharCardRecieptId, serviceContext, themeDisplay,
//					RoleConstant.GUEST);
			LOGGER.info("schoolCollegeOfficer obj: " + schoolCollegeOfficer);
		} catch (Exception e) {
			LOGGER.error(e.getMessage(), e);
		}
		return schoolCollegeOfficer;

	}

	public AwardApplicationCommonDTO setAwardApplicationCommonDTO(ResourceRequest resourceRequest,
			ThemeDisplay themeDisplay) {

		AwardApplicationCommonDTO awardApplicationDTO = new AwardApplicationCommonDTO();
		try {
			LOGGER.info("awardApplicationDTO Util ::: ");
			awardApplicationDTO.setCompetitionLevelId(ParamUtil.getLong(resourceRequest, "competitionLevel"));
			awardApplicationDTO.setCompetitionName(ParamUtil.getString(resourceRequest, "competitionName"));
			awardApplicationDTO.setCompetitionPlace(ParamUtil.getString(resourceRequest, "competitionPlace"));
			awardApplicationDTO.setParticipationYear(ParamUtil.getString(resourceRequest, "participationYear"));
			awardApplicationDTO.setSportId(ParamUtil.getLong(resourceRequest, "sportsName"));
			awardApplicationDTO.setCountryOfCompetition(ParamUtil.getString(resourceRequest, "countryOfCompetition"));
			awardApplicationDTO.setCityOfCompetition(ParamUtil.getString(resourceRequest, "cityOfCompetition"));
			awardApplicationDTO.setMedalRecieved(ParamUtil.getString(resourceRequest, "medalRecieved"));
			awardApplicationDTO.setCategory(ParamUtil.getLong(resourceRequest, "category"));
			awardApplicationDTO.setHighestPerformance(ParamUtil.getString(resourceRequest, "highestPerformance"));
			awardApplicationDTO.setCoachName(ParamUtil.getString(resourceRequest, "coachName"));
			awardApplicationDTO.setUserType(ParamUtil.getString(resourceRequest, "userType"));

			awardApplicationDTO.setCompetitionStartDate(dateConversionUtil
					.convertStringToDateFormat(ParamUtil.getString(resourceRequest, "competitionStartDate")));
			awardApplicationDTO.setCompetitionEndDate(dateConversionUtil
					.convertStringToDateFormat(ParamUtil.getString(resourceRequest, "competitionEndDate")));
			awardApplicationDTO.setNoOfMedalRecieved(ParamUtil.getLong(resourceRequest, "noOfMedals"));
			awardApplicationDTO.setNoOfParticipation(ParamUtil.getLong(resourceRequest, "sportsPersons"));
			LOGGER.info("Data  Second ::: " + ParamUtil.getString(resourceRequest, "competitionName"));
			LOGGER.info("DTO ::: " + awardApplicationDTO);
			awardApplicationDTO.setCreateDate(new Date());
			awardApplicationDTO.setModifiedDate(new Date());
			awardApplicationDTO.setUserId(themeDisplay.getUserId());
			UploadPortletRequest uploadPortletRequest = PortalUtil.getUploadPortletRequest(resourceRequest);
			ServiceContext serviceContext = ServiceContextFactory.getInstance(DLFileEntry.class.getName(),
					uploadPortletRequest);
			long competitionCertificateId = fileUploadUtil.uploadFile(uploadPortletRequest, "competitionCertificate",
					CommonUtilityConstant.REGISTRATION_FOLDER, serviceContext);
			LOGGER.info("competitionCertificateId: " + competitionCertificateId);
			awardApplicationDTO.setCertificateId(competitionCertificateId);
			fileUploadUtil.setFilePermissionByRoleName(competitionCertificateId, serviceContext, themeDisplay,
					RoleConstant.SCHOOLCOLLEGE);
			LOGGER.info("awardApplicationDTO obj: " + awardApplicationDTO);
		} catch (Exception e) {
			LOGGER.error(e.getMessage(), e);
		}
		return awardApplicationDTO;

	}

	private static final String SMS_URL = "https://msdgweb.mgov.gov.in/esms/sendsmsrequestDLT";

	private static final String USERNAME = "DSYSMH";
	private static final String PASSWORD = "Dsys@2025";
	private static final String SENDER_ID = "DSYSMH";
//	private static final String TEMPLATE_ID = "1007492958324334861";
	private static final String TEMPLATE_ID = "1007874805354771410";
	private static final String SECRET_KEY = "617836aa-f587-4863-b160-4dc7b5547ca3";

	public String sendSms(String mobileNo, String registrationId, String emailAddress, String userPassword) {

		try {
			LOGGER.info("Mobile No : " + mobileNo);

			String content = "Dear User, Registration with DSYSMH has been completed. " + "User ID: " + emailAddress
					+ " " + "Password: " + userPassword + " "
					+ "Login for more info: https://sports.maharashtra.gov.in/ " + "Regards,";

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
