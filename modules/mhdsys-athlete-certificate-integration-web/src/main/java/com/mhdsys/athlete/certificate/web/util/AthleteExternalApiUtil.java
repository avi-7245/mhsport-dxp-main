package com.mhdsys.athlete.certificate.web.util;

import com.liferay.document.library.kernel.service.DLAppLocalServiceUtil;
import com.liferay.portal.kernel.log.Log;
import com.liferay.portal.kernel.log.LogFactoryUtil;
import com.liferay.portal.kernel.repository.model.FileEntry;
import com.mhdsys.common.pojo.AthleteSportsCertificateDTO;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.mime.MultipartEntityBuilder;
import org.apache.http.entity.mime.content.InputStreamBody;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.osgi.service.component.annotations.Component;

@Component(immediate = true, service = AthleteExternalApiUtil.class)
public class AthleteExternalApiUtil {

	private static final Log LOGGER = LogFactoryUtil.getLog(AthleteExternalApiUtil.class);

	private static final String API_URL = "https://kridaepramaan.org/api/external/submit";

	public static boolean submitCertificate(AthleteSportsCertificateDTO dto) {

		try (CloseableHttpClient httpClient = HttpClients.createDefault()) {

			HttpPost post = new HttpPost(API_URL);
			MultipartEntityBuilder builder = MultipartEntityBuilder.create();

			// TEXT FIELDS
			builder.addTextBody("sportsPersonName", dto.getSportsPersonName());
			builder.addTextBody("fatherSpouseName", dto.getGuardianName());
			builder.addTextBody("dateOfBirth", dto.getDateOfBirth());
			builder.addTextBody("gender", dto.getGender());
			builder.addTextBody("residentDistrict", dto.getResidentDistrict());
			builder.addTextBody("representingEntity", dto.getRepresenting());
			builder.addTextBody("ageGroup", dto.getAgeCode());
			builder.addTextBody("gameName", dto.getGameName());
			builder.addTextBody("competitionName", dto.getCompetitionName());
			builder.addTextBody("competitionHeldAt", dto.getCompetitionVenue());
			builder.addTextBody("competitionPeriodFrom", formatDate(dto.getCompetitionFromDate()));
			builder.addTextBody("competitionPeriodTo", formatDate(dto.getCompetitionToDate()));
			builder.addTextBody("competitionLevel", dto.getCompetitionLevel());
			builder.addTextBody("positionObtained", dto.getPositionObtained());
			builder.addTextBody("certificateNo", dto.getCertificateNo());

			// FILE FROM DLFILEENTRY (STREAMING)
			FileEntry fileEntry = DLAppLocalServiceUtil.getFileEntry(dto.getAthleteCertificateId());

			InputStreamBody fileBody = new InputStreamBody(fileEntry.getContentStream(),
					ContentType.create("application/pdf"), fileEntry.getFileName());

			builder.addPart("certificate", fileBody);

			post.setEntity(builder.build());

			try (CloseableHttpResponse response = httpClient.execute(post)) {
				int statusCode = response.getStatusLine().getStatusCode();
				LOGGER.info("External API Status Code :: " + statusCode);
				return statusCode == 200 || statusCode == 201;
			}

		} catch (Exception e) {
			LOGGER.error("External API failed", e);
		}

		return false;
	}

	private static String formatDate(Date date) {
		return new SimpleDateFormat("yyyy-MM-dd").format(date);
	}
}
