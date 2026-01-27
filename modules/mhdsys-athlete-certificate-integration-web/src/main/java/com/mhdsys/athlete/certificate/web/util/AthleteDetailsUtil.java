package com.mhdsys.athlete.certificate.web.util;

import com.liferay.document.library.kernel.model.DLFileEntry;
import com.liferay.document.library.kernel.model.DLFolderConstants;
import com.liferay.document.library.kernel.service.DLAppLocalServiceUtil;
import com.liferay.portal.kernel.bean.BeanPropertiesUtil;
import com.liferay.portal.kernel.log.Log;
import com.liferay.portal.kernel.log.LogFactoryUtil;
import com.liferay.portal.kernel.repository.model.FileEntry;
import com.liferay.portal.kernel.service.ServiceContext;
import com.liferay.portal.kernel.service.ServiceContextFactory;
import com.liferay.portal.kernel.theme.ThemeDisplay;
import com.liferay.portal.kernel.upload.UploadPortletRequest;
import com.liferay.portal.kernel.util.MimeTypesUtil;
import com.liferay.portal.kernel.util.ParamUtil;
import com.liferay.portal.kernel.util.PortalUtil;
import com.liferay.portal.kernel.util.Validator;
import com.mhdsys.common.pojo.AthleteSportsCertificateDTO;
import com.mhdsys.common.util.FileUploadUtil;
import com.mhdsys.schema.model.AthleteSportsCertificate;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.PublicKey;
import java.security.SecureRandom;
import java.security.cert.CertificateFactory;
import java.security.cert.X509Certificate;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Base64;
import java.util.Date;

import javax.crypto.Cipher;
import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import javax.portlet.ResourceRequest;

import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Reference;

@Component(immediate = true, service = AthleteDetailsUtil.class)

public class AthleteDetailsUtil {

	private static Log LOGGER = LogFactoryUtil.getLog(AthleteDetailsUtil.class);
	private static final String DATE_FORMAT = "yyyy-MM-dd";
	private static DateFormat DATE = new SimpleDateFormat("dd/MM/yyyy");

	@Reference
	static FileUploadUtil fileUploadUtil;

	public static Date getDateFromRequest(ResourceRequest request, String paramName) {

		String dateStr = ParamUtil.getString(request, paramName);

		if (Validator.isNull(dateStr)) {
			return null;
		}

		try {
			return new SimpleDateFormat(DATE_FORMAT).parse(dateStr);
		} catch (Exception e) {
			return null;
		}
	}

	public static AthleteSportsCertificateDTO setSportsCertificateDTO(ResourceRequest request,
			ThemeDisplay themeDisplay) throws Exception {

		UploadPortletRequest uploadPortletRequest = PortalUtil.getUploadPortletRequest(request);

		ServiceContext serviceContext = ServiceContextFactory.getInstance(DLFileEntry.class.getName(),
				uploadPortletRequest);

		AthleteSportsCertificateDTO dto = new AthleteSportsCertificateDTO();

		dto.setUserId(themeDisplay.getUserId());
		dto.setGroupId(themeDisplay.getScopeGroupId());
		dto.setCompanyId(themeDisplay.getCompanyId());

		dto.setSportsPersonName(ParamUtil.getString(request, "sportsPersonName"));
		dto.setGuardianName(ParamUtil.getString(request, "guardianName"));
		dto.setDateOfBirth(ParamUtil.getString(request, "dateOfBirth"));
		dto.setGender(ParamUtil.getString(request, "gender"));

		dto.setResidentDistrict(ParamUtil.getString(request, "residentDistrict"));
		dto.setRepresenting(ParamUtil.getString(request, "representing"));

		dto.setAgeCode(ParamUtil.getString(request, "ageCode"));
		dto.setGenderCode(ParamUtil.getString(request, "genderCode"));
		dto.setGameCode(ParamUtil.getString(request, "gameCode"));

		dto.setGameName(ParamUtil.getString(request, "gameName"));

		dto.setCompetitionName(ParamUtil.getString(request, "competitionName"));
		dto.setCompetitionVenue(ParamUtil.getString(request, "competitionVenue"));

		dto.setCompetitionFromDate(getDateFromRequest(request, "competitionFromDate"));

		dto.setCompetitionToDate(getDateFromRequest(request, "competitionToDate"));

		dto.setCompetitionFromDateStr(ParamUtil.getString(request, "competitionFromDate"));
		dto.setCompetitionToDateStr(ParamUtil.getString(request, "competitionToDate"));

		dto.setCompetitionLevel(ParamUtil.getString(request, "competitionLevel"));
		dto.setPositionObtained(ParamUtil.getString(request, "positionObtained"));
		dto.setCertificateNo(ParamUtil.getString(request, "certificateNo"));

		dto.setCreateDate(new Date());

//		// ---------------- FILE UPLOAD (LIFERAY WAY) ----------------
//		File file = uploadPortletRequest.getFile("certificate");
//
//		if (file != null && file.exists() && file.length() > 0) {
//
//			String fileName = uploadPortletRequest.getFileName("certificate");
//			String mimeType = MimeTypesUtil.getContentType(file);
//			String title = fileName;
//			String description = "Athlete Sports Certificate";
//
//			FileEntry fileEntry = DLAppLocalServiceUtil.addFileEntry(themeDisplay.getUserId(),
//					themeDisplay.getScopeGroupId(), DLFolderConstants.DEFAULT_PARENT_FOLDER_ID, fileName, mimeType,
//					title, description, "", file, serviceContext);
//
//			// SAVE FILE ENTRY ID IN DTO
//			dto.setAthleteCertificateId(fileEntry.getFileEntryId());
//		}

		return dto;
	}

//	public static AthleteSportsCertificateDTO setSportsCertificateDTO(ResourceRequest request,
//			ThemeDisplay themeDisplay, UploadPortletRequest uploadPortletRequest) throws Exception {
//
//		ServiceContext serviceContext = ServiceContextFactory.getInstance(DLFileEntry.class.getName(),
//				uploadPortletRequest);
//
//		AthleteSportsCertificateDTO dto = new AthleteSportsCertificateDTO();
//
//		// ---------------- BASIC DETAILS ----------------
//		dto.setUserId(themeDisplay.getUserId());
//		dto.setGroupId(themeDisplay.getScopeGroupId());
//		dto.setCompanyId(themeDisplay.getCompanyId());
//
//		dto.setSportsPersonName(ParamUtil.getString(request, "sportsPersonName"));
//		dto.setGuardianName(ParamUtil.getString(request, "guardianName"));
//		dto.setDateOfBirth(ParamUtil.getString(request, "dateOfBirth"));
//		dto.setGender(ParamUtil.getString(request, "gender"));
//
//		dto.setResidentDistrict(ParamUtil.getString(request, "residentDistrict"));
//		dto.setRepresenting(ParamUtil.getString(request, "representing"));
//
//		dto.setAgeCode(ParamUtil.getString(request, "ageCode"));
//		dto.setGenderCode(ParamUtil.getString(request, "genderCode"));
//		dto.setGameCode(ParamUtil.getString(request, "gameCode"));
//
//		dto.setGameName(ParamUtil.getString(request, "gameName"));
//		dto.setCompetitionName(ParamUtil.getString(request, "competitionName"));
//		dto.setCompetitionVenue(ParamUtil.getString(request, "competitionVenue"));
//
//		dto.setCompetitionFromDate(getDateFromRequest(request, "competitionFromDate"));
//		dto.setCompetitionToDate(getDateFromRequest(request, "competitionToDate"));
//
//		dto.setCompetitionFromDateStr(ParamUtil.getString(request, "competitionFromDate"));
//		dto.setCompetitionToDateStr(ParamUtil.getString(request, "competitionToDate"));
//
//		dto.setCompetitionLevel(ParamUtil.getString(request, "competitionLevel"));
//		dto.setPositionObtained(ParamUtil.getString(request, "positionObtained"));
//		dto.setCertificateNo(ParamUtil.getString(request, "certificateNo"));
//
//		dto.setCreateDate(new Date());
//
//		// ---------------- FILE UPLOAD (LIFERAY WAY) ----------------
//		File file = uploadPortletRequest.getFile("certificate");
//
//		if (file != null && file.exists() && file.length() > 0) {
//
//			String fileName = uploadPortletRequest.getFileName("certificate");
//			String mimeType = MimeTypesUtil.getContentType(file);
//			String title = fileName;
//			String description = "Athlete Sports Certificate";
//
//			FileEntry fileEntry = DLAppLocalServiceUtil.addFileEntry(themeDisplay.getUserId(),
//					themeDisplay.getScopeGroupId(), DLFolderConstants.DEFAULT_PARENT_FOLDER_ID, fileName, mimeType,
//					title, description, "", file, serviceContext);
//
//			// SAVE FILE ENTRY ID IN DTO
//			dto.setAthleteCertificateId(fileEntry.getFileEntryId());
//	}
//
//	return dto;}

	public AthleteSportsCertificateDTO getSportsCertificateDTO(AthleteSportsCertificate athleteSportsCertificate,
			ThemeDisplay themeDisplay) throws Exception {

		AthleteSportsCertificateDTO dto = new AthleteSportsCertificateDTO();

		BeanPropertiesUtil.copyProperties(athleteSportsCertificate, dto);

		dto.setCompetitionFromDateStr(DATE.format(athleteSportsCertificate.getCompetitionFromDate()));
		dto.setCompetitionToDateStr(DATE.format(athleteSportsCertificate.getCompetitionFromDate()));

		return dto;
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Encryption
//	private static final String UIDAI_BASE64_IV = "IV_VALUE_PROVIDED_BY_UIDAI";
	private static final String UIDAI_BASE64_IV = generateIV();
	private static final String UIDAI_PASSWORD = "test@123";

	private static final String UIDAI_CERT_CONTENT = "MIIGazCCBVOgAwIBAgIIbPGVminrrCAwDQYJKoZIhvcNAQELBQAwgYMxCzAJBgNV\n"
			+ "BAYTAklOMSowKAYDVQQKEyFRQ0lEIFRlY2hub2xvZ2llcyBQcml2YXRlIExpbWl0\n"
			+ "ZWQxHTAbBgNVBAsTFENlcnRpZnlpbmcgQXV0aG9yaXR5MSkwJwYDVQQDEyBJRFNp\n"
			+ "Z24gc3ViIENBIGZvciBDb25zdW1lcnMgMjAyMjAeFw0yNTEyMjgxNTU4MDBaFw0y\n"
			+ "NzEyMjgxNTU4MDBaMIHlMQswCQYDVQQGEwJJTjEiMCAGA1UEChMZR09WRVJOTUVO\n"
			+ "VCBPRiBNQUhBUkFTSFRSQTEMMAoGA1UECxMDRElUMQ8wDQYDVQQREwY0MDAwMzIx\n"
			+ "FDASBgNVBAgTC01haGFyYXNodHJhMQ8wDQYDVQQJEwZNdW1iYWkxSTBHBgNVBAUT\n"
			+ "QEMwRjc4RTMxRTFCOTcxNDZEODIyODQ2OUM4N0NFRURCQjkxNzMxMEQzODcyQTU0\n"
			+ "NTBBMjA1MDRCNzhFQzRBRDExITAfBgNVBAMTGFNBTkpBWSBTSFJJUEFUUkFPIEtB\n"
			+ "VEtBUjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAJC27KOdZpWsTGt6\n"
			+ "HlZSo8jZm0VL45q72ZTNHOjEUT4g1iQykn/lnto3N3XYyyGb+wnaeuUlH814nkag\n"
			+ "MUSYP98HFLhj2IKYZRIYVlLEwJMhYdUU4Vhky9yDDQqyTX8bIVNuRs2mMAeUWle5\n"
			+ "6+foWsuFi4/lCSUYd/xiSx3+9XUO+2ZXptiJCbpFih5FQEYO+vN9U7TRmrUwIs+J\n"
			+ "3PbXPpK/ZCgcevpwiIZIaJjOr6k95SrzYJR3DPmBKgbUsvlh9nPeS8sU9QD+473N\n"
			+ "9wlCRnU5HjaTt4CElkJ0F9xGy16Ys2zQhKspruoyT3bYub6d+Rlx68mh4nRBED/T\n"
			+ "hE3AgEUCAwEAAaOCAn0wggJ5MIGOBggrBgEFBQcBAQSBgTB/MFcGCCsGAQUFBzAC\n"
			+ "hktodHRwOi8vaWRzaWduY2EuY29tL3JlcG9zaXRvcnkvY2VydGlmaWNhdGVzL0lE\n"
			+ "U2lnbnN1YkNBZm9yQ29uc3VtZXJzMjAyMi5jZXIwJAYIKwYBBQUHMAGGGGh0dHA6\n"
			+ "Ly9vY3NwLmlkc2lnbmNhLmNvbTAdBgNVHQ4EFgQU6LDPPNZJhmmigWehGfyzGlKz\n"
			+ "xxswDAYDVR0TAQH/BAIwADAfBgNVHSMEGDAWgBTGPfrT38cGGf0xAcBlDdWdFauj\n"
			+ "ZjCB9QYDVR0gBIHtMIHqMDgGBmCCZGQCAzAuMCwGCCsGAQUFBwICMCAMHkNsYXNz\n"
			+ "IDMgRW5jcnlwdGlvbiBDZXJ0aWZpY2F0ZTBDBgdggmRkARICMDgwNgYIKwYBBQUH\n"
			+ "AgEWKmh0dHBzOi8vaWRzaWduY2EuY29tL0NQUy9JRFNpZ25fQ0FfQ1BTLnBkZjBp\n"
			+ "BgZggmRkCgMwXzBdBggrBgEFBQcCAjBRDE9Mb25nIFRlcm0gT3JnYW5pc2F0aW9u\n"
			+ "YWwgZUtZQyBDZXJ0aWZpY2F0ZSBpc3N1ZWQgYnkgSURTaWduIENlcnRpZnlpbmcg\n"
			+ "QXV0aG9yaXR5MFQGA1UdHwRNMEswSaBHoEWGQ2h0dHA6Ly9pZHNpZ25jYS5jb20v\n"
			+ "cmVwb3NpdG9yeS9jcmxzL0lEU2lnbnN1YkNBZm9yQ29uc3VtZXJzMjAyMi5jcmww\n"
			+ "DgYDVR0PAQH/BAQDAgUgMBUGA1UdJQQOMAwGCisGAQQBgjcKAwQwIwYDVR0RBBww\n"
			+ "GoEYc2FuamF5LmthdGthckBtYWhhaXQub3JnMA0GCSqGSIb3DQEBCwUAA4IBAQBW\n"
			+ "xXDfq0MnAr2uotwxvF+GCmjQR2I338yiMbVD7nCIIVDWntG8OSuvdDiyNFKhE4xh\n"
			+ "MFBi9dB9XghzW6BGA3C6fDyYnwcKyMzY4K7vll7QT/C0gn/X3l82PE3j2dVJHy8C\n"
			+ "kYtxXMFmhlfBA9i8WybhqzhSCpfnfsvML20CBcylp/B1oKyaKcwx19kmlvopjUf/\n"
			+ "o2oykjiBeHAiu99qoD2EOkjM0kC/1NU9KA1QScW9CXBpXnVcL1ti96fY3w2nkP+Q\n"
			+ "Drw578R57iqMXw6zMLU+tQwS5vYZIcVK9+jDmwUJiYO85mMC2k75h+JXCHbe0lLN\n" + "q8SlENH69VUSqoZfrkRT";

	public void encryption() {

		try {
			String txn = generateTxn();
			String uid = "894378647829";

			String aesKeyBase64 = generateAesKey();

			String encPassword = aesEncrypt(UIDAI_PASSWORD, aesKeyBase64);
			String encUid = aesEncrypt(uid, aesKeyBase64);

			String auaSkey = generateAuaSkey(aesKeyBase64);

			String auaToken = generateAuaToken(encPassword, encUid, aesKeyBase64, txn);

			LOGGER.info("AES KEY        : " + aesKeyBase64);
			LOGGER.info("ENC PASSWORD   : " + encPassword);
			LOGGER.info("ENC UID        : " + encUid);
			LOGGER.info("AUASKEY        : " + auaSkey);
			LOGGER.info("AUATOKEN       : " + auaToken);

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private static String generateTxn() {
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss");
		return "MAHA-OTP-" + LocalDateTime.now().format(formatter);
	}

	private static String generateAesKey() throws Exception {
		KeyGenerator keyGen = KeyGenerator.getInstance("AES");
		keyGen.init(256);
		SecretKey key = keyGen.generateKey();
		return Base64.getEncoder().encodeToString(key.getEncoded());
	}

	private static String generateIV() {
		byte[] iv = new byte[16];
		new SecureRandom().nextBytes(iv);
		return Base64.getEncoder().encodeToString(iv);
	}

	private static String aesEncrypt(String plainText, String base64Key) throws Exception {

		byte[] keyBytes = Base64.getDecoder().decode(base64Key);
		byte[] ivBytes = Base64.getDecoder().decode(UIDAI_BASE64_IV);

		Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
		cipher.init(Cipher.ENCRYPT_MODE, new SecretKeySpec(keyBytes, "AES"), new IvParameterSpec(ivBytes));

		return Base64.getEncoder().encodeToString(cipher.doFinal(plainText.getBytes(StandardCharsets.UTF_8)));
	}

	private static String generateAuaSkey(String base64AesKey) throws Exception {

		byte[] certBytes = Base64.getDecoder().decode(UIDAI_CERT_CONTENT.replaceAll("\\s+", ""));

		X509Certificate cert = (X509Certificate) CertificateFactory.getInstance("X.509")
				.generateCertificate(new ByteArrayInputStream(certBytes));

		PublicKey publicKey = cert.getPublicKey();

		Cipher cipher = Cipher.getInstance("RSA/ECB/PKCS1Padding");
		cipher.init(Cipher.ENCRYPT_MODE, publicKey);

		byte[] aesKeyBytes = Base64.getDecoder().decode(base64AesKey);

		return Base64.getEncoder().encodeToString(cipher.doFinal(aesKeyBytes));
	}

	private static String generateAuaToken(String encPwd, String encUid, String base64AesKey, String txn)
			throws Exception {

		String shaKey = sha256(base64AesKey);
		String shaTxn = sha256(txn);

		String data = encPwd + "~" + encUid + "~" + shaKey + "~" + shaTxn;

		return sha256(data.toLowerCase());
	}

	private static String sha256(String input) throws Exception {
		MessageDigest md = MessageDigest.getInstance("SHA-256");
		return Base64.getEncoder().encodeToString(md.digest(input.getBytes(StandardCharsets.UTF_8)));
	}

}
